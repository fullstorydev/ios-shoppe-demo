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

@property (nonatomic, strong) NSDictionary *settings;

- (instancetype)init:(NSDictionary *)settings;

@end
