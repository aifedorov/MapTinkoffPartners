//
//  Importer.h
//  MapTinkoffPartners
//
//  Created by Александр on 08.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NSManagedObjectContext;
@class AFWebservice;

@interface AFImporter : NSObject

- (id)initWithContext:(NSManagedObjectContext *)context
           webservice:(AFWebservice *)webservice;
- (void)importPartners:(void (^)(void))handler;
- (void)importDepositionPoints: (double)latitude longitude: (double)longitude radius: (NSInteger)radius completionHandler:(void (^)(void))handler;
- (void)importIcons:(NSString *)iconNameString handler:(void (^)(UIImage *iconImage))handler;

@end
