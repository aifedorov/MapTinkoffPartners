//
//  Partner.h
//  MapTinkoffPartners
//
//  Created by Александр on 08.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DepositionPoint;

NS_ASSUME_NONNULL_BEGIN

@interface Partner : NSManagedObject

+ (Partner *)findOrCreatePartnerWithIdentifier:(NSString *)identifier inContext:(NSManagedObjectContext *)context;
+ (id)entityName;
+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext*)context;

- (void)loadFromDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

#import "Partner+CoreDataProperties.h"
