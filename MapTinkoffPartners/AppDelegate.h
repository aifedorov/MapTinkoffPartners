//
//  AppDelegate.h
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class AFPersistentStack;
@class AFWebservice;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) AFPersistentStack *persistentStack;
@property (nonatomic, strong) AFWebservice *webservice;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

