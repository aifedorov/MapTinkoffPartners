//
//  AFCustomAnnotation.h
//  MapTinkoffPartners
//
//  Created by Александр on 11.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AFCustomAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, strong) UIImage *image;

- (instancetype)initWhithTitle:(NSString *)title location:(CLLocationCoordinate2D)location image:(UIImage *)image;
- (MKAnnotationView *)annotationView;

@end
