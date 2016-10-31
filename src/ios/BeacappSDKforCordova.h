//
//  BeacappSDKforCordova.h
//  BeacappSDKforCordova
//
//  Created by 遠藤武宣 on 2016/10/26.
//  Copyright © 2016年 遠藤武宣. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol BeacappSDKforCordovaDelegate <NSObject>
@optional
- (BOOL) shouldUpdateEventListner:(NSDictionary * _Nullable)info;

@optional
- (void) updateEventListner:(NSError*_Nullable)error;

@optional
- (void) fireEventListner:(NSDictionary *_Nullable)event;

@end

@interface BeacappSDKforCordova : NSObject

@property (nonatomic, weak) id<BeacappSDKforCordovaDelegate> _Nullable delegate;

- (BOOL)initialize:(NSString*_Nullable)requestToken secretKey:(NSString*_Nullable)secretKey error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (void) startUpdateEvents:(NSError*_Nullable)error;
- (void) startScan:(NSError*_Nullable)error;
- (void) stopScan:(NSError*_Nullable)error;
- (NSString*_Nullable) getDeviceIdentifier:(NSError*_Nullable)error;
- (BOOL) setAdditionalLog:(NSString*_Nullable)logValue error:(NSError*_Nullable)error;
- (BOOL) customLog:(NSString*_Nullable)logValue error:(NSError*_Nullable)error;
@end
