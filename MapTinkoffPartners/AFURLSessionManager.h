//
//  AFServerManager.h
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFURLSessionManager : NSObject

- (instancetype)init;
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

- (void) fetchFeed;

@end
