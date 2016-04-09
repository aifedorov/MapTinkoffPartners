//
//  AFPersistentStack.m
//  MapTinkoffPartners
//
//  Created by Александр on 09.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFPersistentStack.h"

@interface AFPersistentStack ()

@property (nonatomic,readwrite) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,readwrite) NSManagedObjectContext* backgroundManagedObjectContext;

@property (nonatomic) NSURL* modelURL;
@property (nonatomic) NSURL* storeURL;

@end

@implementation AFPersistentStack

- (id)initWithStoreURL:(NSURL*)storeURL modelURL:(NSURL*)modelURL {
    self = [super init];
    if (self) {
        self.storeURL = storeURL;
        self.modelURL = modelURL;
        [self setupManagedObjectContexts];
    }
    return self;
}

- (void)setupManagedObjectContexts {
    
    self.managedObjectContext = [self setupManagedObjectContextWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.undoManager = [[NSUndoManager alloc] init];
    
    self.backgroundManagedObjectContext = [self setupManagedObjectContextWithConcurrencyType:NSPrivateQueueConcurrencyType];
    self.backgroundManagedObjectContext.undoManager = nil;
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:NSManagedObjectContextDidSaveNotification
     object:nil
     queue:nil
     usingBlock:^(NSNotification* note) {
         NSManagedObjectContext *moc = self.managedObjectContext;
         if (note.object != moc) {
             [moc performBlock:^(){
                 [moc mergeChangesFromContextDidSaveNotification:note];
             }];
         }
     }];
}

- (NSManagedObjectContext *) setupManagedObjectContextWithConcurrencyType: (NSManagedObjectContextConcurrencyType )concurrencyType {
    
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:concurrencyType];
    
    managedObjectContext.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSError *error;
    [managedObjectContext.persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                 configuration:nil
                                                                           URL:self.storeURL
                                                                       options:nil
                                                                         error:&error];
    if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
        NSLog(@"rm \"%@\"", self.storeURL.path);
    }
    
    return managedObjectContext;
}

- (NSManagedObjectModel*)managedObjectModel
{
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelURL];
}

@end
