//
//  Icon.h
//  MapTinkoffPartners
//
//  Created by Александр on 11.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>
#import "AFObjectModel.h"

@class Partner;

NS_ASSUME_NONNULL_BEGIN

@interface Icon : AFObjectModel

+ (Icon *)findOrCreateIconWithIdentifier:(NSString *)identifier lastModifiedDate:(NSDate *)lastModifiedDate inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Icon+CoreDataProperties.h"
