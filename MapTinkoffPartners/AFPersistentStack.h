//
//  AFPersistentStack.h
//  MapTinkoffPartners
//
//  Created by Александр on 09.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface AFPersistentStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext* backgroundManagedObjectContext;

- (id)initWithStoreURL:(NSURL*)storeURL modelURL:(NSURL*)modelURL;

@end
