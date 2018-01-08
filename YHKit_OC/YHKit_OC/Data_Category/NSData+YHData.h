//
//  NSData+YHData.h
//  BlockCDN_Pre
//
//  Created by 银河 on 2017/12/29.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (YHData)
- (NSData *)yh_AES256EncryptWithKey:(NSString *)key;
- (NSData *)yh_AES256DecryptWithKey:(NSString *)key;
@end
