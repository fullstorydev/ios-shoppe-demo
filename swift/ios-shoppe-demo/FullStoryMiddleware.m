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

- (id)initWithWhitelistEvents:(NSArray<NSString *> *)whitelistEvents {
     if (self = [super init]) {
         self.whitelistEvents = whitelistEvents;
     }
    return self;
}

- (id)init{
    if (self = [super init]) {
        self.whitelistEvents = [[NSArray alloc] init];
        self.sendScreenAsEvents = false;
        self.enableGroupTraitsToUserVars = false;
        self.enableFSSessionURLInEvent = true;
    }
    
    return self;
}

- (void)context:(SEGContext * _Nonnull)context next:(SEGMiddlewareNext _Nonnull)next {
    next([context modify:^(id<SEGMutableContext>  _Nonnull ctx) {
        switch(ctx.eventType){
            case SEGEventTypeGroup:{
                SEGGroupPayload *payload = (SEGGroupPayload *) ctx.payload;
                [FS setUserVars: @{@"groupID":payload.groupId}];
                if(self.enableGroupTraitsToUserVars){
                    [FS setUserVars:payload.traits];
                }
                [FS logWithLevel:FSLOG_INFO format:@"Segment GROUP event"];
                break;
            }
            case SEGEventTypeIdentify:{
                SEGIdentifyPayload *payload = (SEGIdentifyPayload *) ctx.payload;
                [FS identify: payload.userId userVars:payload.traits];
                [FS logWithLevel:FSLOG_INFO format:@"Segment Identify event"];
                break;
            }
            case SEGEventTypeScreen:{
                SEGScreenPayload *payload = (SEGScreenPayload *) ctx.payload;

                if(self.enableFSSessionURLInEvent){
                    NSMutableDictionary *newProps = [[NSMutableDictionary alloc] initWithDictionary:payload.properties];
                    [newProps setValue:[FS currentSessionURL] forKey:@"FSSessionURL"];
                    [newProps setValue:[FS currentSessionURL:true] forKey:@"FSSessionNowURL"];
                    SEGScreenPayload *newPayload = [[SEGScreenPayload alloc]
                                                   initWithName:payload.name
                                                   properties:newProps
                                                   context:payload.context
                                                   integrations:payload.integrations];
                    ctx.payload = newPayload;
                    
                }

                if(self.sendScreenAsEvents){
                    NSString *name = [[NSString alloc] initWithFormat:@"visited screen: %@",payload.name];
                    [FS event:name properties:payload.properties];
                }
                [FS logWithLevel:FSLOG_INFO format:@"Segment SCREEN event"];
                break;
            }
            case SEGEventTypeTrack: {
                SEGTrackPayload *payload = (SEGTrackPayload *) ctx.payload;
                
                if(self.enableFSSessionURLInEvent){
                    NSMutableDictionary *newProps = [[NSMutableDictionary alloc] initWithDictionary:payload.properties];
                    [newProps setValue:[FS currentSessionURL] forKey:@"FSSessionURL"];
                    [newProps setValue:[FS currentSessionURL:true] forKey:@"FSSessionNowURL"];
                    SEGTrackPayload *newPayload = [[SEGTrackPayload alloc]
                                                   initWithEvent:payload.event
                                                   properties:newProps
                                                   context:payload.context
                                                   integrations:payload.integrations];
                    ctx.payload = newPayload;
                    
                }
                
                if([self.whitelistEvents containsObject:payload.event]){
                    NSLog(@"event is whitelisted");
                    [FS event:payload.event properties:payload.properties];
                }
                [FS logWithLevel:FSLOG_INFO format:@"Segment TRACK event"];
                break;
            }
            case SEGEventTypeFlush: // https://segment.com/docs/connections/sources/catalog/libraries/mobile/ios/#flushing
                [FS logWithLevel:FSLOG_INFO format:@"Segment FLUSH event"];
                break;
            case SEGEventTypeReset:{
                [FS logWithLevel:FSLOG_INFO format:@"Segment RESET event"];
                [FS anonymize];
                break;
            }
            case SEGEventTypeApplicationLifecycle:
            case SEGEventTypeUndefined:
            case SEGEventTypeAlias:
            case SEGEventTypeReceivedRemoteNotification:
            case SEGEventTypeFailedToRegisterForRemoteNotifications:
            case SEGEventTypeRegisteredForRemoteNotifications:
            case SEGEventTypeHandleActionWithForRemoteNotification:
            case SEGEventTypeContinueUserActivity:
            case SEGEventTypeOpenURL:
                break;
        }
    }]);
}

- (void) whitelistEvents: (NSArray *) eventNames{
    self.whitelistEvents = eventNames;
    [FS logWithLevel:FSLOG_INFO format:@"set Segment whitelisted event names: %@", eventNames];
}

- (void) sendScreenAsEvents: (BOOL) enable {
    self.sendScreenAsEvents = enable;
    [FS logWithLevel:FSLOG_INFO format:@"set sendScreenAsEvents: %@",enable];
}

- (void) enableGroupTraitsToUserVars: (BOOL) enable{
    self.enableGroupTraitsToUserVars = enable;
    [FS logWithLevel:FSLOG_INFO format:@"set enableGroupTraitsToUserVars: %@",enable];
}

- (void) enableFSSessionURLInEvent: (BOOL) enable{
    self.enableFSSessionURLInEvent = enable;
    [FS logWithLevel:FSLOG_INFO format:@"set enableFSSessionURLInEvent: %@",enable];
}
@end
