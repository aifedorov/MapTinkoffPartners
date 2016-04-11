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
#import "Icon.h"

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
- (void)importPartners:(void (^)(void))handler {
    [self.webservice fetchAllPartners:^(NSArray *partners) {
        [self.context performBlock:^{
            for (NSDictionary *partnerDict in partners) {
                NSString *identifier = [partnerDict valueForKey:@"idPartner"];
                Partner *partner = [Partner findOrCreatePartnerWithIdentifier:identifier inContext:self.context];
                [partner loadFromDictionary:partnerDict];
                
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

- (void)importDepositionPoints: (double)latitude longitude: (double)longitude radius: (NSInteger)radius completionHandler:(void (^)(void))handler {
    
        [self.webservice fetchDepositonPointsOnLocation:latitude longitude:longitude radius:radius callback:^(NSArray *points) {
            
            [self.context performBlock:^{
                
                for (NSDictionary *partnerDict in points) {
                    NSString *identifier = [partnerDict valueForKey:@"partnerName"];
                    DepositionPoint *point = [DepositionPoint findOrCreateDepositionPointWithIdentifier:identifier inContext:self.context];
                    [point loadFromDictionary:partnerDict];
                    
                    NSFetchRequest *request = [[NSFetchRequest alloc] init];
                    [request setEntity:[NSEntityDescription entityForName:[Partner entityName]inManagedObjectContext:self.context]];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idPartner == %@", identifier];
                    [request setPredicate:predicate];
                    
                    NSError *errorRequest = nil;
                    NSArray *results = [self.context executeFetchRequest:request error:&errorRequest];

                    if (errorRequest) {
                        NSLog(@"Error request entity Parnter: %@", [errorRequest localizedDescription]);
                    }
                    
                    Partner* partner = [results objectAtIndex:0];
                    [partner addDepospoint:[NSSet setWithObject:point]];
                    
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

- (void)importIcons:(NSString *)iconNameString handler:(void (^)(UIImage *iconImage))handler {
    [self.webservice fetchIcons:iconNameString callback:^(UIImage *iconImage, NSDictionary *allHeaderFieldsDictionary) {
        
        [self.context performBlock:^{
            NSString *identifier = iconNameString;
            
            NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
            [dateformat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss Z"];
            NSDate *lastModifiedDate = [dateformat dateFromString:[NSString stringWithFormat:@"%@", [allHeaderFieldsDictionary objectForKey:@"Last-Modified"]]];

            Icon *icon = [Icon findOrCreateIconWithIdentifier:identifier lastModifiedDate:lastModifiedDate inContext:self.context];
            [icon setName:identifier];
            [icon setLastModifiedDate:lastModifiedDate];
            [icon setImage:UIImagePNGRepresentation(iconImage)];
            
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            [request setEntity:[NSEntityDescription entityForName:[Partner entityName]inManagedObjectContext:self.context]];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"picture == %@", identifier];
            [request setPredicate:predicate];
            
            NSError *errorRequest = nil;
            NSArray *results = [self.context executeFetchRequest:request error:&errorRequest];
            
            if (errorRequest) {
                NSLog(@"Error request entity Partner: %@", [errorRequest localizedDescription]);
            }
            
            Partner* partner = [results objectAtIndex:0];
            [partner setIcon:icon];
            
            NSError *error = nil;
            [self.context save:&error];
            if (error) {
                NSLog(@"Error save context: %@", [error localizedDescription]);
            }
            handler(iconImage);
        }];
    }];
}

@end
