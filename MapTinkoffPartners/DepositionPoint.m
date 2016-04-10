//
//  DepositionPoint.m
//  MapTinkoffPartners
//
//  Created by Александр on 08.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "DepositionPoint.h"
#import "Partner.h"

@implementation DepositionPoint

+ (DepositionPoint *)findOrCreateDepositionPointWithIdentifier:(NSString *)identifier inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"partnerName = %@", identifier];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    if (result.lastObject) {
        return result.lastObject;
    } else {
        DepositionPoint *depositionPoint = [self insertNewObjectIntoContext:context];
        return depositionPoint;
    }
}

- (void)loadFromDictionary:(NSDictionary *)dictionary {
    self.partnerName = dictionary[@"partnerName"];
    self.workHours = dictionary[@"workHours"];
    self.addressInfo = dictionary[@"addressInfo"];
    self.fullAddress = dictionary[@"fullAddress"];
    
    
    NSDictionary *locationDict = dictionary[@"location"];
    self.latitude = [NSNumber numberWithDouble:[[NSString stringWithFormat:@"%@", locationDict[@"latitude"]] doubleValue]];
    self.longitude = [NSNumber numberWithDouble:[[NSString stringWithFormat:@"%@", locationDict[@"longitude"]] doubleValue]];
    
    NSLog(@"longitude = %f", [self.latitude doubleValue]);
}

@end
