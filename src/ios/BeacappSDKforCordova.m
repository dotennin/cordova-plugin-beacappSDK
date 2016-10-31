//
//  BeacappSDKforCordova.m
//  BeacappSDKforCordova
//
//  Created by 遠藤武宣 on 2016/10/26.
//  Copyright © 2016年 遠藤武宣. All rights reserved.
//

#import "BeacappSDKforCordova.h"
#import "JBCPCore.h"

@interface BeacappSDKforCordova () <JBCPManagerDelegate>

@end

@implementation BeacappSDKforCordova

- (BOOL)initialize:(NSString*_Nullable)requestToken secretKey:(NSString*_Nullable)secretKey error:(NSError * _Nullable __autoreleasing * _Nullable)error
{
    // JBCPManagerインスタンスを取得する
    JBCPManager *manager = [JBCPManager sharedManager];
    manager.delegate = self;
    // アクティベーションをする
    [manager initializeWithRequestToken:requestToken secretKey:secretKey options:nil error:error];
    
    if (!error) {
        return YES;
    } else{
        return NO;
    }
}

- (BOOL)manager:(JBCPManager * _Nonnull)manager shouldUpdateEvents:(NSDictionary * _Nullable)info{
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(shouldUpdateEventListner:)]) {
        if (![info[@"alreadyNewest"]boolValue]) {
            return YES;
        }else{
            return NO;
        }
    } else {
        return [self.delegate shouldUpdateEventListner:info];
    }
}

- (void)manager:(JBCPManager *)manager didFinishUpdateEvents:(NSError *)error{
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateEventListner:)]) {
        [self.delegate updateEventListner:error];
    }
}

- (void)manager:(JBCPManager *)manager fireEvent:(NSDictionary *)event{
    if (self.delegate && [self.delegate respondsToSelector:@selector(fireEventListner:)]) {
        [self.delegate fireEventListner:event];
    }
}
- (void) startUpdateEvents:(NSError*_Nullable)error{
    JBCPManager *manager = [JBCPManager sharedManager];
    manager.delegate = self;
    [manager startUpdateEvents:&error];
};
- (void) startScan:(NSError*_Nullable)error{
    JBCPManager *manager = [JBCPManager sharedManager];
    manager.delegate = self;
    [manager startScan:&error];
};
- (void) stopScan:(NSError*_Nullable)error{
    JBCPManager *manager = [JBCPManager sharedManager];
    manager.delegate = self;
    [manager stopScan:&error];
};
- (NSString*) getDeviceIdentifier:(NSError*_Nullable)error{
    JBCPManager *manager = [JBCPManager sharedManager];
    manager.delegate = self;
    return [manager getDeviceIdentifier:&error];
};
- (BOOL) setAdditionalLog:(NSString*)logValue error:(NSError*_Nullable)error{
    JBCPManager *manager = [JBCPManager sharedManager];
    manager.delegate = self;
    return [manager setAdditionalLog:logValue error:&error];
};

- (BOOL) customLog:(NSString*)logValue error:(NSError*_Nullable)error{
    JBCPManager *manager = [JBCPManager sharedManager];
    manager.delegate = self;
    return [manager customLog:logValue error:&error];
};

@end
