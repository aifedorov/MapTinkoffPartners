//
//  Icon+CoreDataProperties.h
//  MapTinkoffPartners
//
//  Created by Александр on 11.04.16.
//  Copyright © 2016 Home. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Icon.h"

NS_ASSUME_NONNULL_BEGIN

@interface Icon (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, retain) NSDate *lastModifiedDate;
@property (nullable, nonatomic, retain) Partner *partner;

@end

NS_ASSUME_NONNULL_END
