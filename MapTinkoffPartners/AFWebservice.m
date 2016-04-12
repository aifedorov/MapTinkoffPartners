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

- (void)fetchAllPartners: (void (^)(NSArray *partners))callback {
    
    static NSString *requestString = @"deposition_partners?accountType=Credit";
    
    NSString *requestUrlString = [AFBaseURLString stringByAppendingString: requestString];
    NSURL *requestUrl = [NSURL URLWithString:requestUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error : %@", [error localizedDescription]);
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

- (void)fetchDepositonPointsOnLocation: (double)latitude longitude: (double)longitude radius: (NSInteger)radius callback:(void (^)(NSArray *points))callback {
    
    NSString *requestString = [NSString stringWithFormat:@"deposition_points?latitude=%f&longitude=%f&radius=%ld", latitude, longitude, (long)radius];
    
    NSString *requestUrlString = [AFBaseURLString stringByAppendingString: requestString];
    NSURL *requestUrl = [NSURL URLWithString:requestUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
            callback(nil);
            return;
        }
        
        NSError *jsonError = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([result[@"resultCode"] isEqualToString:@"OK"]) {
                NSArray *points = result[@"payload"];
                callback(points);
            } else {
                NSLog(@"Status code: %@", result[@"resultCode"]);
            }
        }
    }];
    
    [dataTask resume];
}

- (void)fetchIcons:(NSString *)namePicture callback:(void (^)(UIImage *iconImage, NSDictionary *allHeaderFieldsDictionary))callback {
    
    NSString *requestString = [NSString stringWithFormat:@"https://static.tinkoff.ru/icons/deposition-partners-v3/mdpi/%@", namePicture];
    NSURL *downloadURL = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    
    NSURLSessionDownloadTask *downloadImageTask =[[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error download image: %@", [error localizedDescription]);
            callback(nil, [(NSHTTPURLResponse *)response allHeaderFields]);
            return;
        }
        
        UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:location]];
        callback(image,[(NSHTTPURLResponse *)response allHeaderFields]);
    }];
    [downloadImageTask resume];
}

@end
