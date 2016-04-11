//
//  AppDelegate.m
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AppDelegate.h"
#import "AFMapViewController.h"
#import "AFWebservice.h"
#import "AFImporter.h"
#import "AFPersistentStack.h"

@interface AppDelegate ()

@property (strong, nonatomic) AFImporter *importer;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.persistentStack = [[AFPersistentStack alloc] initWithStoreURL:self.storeURL modelURL:self.modelURL];
    self.webservice = [[AFWebservice alloc] init];
    self.importer = [[AFImporter alloc] initWithContext:self.persistentStack.backgroundManagedObjectContext webservice:self.webservice];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *rootNavigatinCintroller = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"rootNavigationController"];
    
    AFMapViewController *viewController = (AFMapViewController *)[rootNavigatinCintroller topViewController];
    
    if ([viewController isKindOfClass:[AFMapViewController class]]) {
        [viewController setManagedObjectContext:self.persistentStack.managedObjectContext];
        [viewController setImporter:self.importer];
    }
    
    [self.window setRootViewController:rootNavigatinCintroller];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

#pragma mark - Core Data stack

- (NSURL*)storeURL
{
    return [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"db.sqlite"];
}

- (NSURL*)modelURL
{
    return [[NSBundle mainBundle] URLForResource:@"MapTinkoffPartners" withExtension:@"momd"];
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSError *error = nil;
    [self.persistentStack.managedObjectContext save:&error];
    if (error) {
        NSLog(@"Error saving: %@", error.localizedDescription);
    }
}

@end
