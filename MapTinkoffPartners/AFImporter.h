//
//  Importer.h
//  MapTinkoffPartners
//
//  Created by Александр on 08.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSManagedObjectContext;
@class AFWebservice;

@interface AFImporter : NSObject

- (id)initWithContext:(NSManagedObjectContext *)context
           webservice:(AFWebservice *)webservice;
- (void)import;

@end
