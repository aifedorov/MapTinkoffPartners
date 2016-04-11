//
//  AFObjectModel.m
//  MapTinkoffPartners
//
//  Created by Александр on 09.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFObjectModel.h"

@implementation AFObjectModel

+ (id)entityName {
    return NSStringFromClass(self);
}

+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context {
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

@end
