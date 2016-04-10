//
//  Importer.m
//  MapTinkoffPartners
//
//  Created by Александр on 08.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFImporter.h"
#import <CoreData/CoreData.h>
#import "AFWebservice.h"
#import "Partner.h"
#import "DepositionPoint.h"

@interface AFImporter ()

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) AFWebservice *webservice;

@end

@implementation AFImporter

- (id)initWithContext:(NSManagedObjectContext *)context
           webservice:(AFWebservice *)webservice {
    self = [super init];
    if (self) {
        _context = context;
        _webservice = webservice;
    }
    return self;
}

- (void)importPartners {
    [self.webservice fetchAllPartners:^(NSArray *partners) {
        [self.context performBlock:^{
            for (NSDictionary *partnerDict in partners) {
                NSString *identifier = [partnerDict valueForKey:@"name"];
                Partner *partner = [Partner findOrCreatePartnerWithIdentifier:identifier inContext:self.context];
                [partner loadFromDictionary:partnerDict];
                
                NSError *error = nil;
                [self.context save:&error];
                if (error) {
                    NSLog(@"Error save context: %@", [error localizedDescription]);
                }
            }
        }];
    }];
}

- (void)importDepositionPoints: (double)latitude longitude: (double)longitude radius: (NSInteger)radius completionHandler:(void (^)(void))handler {
    
    [self.webservice fetchDepositonPointsOnLocation:latitude longitude:longitude radius:radius callback:^(NSArray *points) {
        [self.context performBlock:^{
            
            for (NSDictionary *partnerDict in points) {
                NSString *identifier = [partnerDict valueForKey:@"partnerName"];
                DepositionPoint *point = [DepositionPoint findOrCreateDepositionPointWithIdentifier:identifier inContext:self.context];
                [point loadFromDictionary:partnerDict];
                
                NSError *error = nil;
                [self.context save:&error];
                if (error) {
                    NSLog(@"Error save context: %@", [error localizedDescription]);
                }
            }
            handler();
        }];
    }];
}

@end
