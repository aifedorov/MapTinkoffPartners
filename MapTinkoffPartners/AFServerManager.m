//
//  AFServerManager.m
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFServerManager.h"

@implementation AFServerManager

+ (instancetype) sharedManager {
    
    static AFServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFServerManager alloc] init];
    });
    
    return manager;
}

@end
