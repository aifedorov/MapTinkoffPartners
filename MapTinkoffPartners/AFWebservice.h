//
//  AFServerManager.h
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFWebservice : NSObject

- (void) fetchAllPartners: (void (^)(NSArray *partners))callback;
- (void) fetchDepositonPointsOnLocation:(double) latitude longitude:(double) longitude radius:(NSInteger) radius callback:(void (^)(NSArray *points))callback;

@end
