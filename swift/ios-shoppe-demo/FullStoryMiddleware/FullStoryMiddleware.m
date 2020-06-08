//
//  FullStoryMiddleware.m
//  ios-shoppe-demo
//
//  Created on 5/15/20.
//  Copyright © 2020 FullStory All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Analytics/SEGMiddleware.h>
#import "FullStoryMiddleware.h"
#import <FullStory/FullStory.h>

@implementation FullStoryMiddleware

- (id)initWithWhitelistEvents:(NSArray<NSString *> *) whitelistEvents {
     if (self = [super init]) {
         self.enableSendScreenAsEvents = false;
         self.enableGroupTraitsAsUserVars = false;
         self.enableFSSessionURLInEvents = true;
         self.whitelistAllTrackEvents = false;
         self.whitelistEvents = [[NSMutableArray alloc] initWithArray:whitelistEvents];
     }
    return self;
}

- (id)init{
    //init with no whitelisted events
    return [self initWithWhitelistEvents:nil];
}

- (void)context:(SEGContext * _Nonnull)context next:(SEGMiddlewareNext _Nonnull)next {
    next([context modify:^(id<SEGMutableContext>  _Nonnull ctx) {
        //TODO: add support for Options
        switch(ctx.eventType){
            case SEGEventTypeGroup:{
                SEGGroupPayload *payload = (SEGGroupPayload *) ctx.payload;
                NSMutableDictionary *userVars = [[NSMutableDictionary alloc] initWithObjectsAndKeys:payload.groupId,@"groupID", nil];
                if(self.enableGroupTraitsAsUserVars){
                    [userVars addEntriesFromDictionary:payload.traits];
                }
                [FS setUserVars:userVars];
                break;
            }
            case SEGEventTypeIdentify:{
                SEGIdentifyPayload *payload = (SEGIdentifyPayload *) ctx.payload;
                [FS identify: payload.userId userVars:payload.traits];
                break;
            }
            case SEGEventTypeScreen:{
                SEGScreenPayload *payload = (SEGScreenPayload *) ctx.payload;
                if(self.enableSendScreenAsEvents){
                    NSString *name = [[NSString alloc] initWithFormat:@"Segment Screen: %@",payload.name];
                    [FS event:name properties:payload.properties];
                }
                break;
            }
            case SEGEventTypeTrack: {
                SEGTrackPayload *payload = (SEGTrackPayload *) ctx.payload;
                if(self.whitelistAllTrackEvents || [self.whitelistEvents containsObject:payload.event]){
                    [FS event:payload.event properties:payload.properties];
                }
                break;
            }
            case SEGEventTypeReset:{
                [FS anonymize];
                break;
            }
            default:{}
        }
        [FS logWithLevel:FSLOG_INFO format:@"Segment event type: %@", [self getEventName:ctx.eventType]];
        
        SEGPayload *payload = [self getNewPayloadWithFSURL:context];
        if(self.enableFSSessionURLInEvents && payload != nil){
            ctx.payload = payload;
        }
    }]);
}

- (SEGPayload *) getNewPayloadWithFSURL:(SEGContext * _Nonnull)context {
    if(context.eventType == SEGEventTypeTrack){
        SEGTrackPayload *trackPayload = (SEGTrackPayload *) context.payload;
        NSMutableDictionary *newProps = [[NSMutableDictionary alloc] initWithDictionary:trackPayload.properties];
        [newProps setValue:[FS currentSessionURL] forKey:@"FSSessionURL"];
        
        SEGTrackPayload *newPayload = [[SEGTrackPayload alloc]
                                       initWithEvent:trackPayload.event
                                       properties:newProps
                                       context:trackPayload.context
                                       integrations:trackPayload.integrations];
        return newPayload;
    }else if(context.eventType == SEGEventTypeScreen){
        SEGScreenPayload *screenPayload = (SEGScreenPayload *) context.payload;
        NSMutableDictionary *newProps = [[NSMutableDictionary alloc] initWithDictionary:screenPayload.properties];
        [newProps setValue:[FS currentSessionURL] forKey:@"FSSessionURL"];
        
        SEGScreenPayload *newPayload = [[SEGScreenPayload alloc]
                                       initWithName:screenPayload.name
                                       properties:screenPayload.properties
                                       context:screenPayload.context
                                       integrations:screenPayload.integrations];
        return newPayload;
    }
    return nil;
}

// get all possible events from Event integer enum: https://segment.com/docs/connections/sources/catalog/libraries/mobile/ios/#usage
- (NSString *) getEventName:(SEGEventType)type {
    NSArray *eventArr =@[
        // Should not happen, but default state
        @"SEGEventTypeUndefined",
        // Core Tracking Methods
        @"SEGEventTypeIdentify",
        @"SEGEventTypeTrack",
        @"SEGEventTypeScreen",
        @"SEGEventTypeGroup",
        @"SEGEventTypeAlias",

        // General utility
        @"SEGEventTypeReset",
        @"SEGEventTypeFlush",

        // Remote Notification
        @"SEGEventTypeReceivedRemoteNotification",
        @"SEGEventTypeFailedToRegisterForRemoteNotifications",
        @"SEGEventTypeRegisteredForRemoteNotifications",
        @"SEGEventTypeHandleActionWithForRemoteNotification",

        // Application Lifecycle
        @"SEGEventTypeApplicationLifecycle",

        // Misc.
        @"SEGEventTypeContinueUserActivity",
        @"SEGEventTypeOpenURL"
     ];
    
    return eventArr[type];
}


@end

