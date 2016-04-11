//
//  Icon.m
//  MapTinkoffPartners
//
//  Created by Александр on 11.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "Icon.h"
#import "Partner.h"

@implementation Icon

+ (Icon *)findOrCreateIconWithIdentifier:(NSString *)identifier lastModifiedDate:(NSDate *)lastModifiedDate inContext:(NSManagedObjectContext *)context {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[self entityName]];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name = %@", identifier];
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
    Icon* icon = result.lastObject;
    
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    
    if (result.lastObject && [lastModifiedDate compare:icon.lastModifiedDate] != NSOrderedDescending) {
        return result.lastObject;
        
    } else {
        Icon *icon = [self insertNewObjectIntoContext:context];
        return icon;
    }
}

@end
