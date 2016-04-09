//
//  AFServerManager.m
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFWebservice.h"

@interface AFWebservice () <NSURLSessionDelegate>

@property (readwrite, nonatomic, strong) NSURLSession *session;
@property (readwrite, nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;

@end

static NSString * const AFBaseURLString = @"https://api.tinkoff.ru/v1/";

@implementation AFWebservice

- (void) fetchAllPartners: (void (^)(NSArray *partners))callback {
    
    static NSString *requestString = @"deposition_partners?accountType=Credit";
    
    NSString *requestUrlString = [AFBaseURLString stringByAppendingString: requestString];
    NSURL *requestUrl = [NSURL URLWithString:requestUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            callback(nil);
            return;
        }
        
        NSError *jsonError = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSArray *partners = result[@"payload"];
            callback(partners);
        }
    }];
    
    [dataTask resume];
}

@end
