#import "beacappSDK.h"

@interface beacappSDK () <BeacappSDKforCordovaDelegate>
@end

@implementation beacappSDK

BOOL updateFlag;

- (void) initCordovaPlugin{
    BeacappSDKforCordova * cordova = [[BeacappSDKforCordova alloc]init];
    cordova.delegate = self;
    _cordova = cordova;
    
}
- (void) initialize:(CDVInvokedUrlCommand*)command {
    if(!_cordova){
        [self initCordovaPlugin];
    }
    
    NSString *requestToken = [command.arguments objectAtIndex:0];
    NSString *secretKey = [command.arguments objectAtIndex:1];
    NSError * error = nil;
    [_cordova initialize:requestToken secretKey:secretKey error:&error];
    CDVPluginResult* cdvpResult;
    
    if (!error)
    {
        // Success Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"success"}];
    }
    else
    {
        NSMutableDictionary * returnDictionary = [NSMutableDictionary dictionaryWithDictionary:[error userInfo]];
        [returnDictionary setValue:[NSString stringWithFormat:@"%ld",(long)[error code]] forKey:@"code"];
        [returnDictionary setValue:@"error" forKey:@"callback"];
        // Error Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:returnDictionary];
    }
    [self.commandDelegate sendPluginResult:cdvpResult callbackId:command.callbackId];
}

- (void) startUpdateEvents:(CDVInvokedUrlCommand*)command{
    if(!_cordova){
        [self initCordovaPlugin];
    }
    CDVPluginResult* cdvpResult;
    NSError * error = nil;
    [_cordova startUpdateEvents:error];
    if (!error){
        // Success Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"success"}];
    } else {
        // error Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:@{@"callback":@"error"}];
    }
    
    [self.commandDelegate sendPluginResult:cdvpResult callbackId:command.callbackId];
    
};
- (void) startScan:(CDVInvokedUrlCommand*)command{
    if(!_cordova){
        [self initCordovaPlugin];
    }
    CDVPluginResult* cdvpResult;
    
    NSError * error = nil;
    [_cordova startScan:error];
    if (!error){
        // Success Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"success"}];
    } else {
        // error Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:@{@"callback":@"error"}];
    }
    
    [self.commandDelegate sendPluginResult:cdvpResult callbackId:command.callbackId];
    
    
};
- (void) stopScan:(CDVInvokedUrlCommand*)command{
    if(!_cordova){
        [self initCordovaPlugin];
    }
    
    CDVPluginResult* cdvpResult;
    NSError * error = nil;
    [_cordova stopScan:error];
    if (!error){
        // Success Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"success"}];
    } else {
        // error Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:@{@"callback":@"error"}];
    }
    
    
    [self.commandDelegate sendPluginResult:cdvpResult callbackId:command.callbackId];
    
};
- (void) getDeviceIdentifier:(CDVInvokedUrlCommand*)command{
    if(!_cordova){
        [self initCordovaPlugin];
    }
    CDVPluginResult* cdvpResult;
    
    NSError * error = nil;
    NSString * deviceIdentifier = [_cordova getDeviceIdentifier:error];
    if (!error){
        // Success Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"success",@"deviceIdentifier":deviceIdentifier}];
    } else {
        // error Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:@{@"callback":@"error"}];
    }
    
    
    [self.commandDelegate sendPluginResult:cdvpResult callbackId:command.callbackId];
    
    
};
- (void) setAdditionalLog:(CDVInvokedUrlCommand*)command{
    if(!_cordova){
        [self initCordovaPlugin];
    }
    NSString *logValue = [command.arguments objectAtIndex:0];
    CDVPluginResult* cdvpResult;
    NSError * error = nil;
    [_cordova setAdditionalLog:logValue error:error];
    if (!error){
        // Success Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"success"}];
    } else {
        // error Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:@{@"callback":@"error"}];
    }
    [self.commandDelegate sendPluginResult:cdvpResult callbackId:command.callbackId];
    
    
};
- (void) customLog:(CDVInvokedUrlCommand*)command{
    if(!_cordova){
        [self initCordovaPlugin];
    }
    NSString *logValue = [command.arguments objectAtIndex:0];
    CDVPluginResult* cdvpResult;
    NSError * error = nil;
    [_cordova customLog:logValue error:error];
    if (!error){
        // Success Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"success"}];
    } else {
        // error Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:@{@"callback":@"error"}];
    }
    [self.commandDelegate sendPluginResult:cdvpResult callbackId:command.callbackId];
    
    
};
- (void) setShouldUpdateEventListner:(CDVInvokedUrlCommand*)command{
    if(!_cordova){
        [self initCordovaPlugin];
    }
    
    NSString *shouldUpdateEvent = [command.arguments objectAtIndex:0];
    if ([shouldUpdateEvent isEqualToString:@"ALWAYS_YES"]){
        updateFlag = YES;
    } else {
        updateFlag = NO;
    }
    CDVPluginResult* cdvpResult;
    NSError * error = nil;
    if (!error){
        // Success Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"success"}];
    } else {
        // error Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:@{@"callback":@"error"}];
    }
    [self.commandDelegate sendPluginResult:cdvpResult callbackId:command.callbackId];
    
    
};
- (void) setUpdateEventListner:(CDVInvokedUrlCommand*)command{
    if(!_cordova){
        [self initCordovaPlugin];
    }
    _updateCommand = command;
};
- (void) setFireEventListner:(CDVInvokedUrlCommand*)command{
    if(!_cordova){
        [self initCordovaPlugin];
    }
    _fireCommand = command;
};

- (BOOL) shouldUpdateEventListner:(NSDictionary*)info{
    if (![info[@"alreadyNewest"]boolValue] || updateFlag) {
        return YES;
    }else{
        return NO;
    }
};

- (void) updateEventListner:(NSError*)error{
    if (_updateCommand){
        CDVPluginResult* cdvpResult;
        if (error){
            // Success Callback
            cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"error"}];
        } else{
            // Success Callback
            cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:@{@"callback":@"success"}];
        }
        [cdvpResult setKeepCallbackAsBool:TRUE];
        [self.commandDelegate sendPluginResult:cdvpResult callbackId:_updateCommand.callbackId];
    }
};

- (void) fireEventListner:(NSDictionary *)event{
    if (_fireCommand){
        CDVPluginResult* cdvpResult;
        // Success Callback
        cdvpResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:event];
        [cdvpResult setKeepCallbackAsBool:TRUE];
        [self.commandDelegate sendPluginResult:cdvpResult callbackId:_fireCommand.callbackId];
    }
};
@end
