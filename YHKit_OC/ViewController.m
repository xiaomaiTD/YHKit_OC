//
//  ViewController.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/3.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "ViewController.h"


#import "YHDeviceUtil.h"
#import "YHKit_OC.h"

#define YHRSA_PUBLIC    @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5EzIpCQHrC2h/qbFIGHQon1BQg7eklHbfzs2FWkSgc/7ExMt9Xp6iLf/OMhNUkr2HIHFzlZg7d6s09sYqmgvp4ZntbxaooqEf/vswaVUsyzirYjcXjQuW9VKjkbGmqzanSFt1jqqYe4rU6NMXFWP6GB3FYe1CkdiJO4r1wa8D2sDOi0vtt0eI0fYH2cXbTv01HdgjN6CIEhK36kRBnTAgpd8+tza7v3T1mlBYJovPNbBqwttly/eqHe/79Uxy3g/kEHAl8mqJGZJM0ziW8ksB5AZ6Ayyh29JRaJjMIh9VR+4FaG5Ww+91t363X6bmN+lUYelApXzXJqZLdOeJ/dbBwIDAQAB"



#define YHRSA_PRIVATE   @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDkTMikJAesLaH+psUgYdCifUFCDt6SUdt/OzYVaRKBz/sTEy31enqIt/84yE1SSvYcgcXOVmDt3qzT2xiqaC+nhme1vFqiioR/++zBpVSzLOKtiNxeNC5b1UqORsaarNqdIW3WOqph7itTo0xcVY/oYHcVh7UKR2Ik7ivXBrwPawM6LS+23R4jR9gfZxdtO/TUd2CM3oIgSErfqREGdMCCl3z63Nru/dPWaUFgmi881sGrC22XL96od7/v1THLeD+QQcCXyaokZkkzTOJbySwHkBnoDLKHb0lFomMwiH1VH7gVoblbD73W3frdfpuY36VRh6UClfNcmpkt054n91sHAgMBAAECggEBALMj8RijUQXw9LleYTYsqsql4GwWQN2tr7+hVantPeFwsoHgPeLujXH0dyc2PT4CpiXuSqnDK+HbJeBDfpJQmHwqwfxf5PrAGIJYywmUUucZpHEpAEpHRc03i34i2TqLwiskDQzaEdIwUf0aGRQm63obH7ZcO1nqc3+pB+t9VFn/UhIgLe/8mT/fb+gXXnJfZu6d8BY51u+Oy0EqzH4mWg1tI6SuEEQMYgjw7APFp6DmsEZJchyPrzj0eRaqEz/9pdFKIv7nfReTc+ty8UWkjAQ0pVED+hdopV250XB6qWhzkK/YkjBLPC7jdaeOdSJUED28lP9z35SlhuGCatTReOECgYEA7BKpDi1B5RIUQtFjmEQF237z4jpc+BmQuAxyeogGFTZbtkWja/sxMv1ZPXOENZlP+svMhBl5hkfj5l9MbMQ8ql5TpuJe8QXiEBT6s38KwhZnbfvAew7kOkNqfCxK9HsOfrUNxocY+fw4lq57DqsbcDEy1136S7UrM26WwioU+1ECgYEA95IoACS41OUhuQpBSt8/Qx2GfJ0toIpR8jI14zykZujQf069vgOr3KS82yMLnRpHLOsx09xv4Ya/D0w6hh/Vy8pZud1ZVuugnal+v6Si4vJONseOxg6uAtrvYVo7YnR6ld5mEerC+aq/ktVkZDf/zYM7hpSCaSGWemLaK9wNKtcCgYEAgKZusMYjKfXfSsaXcwxm8MZPnFLYBXDROCu4W2QzhG3aLwvmUltS5YnBj0abnyYMuw1DSB4l5vLYlNwMZx3OPb4n8kNdIBZnqwHz2cv7DehttzdCHw3vfHzu0/rDYlaJgK2kczN+fgVgxWUStNy0mECHh2y0kXuKrn2u9ONACfECgYBkTGNGQ5paLgYuiDgRlEZ182VD4Q3WJ5OxcqQgTrYwNwwZN5Zpf+VFu7wDb7xJxpalXRfPxFPTY5rOIMzo/8bHDFCzmziRnV5x4XRHQfT3ysDjMo/mL5ZR887dewfqCFSNmQ9zHNAnBAUfALLuYz2QTiV0jYAUBZaIOLo44Kq4+wKBgB2cmDOgF3mG2sxCUmovyW44+OnstnSLW4QaJE/HE9V5nMeCGyfwn+OaQ1fphG/tK/2qyxp27JlFqLHkY1IW6u5FaLLlnZaA/O4M9L2cjmadgpYpVcCSU4Y8yolDcFLT+MmzSc7r3Pqmh3B+tWYIU341PpJ/7CWUhoqR0LMDjRY5"




@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str1 = [YHDeviceUtil sharedUtil].sim_carrierName;
    NSString *str2 = [YHDeviceUtil sharedUtil].sim_countryCode;
    NSString *str3 = [YHDeviceUtil sharedUtil].sim_netCode;
    NSString *str4 = [YHDeviceUtil sharedUtil].sim_isoCountryCode;
    NSInteger str5 = [YHDeviceUtil sharedUtil].sim_isAllowVOIP;
    NSString *str7 = [YHDeviceUtil sharedUtil].hardwareString;
    NSString *str8 = [YHDeviceUtil sharedUtil].systemVersion;
    NSString *str9 = [YHDeviceUtil sharedUtil].deveiceName;
    NSString *str10 = [YHDeviceUtil sharedUtil].appleName;
    NSString *str11 = [YHDeviceUtil sharedUtil].ipAdress;
    NSString *str12 = [YHDeviceUtil sharedUtil].ipAdressForWiFi;
    NSString *str13 = [YHDeviceUtil sharedUtil].ipAdressForCellular;
    NSInteger str14 = [YHDeviceUtil sharedUtil].isCanMakePhone;
    
    NSLog(@"str1:%@",str1);
    NSLog(@"str2:%@",str2);
    NSLog(@"str3:%@",str3);
    NSLog(@"str4:%@",str4);
    NSLog(@"str5:%ld",(long)str5);
    NSLog(@"str7:%@",str7);
    NSLog(@"str8:%@",str8);
    NSLog(@"str9:%@",str9);
    NSLog(@"str10:%@",str10);
    NSLog(@"str11:%@",str11);
    NSLog(@"str12:%@",str12);
    NSLog(@"str13:%@",str13);
    NSLog(@"str14:%ld",(long)str14);
    
    NSLog(@"%f",YH_HEIGHT(10));
    
    
}
- (IBAction)alertTestAction:(id)sender {
  
}
- (IBAction)photoLibraryAction:(id)sender {

}

- (IBAction)camera:(id)sender {
 
}
- (IBAction)adressBookAction:(id)sender {

}


- (IBAction)microphoneAction:(id)sender {
 
}


- (IBAction)locationAction:(id)sender {

}

- (IBAction)locationAlwaysAction:(id)sender {
 
    
}




@end
