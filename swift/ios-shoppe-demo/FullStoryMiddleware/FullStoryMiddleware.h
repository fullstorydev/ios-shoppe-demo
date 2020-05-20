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

- (id) initWithWhitelistEvents:(NSArray<NSString *> *) whitelistEvents;
//- (void) addWhitelistedEvents: (NSArray *) addEventNames;
//- (void) removeWhitelistedEvents: (NSArray *) removeEventNames;

@end
