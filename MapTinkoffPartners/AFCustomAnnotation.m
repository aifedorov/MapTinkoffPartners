//
//  AFCustomAnnotation.m
//  MapTinkoffPartners
//
//  Created by Александр on 11.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFCustomAnnotation.h"

@implementation AFCustomAnnotation

- (instancetype)initWhithTitle:(NSString *)title location:(CLLocationCoordinate2D)location image:(UIImage *)image{
    self = [super init];
    if (self) {
        _title = title;
        _coordinate = location;
        _image = image;
    }
    return self;
}

- (MKAnnotationView *)annotationView {
    static NSString* identifier = @"Annotation";
    
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:identifier];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    
    UIImage *orangeImage = self.image;
    CGRect resizeRect;
    resizeRect.size.height = 30.f;
    resizeRect.size.width = 30.f;
    resizeRect.origin = (CGPoint){0,0};
    UIGraphicsBeginImageContext(resizeRect.size);
    [orangeImage drawInRect:resizeRect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    annotationView.image = resizedImage;
    
    return annotationView;
}

@end
