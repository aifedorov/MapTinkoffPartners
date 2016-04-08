//
//  Partner+CoreDataProperties.m
//  MapTinkoffPartners
//
//  Created by Александр on 08.04.16.
//  Copyright © 2016 Home. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Partner+CoreDataProperties.h"

@implementation Partner (CoreDataProperties)

@dynamic idPartner;
@dynamic name;
@dynamic url;
@dynamic picture;
@dynamic hasLocations;
@dynamic isMomentary;
@dynamic depositionDuration;
@dynamic limitations;
@dynamic pointType;
@dynamic externalPartnerId;
@dynamic descriptionPartner;
@dynamic moneyMin;
@dynamic moneyMax;
@dynamic hasPreferentialDeposition;
@dynamic depos_relationship;

@end
