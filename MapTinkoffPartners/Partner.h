//
//  Partner.h
//  MapTinkoffPartners
//
//  Created by Александр on 11.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AFObjectModel.h"

@class DepositionPoint;

NS_ASSUME_NONNULL_BEGIN

@interface Partner : AFObjectModel

+ (Partner *)findOrCreatePartnerWithIdentifier:(NSString *)identifier inContext:(NSManagedObjectContext *)context ;
- (void)loadFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

#import "Partner+CoreDataProperties.h"
