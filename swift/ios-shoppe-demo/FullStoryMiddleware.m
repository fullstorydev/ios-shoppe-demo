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
        switch(ctx.eventType){
            case SEGEventTypeGroup:{
                SEGGroupPayload *payload = (SEGGroupPayload *) ctx.payload;
                [FS setUserVars: @{@"groupID":payload.groupId}];
                if(self.enableGroupTraitsAsUserVars){
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

                if(self.enableFSSessionURLInEvents){
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

                if(self.enableSendScreenAsEvents){
                    NSString *name = [[NSString alloc] initWithFormat:@"visited screen: %@",payload.name];
                    [FS event:name properties:payload.properties];
                }
                [FS logWithLevel:FSLOG_INFO format:@"Segment SCREEN event"];
                break;
            }
            case SEGEventTypeTrack: {
                SEGTrackPayload *payload = (SEGTrackPayload *) ctx.payload;
                
                if(self.enableFSSessionURLInEvents){
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
                    [FS event:payload.event properties:payload.properties];
                    [FS logWithLevel:FSLOG_INFO format:@"Segment TRACK event, whitelisted event: %@", payload.event];
                }else{
                    [FS logWithLevel:FSLOG_INFO format:@"Segment TRACK event, event not whitelisted, event data omitted"];
                }
                break;
            }
            case SEGEventTypeReset:{
                [FS logWithLevel:FSLOG_INFO format:@"Segment RESET event"];
                [FS anonymize];
                break;
            }
            default:{
                [FS logWithLevel:FSLOG_INFO format:@"Segment event type index %d, see integer enum document here: https://segment.com/docs/connections/sources/catalog/libraries/mobile/ios/#usage", ctx.eventType];
            }
        }
    }]);
}

// disallow modification of event names once init
//- (void) addWhitelistedEvents: (NSArray *) addEventNames{
//    [self.whitelistEvents addObjectsFromArray:addEventNames];
//    [FS logWithLevel:FSLOG_INFO format:@"added Segment whitelisted events, whitelisted: %@", addEventNames];
//}
//- (void) removeWhitelistedEvents: (NSArray *) removeEventNames{
//    [self.whitelistEvents removeObjectsInArray:removeEventNames];
//
//    [FS logWithLevel:FSLOG_INFO format:@"removed Segment whitelisted events, whitelisted: %@", removeEventNames];
//}

@end
