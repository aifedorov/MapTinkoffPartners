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

- (void)import {
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

#pragma mark - Private methods

- (NSString *)dictionaryEncodingToString:(NSDictionary *)dict{
    
    NSError *errorParse;
    NSData *nameData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&errorParse];
    return [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
}

@end
