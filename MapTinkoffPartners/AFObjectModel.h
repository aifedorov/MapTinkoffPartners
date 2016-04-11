//
//  AFObjectModel.h
//  MapTinkoffPartners
//
//  Created by Александр on 09.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface AFObjectModel : NSManagedObject

+ (id)entityName;
+ (instancetype)insertNewObjectIntoContext:(NSManagedObjectContext *)context;

@end
