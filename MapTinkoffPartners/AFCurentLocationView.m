//
//  AFCurentLocationView.m
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFCurentLocationView.h"

@implementation AFCurentLocationView


- (void)drawRect:(CGRect)rect {
    CGRect bounds = self.bounds;
    NSInteger lineWidth = 2;
    
    CGFloat radius = MIN(bounds.size.width, bounds.size.height);
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)] CGPath]];
    
    self.layer.mask = circleLayer;
    CGFloat deltaX = bounds.size.width / 5.f;
    CGFloat deltaY = bounds.size.height / 5.f;
    
    UIBezierPath *pathCurrentLocation = [[UIBezierPath alloc] init];
    [pathCurrentLocation moveToPoint:(CGPoint){deltaX * 1.1, deltaY * 2.5}];
    [pathCurrentLocation addLineToPoint:(CGPoint){deltaX * 3.4, deltaY * 1.5}];
    [pathCurrentLocation addLineToPoint:(CGPoint){deltaX * 2.1, deltaY * 3.7}];
    [pathCurrentLocation addLineToPoint:(CGPoint){deltaX * 2.2, deltaY * 2.5}];
    [pathCurrentLocation addLineToPoint:(CGPoint){deltaX * 1.1, deltaY * 2.5}];
    
    pathCurrentLocation.lineWidth = lineWidth;
    
    [[UIColor lightGrayColor] setStroke];
    
    [pathCurrentLocation stroke];}


@end
