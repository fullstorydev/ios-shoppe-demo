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
    if(context.eventType == SEGEventTypeTrack){
        NSLog(@"It's track event");
        SEGTrackPayload *payload = (SEGTrackPayload *) context.payload;
        next(
            [context modify:^(id<SEGMutableContext>  _Nonnull ctx) {
            SEGTrackPayload *newPayload = [[SEGTrackPayload alloc] initWithEvent:payload.event properties:@{ @"test prop" : @"testing middleware" } context:payload.context integrations:payload.integrations];
            ctx.payload = newPayload;
        }]);
    }else{
        next(context);
    }
}

@end

//import Analytics
//
//
//let fullStroyMiddleware = SEGBlockMiddleware { (context, next) in
//    if context.eventType == .track {
//        next(context.modify { ctx in
//            guard let track = ctx.payload as? SEGTrackPayload else {
//                return
//            }
//            let newEvent = "[New] \(track.event)"
//            var newProps = track.properties ?? [:]
//            newProps["customAttribute"] = "Hello"
//            ctx.payload = SEGTrackPayload(
//                event: newEvent,
//                properties: newProps,
//                context: track.context,
//                integrations: track.integrations
//            )
//        })
//    } else {
//        next(context)
//    }
//}
