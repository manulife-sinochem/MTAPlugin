//
//  MTAPlugin.m
//  HelloCordova
//
//  Created by manulife on 2018/6/22.
//

#import "MTAPlugin.h"
#import "MTA.h"
#import "MTAConfig.h"
#import "MTA+Account.h"

@implementation MTAPlugin


- (void)startWithAppKeyAndCheckedVersion:(CDVInvokedUrlCommand *)command{

    //NSLog(@"startWithAppKeyAndCheckedVersion");

    MTAConfig *mtaConf = [MTAConfig getInstance];
    mtaConf.maxLoadEventCount = 999;
    mtaConf.maxSendRetryCount = 999;
    mtaConf.maxStoreEventCount = 499999;

    NSInteger parameterCount = command.arguments.count;

    if (parameterCount == 0) {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"not found appkey"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    } else if ( parameterCount > 0 & parameterCount < 2) {

        NSString *appKey = command.arguments[0];
        [MTA startWithAppkey:appKey];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }else{
        NSString *appKey = command.arguments[0];
        NSString *ver = command.arguments[1];

        BOOL result = [MTA startWithAppkey:appKey checkedSdkVersion:ver];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:result];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}



- (void)trackPageViewBegin:(CDVInvokedUrlCommand *)command {

    if ( command.arguments.count > 0 ) {
        NSString* page = command.arguments[0];
        [MTA trackPageViewBegin:page];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        
    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no page found"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }

}

- (void)trackPageViewBeginWithPageAndAppkey:(CDVInvokedUrlCommand *)command {

    if ( command.arguments.count > 0 ) {
        NSString *page = command.arguments[0];
        NSString *appkey = nil;
        if (command.arguments.count > 1) {
            appkey = command.arguments[1];
        }
        [MTA trackPageViewBegin:page appkey:appkey];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


- (void)trackPageViewEnd:(CDVInvokedUrlCommand *)command {

    if (command.arguments.count > 0) {
        NSString *page = command.arguments[0];
        [MTA trackPageViewEnd:page];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no page found"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)trackPageViewEndWithPageAppkeyAndIsRealTime:(CDVInvokedUrlCommand *)command {

    if ( command.arguments.count > 1 ) {
        NSString *page = command.arguments[0];
        BOOL isRealTime = [command.arguments[1] boolValue];

        NSString *appkey = nil;
        if (command.arguments.count > 2) {
            appkey = command.arguments[1];
            isRealTime = [command.arguments[2] boolValue];
        }

        [MTA trackPageViewEnd:page appkey:appkey isRealTime:isRealTime];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


- (void)trackCustomKeyValueEventWithEventIdAndKvs:(CDVInvokedUrlCommand *)command {

    if ( command.arguments.count > 1 ) {
        NSString *event_id = command.arguments[0];
        NSDictionary *props = command.arguments[1];
        MTAErrorCode code = [MTA trackCustomKeyValueEvent:event_id props:props];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];

        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }

}

- (void)trackCustomKeyValueEventWithEventIdKvsAppkeyAndIsRealTime:(CDVInvokedUrlCommand *)command {

    if ( command.arguments.count > 2 ) {
        NSString *event_id = command.arguments[0];
        NSDictionary *props = command.arguments[1];
        NSString *appkey = nil;
        BOOL isRealTime = [command.arguments[2] boolValue];

        if (command.arguments.count > 3) {
            appkey = command.arguments[2];
            isRealTime = [command.arguments[3] boolValue];
        }

        MTAErrorCode code = [MTA trackCustomKeyValueEvent:event_id props:props appkey:appkey isRealTime:isRealTime];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)trackCustomKeyValueEventBeginWithEventIdAndKvs:(CDVInvokedUrlCommand *)command {

    if ( command.arguments.count > 1 ) {
        NSString *event_id = command.arguments[0];
        NSDictionary *props = command.arguments[1];
        MTAErrorCode code = [MTA trackCustomKeyValueEventBegin:event_id props:props];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)trackCustomKeyValueEventBeginWithEventIdKvsAndAppkey:(CDVInvokedUrlCommand *)command {

    if ( command.arguments.count > 1 ) {
        NSString *event_id = command.arguments[0];
        NSDictionary *props = command.arguments[1];
        NSString *appkey = nil;
        if (command.arguments.count > 2) {
            appkey = command.arguments[2];
        }
        MTAErrorCode code = [MTA trackCustomKeyValueEventBegin:event_id props:props appkey:appkey];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


- (void)trackCustomKeyValueEventEndWithEventIdAndKvs:(CDVInvokedUrlCommand *)command {

    if ( command.arguments.count > 1 ) {
        NSString *event_id = command.arguments[0];
        NSDictionary *props = command.arguments[1];
        MTAErrorCode code = [MTA trackCustomKeyValueEventEnd:event_id props:props];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)trackCustomKeyValueEventEndWithEventIdKvsAppkeyAndIsRealTime:(CDVInvokedUrlCommand *)command {

    if ( command.arguments.count > 2 ) {
        NSString *event_id = command.arguments[0];
        NSDictionary *props = command.arguments[1];
        NSString *appkey = nil;
        BOOL isRealTime = [command.arguments[2] boolValue];

        if (command.arguments.count > 3) {
            appkey = command.arguments[2];
            isRealTime = [command.arguments[3] boolValue];
        }

        MTAErrorCode code = [MTA trackCustomKeyValueEventEnd:event_id props:props appkey:appkey isRealTime:isRealTime];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


- (void)trackCustomKeyValueEventDurationWithSecondsEventIdAndKvs:(CDVInvokedUrlCommand *)command {

    if (command.arguments.count > 2) {
        float seconds = [command.arguments[0] floatValue];
        NSString *event_id = command.arguments[1];
        NSDictionary *props = command.arguments[2];

        MTAErrorCode code = [MTA trackCustomKeyValueEventDuration:seconds withEventid:event_id props:props];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (void)trackCustomKeyValueEventDurationWithSecondsEventIdKvsAppkeyIsAndRealTime:(CDVInvokedUrlCommand *)command {

    if (command.arguments.count > 3) {
        float seconds = [command.arguments[0] floatValue];
        NSString *event_id = command.arguments[1];
        NSDictionary *props = command.arguments[2];
        NSString *appkey = nil;
        BOOL isRealTime = [command.arguments[3] boolValue];

        if (command.arguments.count > 4) {
            appkey = command.arguments[3];
            isRealTime = [command.arguments[4] boolValue];
        }
        MTAErrorCode code = [MTA trackCustomKeyValueEventDuration:seconds withEventid:event_id props:props appKey:appkey isRealTime:isRealTime];
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:code];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }else{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}


- (void)commitCachedStatsWithMaxStatCount:(CDVInvokedUrlCommand *)command {

    if (command.arguments.count > 0) {
        int32_t maxStatCount = [command.arguments[0] intValue];
        [MTA commitCachedStats:maxStatCount];
    }else {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"no parameter or parameter not enough"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }

}

- (void)trackActiveBegin:(CDVInvokedUrlCommand *)command {

    [MTA trackActiveBegin];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];


}

- (void)trackActiveEnd:(CDVInvokedUrlCommand *)command {
    [MTA trackActiveEnd];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}
@end
