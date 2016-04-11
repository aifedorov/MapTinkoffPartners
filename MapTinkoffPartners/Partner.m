//
//  Partner.m
//  MapTinkoffPartners
//
//  Created by Александр on 11.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "Partner.h"
#import "DepositionPoint.h"

@implementation Partner

+ (Partner *)findOrCreatePartnerWithIdentifier:(NSString *)identifier inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name = %@", identifier];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    if (result.lastObject) {
        return result.lastObject;
    } else {
        Partner *partner = [self insertNewObjectIntoContext:context];
        return partner;
    }
}

- (void)loadFromDictionary:(NSDictionary *)dictionary {
    self.idPartner = dictionary[@"id"];
    self.name = dictionary[@"name"];
    self.picture = dictionary[@"picture"];
    self.url = dictionary[@"url"];
    self.depositionDuration = dictionary[@"depositionDuration"];
    self.limitations = dictionary[@"limitations"];
    self.pointType = dictionary[@"pointType"];
    self.descriptionPartner = dictionary[@"description"];
    
    self.hasLocations = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@", dictionary[@"hasLocations"]] integerValue]];
    self.isMomentary = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@", dictionary[@"isMomentary"]] integerValue]];
    self.hasPreferentialDeposition = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@", dictionary[@"hasPreferentialDeposition"]] integerValue]];
    self.externalPartnerId = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@", dictionary[@"externalPartnerId"]] integerValue]];
    self.moneyMin = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@", dictionary[@"moneyMin"]] integerValue]];
    self.moneyMax = [NSNumber numberWithInteger:[[NSString stringWithFormat:@"%@", dictionary[@"moneyMax"]] integerValue]];
}


@end
