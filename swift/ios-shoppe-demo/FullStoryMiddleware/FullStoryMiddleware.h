//
//  FullStoryMiddleware.h
//  ios-shoppe-demo
//
//  Created on 5/15/20.
//  Copyright © 2020 FullStory All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Analytics/SEGMiddleware.h>

@interface FullStoryMiddleware : NSObject<SEGMiddleware>

@property (strong, nonatomic) NSArray* whitelistEvents;
@property (nonatomic) BOOL enableSendScreenAsEvents;
@property (nonatomic) BOOL enableGroupTraitsAsUserVars;
@property (nonatomic) BOOL enableFSSessionURLInEvents;
@property (nonatomic) BOOL whitelistAllTrackEvents;

- (id) initWithWhitelistEvents:(NSArray<NSString *> *) whitelistEvents;

@end
