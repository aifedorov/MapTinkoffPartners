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
#import "DepositionPoint.h"
#import "AFMapViewGestureRecognizer.h"
#import "AFImporter.h"
#import "AFCustomAnnotation.h"
#import "Icon.h"

@interface AFMapViewController () <CLLocationManagerDelegate, NSFetchedResultsControllerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *plusZoomButton;
@property (weak, nonatomic) IBOutlet UIButton *minusZoomButton;
@property (weak, nonatomic) IBOutlet UIButton *currentLocationButton;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSOperationQueue *importQueue;

@end

@implementation AFMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.importQueue =  [[NSOperationQueue alloc] init];
    
    AFMapViewGestureRecognizer *tapInterceptor = [[AFMapViewGestureRecognizer alloc] init];
    tapInterceptor.touchesBeganCallback = ^(NSSet * touches, UIEvent * event) {
        [self updateLocationPartners];
    };
    [self.mapView addGestureRecognizer:tapInterceptor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.plusZoomButton setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
    [self.minusZoomButton setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
    [self.currentLocationButton setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
    
    [self setupRegionMoscow];
    [self updateLocationPartners];
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

@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController *)fetchedResultsController:(id)entityName predicate:(NSPredicate *)predicate sortBy:(NSString *)key {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:key ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
 
    if (predicate) {
        [fetchRequest setPredicate:predicate];
    }
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    [self.fetchedResultsController setDelegate:self];
    
    NSError *error;
    if (![[self fetchedResultsController:entityName predicate:predicate sortBy:key] performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return _fetchedResultsController;
}

- (void)setupRegionMoscow {
    MKCoordinateRegion moscowRegion = self.mapView.region;
    
    CLLocationCoordinate2D location;
//    location.latitude = 55.751244;
//    location.longitude = 37.618423;
    
    location.latitude = 55.757698;
    location.longitude = 37.634119;
    
    moscowRegion.center = location;
    
    moscowRegion.span.latitudeDelta = 0.02;
    moscowRegion.span.longitudeDelta = 0.02;
    
    [self.mapView setRegion:moscowRegion animated:YES];
}

- (NSOperation *)executeBlock:(void (^)(void))block
                      inQueue:(NSOperationQueue *)queue
                   completion:(void (^)(BOOL finished))completion
{
    NSOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:block];
    NSOperation *completionOperation = [NSBlockOperation blockOperationWithBlock:^{
        if (completion) {
            completion(blockOperation.isFinished);

        }
    }];
    [completionOperation addDependency:blockOperation];
    
    [[NSOperationQueue currentQueue] addOperation:completionOperation];
    [queue addOperation:blockOperation];
    return blockOperation;
}

- (void)updateLocationPartners {
    
    MKMapRect visibleMapRect = self.mapView.visibleMapRect;
    MKMapPoint cornerPoint = MKMapPointMake(visibleMapRect.origin.x, visibleMapRect.origin.y);

    CLLocationCoordinate2D locationCornerPoint = MKCoordinateForMapPoint(cornerPoint);

    CLLocation *locationVisibleRect = [[CLLocation alloc] initWithLatitude:locationCornerPoint.latitude longitude:locationCornerPoint.longitude];
    CLLocation *locationcenterCoordinate = [[CLLocation alloc] initWithLatitude:self.mapView.centerCoordinate.latitude longitude:self.mapView.centerCoordinate.longitude];
    
    CLLocationDistance radius = [locationcenterCoordinate distanceFromLocation:locationVisibleRect];
    
//    __weak AFImporter *weakImporter = self.importer;
//    NSOperation *operationImportPartners = [NSBlockOperation blockOperationWithBlock:^{
        [self.importer importPartners:^{
            [self.importer importDepositionPoints:self.mapView.region.center.latitude longitude:self.mapView.region.center.longitude radius:radius handler:^{
                
                NSArray *points = [[self fetchedResultsController:[DepositionPoint entityName] predicate:nil sortBy:@"partnerName"] fetchedObjects];
                
                for (DepositionPoint* point in points) {
                    
                    CLLocationCoordinate2D location;
                    location.latitude = [point.latitude doubleValue];
                    location.longitude = [point.longitude doubleValue];
                    
                    UIImage *iconImage = [UIImage imageWithData:point.partner.icon.image];
                    
                    AFCustomAnnotation *annotation = [[AFCustomAnnotation alloc] initWhithTitle:[NSString stringWithFormat:@"%@", point.partner.name] location:location image:iconImage];
                    
                    [self updateAnnotationVisibleRect:annotation];
                }
            }];
        }];
    
//    }];
    
//    NSOperation *operationImportPoints = [NSBlockOperation blockOperationWithBlock:^{
    
//    }];
    
//    NSOperation *operationAddAnnotations = [NSBlockOperation blockOperationWithBlock:^{
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    }];
//    }];
//
//    [operationImportPoints addDependency:operationImportPartners];
//    [operationAddAnnotations addDependency:operationImportPoints];
//    
//    [self.importQueue addOperations:@[operationImportPartners, operationImportPoints, operationAddAnnotations] waitUntilFinished:NO];
}

-(void)updateAnnotationVisibleRect:(AFCustomAnnotation *) newAnnotation {
    
    NSSet *annotationSet = [self.mapView annotationsInMapRect:self.mapView.visibleMapRect];
    NSArray *annotationArray = [annotationSet allObjects];
    
    if ([annotationArray count] == 0) {
        [self.mapView addAnnotation:newAnnotation];
    }
    
    for (AFCustomAnnotation *annotation in annotationArray) {
        if (newAnnotation.coordinate.latitude != annotation.coordinate.latitude || newAnnotation.coordinate.longitude != annotation.coordinate.longitude) {
            [self.mapView addAnnotation:newAnnotation];
        }
    }
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

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString* identifier = @"Annotation";
    
    if ([annotation isKindOfClass:[AFCustomAnnotation class]]) {
        
        AFCustomAnnotation *customAnnotation =  (AFCustomAnnotation *)annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (!annotationView) {
            annotationView = customAnnotation.annotationView;
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
        
    } else {
        return nil;
    }
}

@end
