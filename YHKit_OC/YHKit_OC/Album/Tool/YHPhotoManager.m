//
//  YHPhotoManager.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/25.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHPhotoManager.h"

#import <Photos/Photos.h>

#import "YHPhotoListModel.h"

@implementation YHPhotoManager


+ (void)getPhotoAlbumListWithCompletionBlock:(void (^)(NSArray<YHPhotoListModel *> *))completionBlock{
    PHFetchOptions *option = [[PHFetchOptions alloc] init];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];//只有照片
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];//降序排列，最新照片在最上面
    
    PHFetchResult<PHAssetCollection *> *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHFetchResult<PHAssetCollection *> *streamAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumMyPhotoStream options:nil];
    PHFetchResult<PHAssetCollection *> *userAlbums = (PHFetchResult<PHAssetCollection *> *)[PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    PHFetchResult<PHAssetCollection *> *syncedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumSyncedAlbum options:nil];
    PHFetchResult<PHAssetCollection *> *sharedAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumCloudShared options:nil];
    NSArray<PHFetchResult<PHAssetCollection *> *> *arrAllAlbums = @[smartAlbums, streamAlbums, userAlbums, syncedAlbums, sharedAlbums];
    
    NSMutableArray<YHPhotoListModel *> *arr = [NSMutableArray array];
    [arrAllAlbums enumerateObjectsUsingBlock:^(PHFetchResult<PHAssetCollection *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj isKindOfClass:[PHAssetCollection class]]) {
                return ;
            }
            PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:obj options:option];
            if (!result.count || result.count == 0) {
                return;
            }
            
            NSString *albumTitle = obj.localizedTitle;//相册标题
            NSInteger count = result.count;//该相册里面照片数量
            PHAsset *headAsset = result.firstObject;//该相册的封面asset
            
            YHPhotoListModel *model = [[YHPhotoListModel alloc] init];
            model.albumTitle = albumTitle;
            model.count = count;
            model.headAsset = headAsset;
            model.result = result;
            
            if (obj.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                [arr insertObject:model atIndex:0];
            } else {
                [arr addObject:model];
            }
        }];
    }];
    completionBlock ? completionBlock(arr) : nil;
}

+ (PHImageRequestID)requestImageWithAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode deliveryMode:(PHImageRequestOptionsDeliveryMode)deliveryMode contentMode:(PHImageContentMode)contentMode completion:(void (^)(UIImage * _Nullable, NSDictionary * _Nullable))completion{
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = resizeMode;
    option.deliveryMode = deliveryMode;
    option.networkAccessAllowed = NO;//不与网络进行交互
    option.synchronous = NO;//不同步
    return [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:contentMode options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey];
        if (downloadFinined) {
            completion ? completion(result,info) : nil;
        } else {
            completion ? completion(nil,info) : nil;
        }
    }];
}





@end
