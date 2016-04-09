//
//  ViewController.m
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFMapViewController.h"
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>
#import "Partner.h"

@interface AFMapViewController () <CLLocationManagerDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *plusZoomButton;
@property (weak, nonatomic) IBOutlet UIButton *minusZoomButton;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation AFMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    for (NSManagedObject* object in [[self fetchedResultsController] fetchedObjects]) {
        NSLog(@"%@", [object valueForKey:@"name"]);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.plusZoomButton setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
    [self.minusZoomButton setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
    [self.currentLocationButton setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)centerMapOnUserButtonClicked:(id)sender {
    [self updateUserLocation];
}

- (IBAction)zoomOut:(id)sender {
    MKCoordinateRegion theRegion = self.mapView.region;
    if ( theRegion.span.longitudeDelta < 100 && theRegion.span.latitudeDelta < 100) {
        theRegion.span.longitudeDelta *= 2;
        theRegion.span.latitudeDelta *= 2;
        [self.mapView setRegion:theRegion animated:YES];
    }
}

- (IBAction)zoomIn:(id)sender {
    MKCoordinateRegion theRegion = self.mapView.region;
    
    if ( theRegion.span.longitudeDelta > 0.001 && theRegion.span.latitudeDelta > 0.001) {
        theRegion.span.longitudeDelta /= 2;
        theRegion.span.latitudeDelta /= 2;
        [self.mapView setRegion:theRegion animated:YES];
    }
}

#pragma mark - Private methods
@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:[Partner entityName] inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
 
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    [self.fetchedResultsController setDelegate:self];
    
    return _fetchedResultsController;
}

- (void)updateUserLocation {
    
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        
    } else {
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        [self.locationManager startUpdatingLocation];
    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
