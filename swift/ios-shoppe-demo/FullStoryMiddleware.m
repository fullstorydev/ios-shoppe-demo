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

- (instancetype)init:(NSDictionary *)settings{
    if (self = [super init]) {
        self.settings = settings;

        if ([settings[@"enableGroupTraitsToUserVars"] boolValue]) {
            NSLog(@"Here is a test message1");
        }
        if([settings[@"enableFSSessionURLInEvent"] boolValue]){
            NSLog(@"Here is a test message2");
        }

    }
    
    return self;
}

- (void)context:(SEGContext * _Nonnull)context next:(SEGMiddlewareNext _Nonnull)next {
    NSLog(@"We got here");
    next([context modify:^(id<SEGMutableContext>  _Nonnull ctx) {
        switch(ctx.eventType){
            case SEGEventTypeGroup:{
                SEGGroupPayload *payload = (SEGGroupPayload *) ctx.payload;
                [FS setUserVars: @{@"groupID":payload.groupId}];
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
                
                NSMutableDictionary *newProps = [[NSMutableDictionary alloc] initWithDictionary:payload.properties];
                [newProps setValue:[FS currentSessionURL] forKey:@"FSSessionURL"];
                [newProps setValue:[FS currentSessionURL:true] forKey:@"FSSessionNowURL"];
                SEGScreenPayload *newPayload = [[SEGScreenPayload alloc]
                                                initWithName:payload.name
                                                properties:newProps
                                                context:payload.context
                                                integrations:payload.integrations];
                ctx.payload = newPayload;
                    
                NSString *name = [[NSString alloc] initWithFormat:@"visited screen: %@",payload.name];
                [FS event:name properties:payload.properties];
                [FS logWithLevel:FSLOG_INFO format:@"Segment SCREEN event"];
                break;
            }
            case SEGEventTypeTrack: {
                SEGTrackPayload *payload = (SEGTrackPayload *) ctx.payload;

                NSMutableDictionary *newProps = [[NSMutableDictionary alloc] initWithDictionary:payload.properties];
                [newProps setValue:[FS currentSessionURL] forKey:@"FSSessionURL"];
                [newProps setValue:[FS currentSessionURL:true] forKey:@"FSSessionNowURL"];
                SEGTrackPayload *newPayload = [[SEGTrackPayload alloc]
                                               initWithEvent:payload.event
                                               properties:newProps
                                               context:payload.context
                                               integrations:payload.integrations];
                ctx.payload = newPayload;
                
                [FS logWithLevel:FSLOG_INFO format:@"Segment TRACK event"];
                [FS event:payload.event properties:payload.properties];
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
        }
    }]);
}

@end
