//
//  Partner+CoreDataProperties.h
//  MapTinkoffPartners
//
//  Created by Александр on 11.04.16.
//  Copyright © 2016 Home. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Partner.h"

NS_ASSUME_NONNULL_BEGIN

@interface Partner (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *depositionDuration;
@property (nullable, nonatomic, retain) NSString *descriptionPartner;
@property (nullable, nonatomic, retain) NSNumber *externalPartnerId;
@property (nullable, nonatomic, retain) NSNumber *hasLocations;
@property (nullable, nonatomic, retain) NSNumber *hasPreferentialDeposition;
@property (nullable, nonatomic, retain) NSString *idPartner;
@property (nullable, nonatomic, retain) NSNumber *isMomentary;
@property (nullable, nonatomic, retain) NSString *limitations;
@property (nullable, nonatomic, retain) NSNumber *moneyMax;
@property (nullable, nonatomic, retain) NSNumber *moneyMin;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *picture;
@property (nullable, nonatomic, retain) NSString *pointType;
@property (nullable, nonatomic, retain) NSString *url;
@property (nullable, nonatomic, retain) NSSet<DepositionPoint *> *depospoint;
@property (nullable, nonatomic, retain) Icon *icon;

@end

@interface Partner (CoreDataGeneratedAccessors)

- (void)addDepospointObject:(DepositionPoint *)value;
- (void)removeDepospointObject:(DepositionPoint *)value;
- (void)addDepospoint:(NSSet<DepositionPoint *> *)values;
- (void)removeDepospoint:(NSSet<DepositionPoint *> *)values;

@end

NS_ASSUME_NONNULL_END
