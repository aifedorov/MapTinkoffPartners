//
//  AFServerManager.m
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFURLSessionManager.h"

@interface AFURLSessionManager () <NSURLSessionDelegate>

@property (readwrite, nonatomic, strong) NSURLSession *session;
@property (readwrite, nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;

@end

@implementation AFURLSessionManager

- (instancetype)init {
    return [self initWithBaseURL:nil];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    return [self initWithBaseURL:url sessionConfiguration:nil];
}

- (instancetype)initWithBaseURL:(nullable NSURL *)url
           sessionConfiguration:(nullable NSURLSessionConfiguration *)configuration {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if ([[url path] length] > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    
    self.baseURL = url;
    
    if (!configuration) {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    
    self.sessionConfiguration = configuration;
    
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:self delegateQueue:nil];
    
    return self;
}

- (void) fetchPartners:(NSString *)requestUrlString {
    
    NSURL *requestUrl = [NSURL URLWithString:requestUrlString relativeToURL:self.baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *partners = result[@"payload"];
            
            NSError  *errorParse;
            NSData   *nameData      = [NSJSONSerialization dataWithJSONObject:[partners valueForKey:@"name"] options:0 error:&errorParse];
            
            NSString *nameString = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
            
            NSLog(@"%@", nameString);
        }
    }];
    
    [dataTask resume];
}

@end
