#import <Cordova/CDVPlugin.h>
#import "BeacappSDKforCordova.h"

@interface beacappSDK : CDVPlugin
    
    @property(nonatomic,strong) BeacappSDKforCordova * cordova;
    @property(nonatomic,strong) CDVInvokedUrlCommand * fireCommand;
    @property(nonatomic,strong) CDVInvokedUrlCommand * updateCommand;
    
- (void) initialize:(CDVInvokedUrlCommand*)command;
- (void) startUpdateEvents:(CDVInvokedUrlCommand*)command;
- (void) startScan:(CDVInvokedUrlCommand*)command;
- (void) stopScan:(CDVInvokedUrlCommand*)command;
- (void) getDeviceIdentifier:(CDVInvokedUrlCommand*)command;
- (void) setAdditionalLog:(CDVInvokedUrlCommand*)command;
- (void) customLog:(CDVInvokedUrlCommand*)command;
- (void) setShouldUpdateEventListner:(CDVInvokedUrlCommand*)command;
- (void) setUpdateEventListner:(CDVInvokedUrlCommand*)command;
- (void) setFireEventListner:(CDVInvokedUrlCommand*)command;
    
    @end
