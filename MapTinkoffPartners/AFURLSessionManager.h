//
//  AFServerManager.h
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFURLSessionManager : NSObject

@property (nonatomic, strong) NSURL *baseURL;

- (instancetype)initWithBaseURL:(NSURL *)url;
- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

- (void) fetchPartners:(NSString *)requestUrlString;

@end
