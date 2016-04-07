//
//  AFPlusButtonView.m
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFPlusView.h"

@implementation AFPlusView

- (void)drawRect:(CGRect)rect {
    
    CGRect bounds = self.bounds;
    CGFloat delta = 10;
    NSInteger lineWidth = 2;
    
    CGFloat radius = MIN(bounds.size.width, bounds.size.height);
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)] CGPath]];
    
    self.layer.mask = circleLayer;
    
    UIBezierPath *pathPlusVert = [[UIBezierPath alloc] init];
    [pathPlusVert moveToPoint:(CGPoint){bounds.size.width / 2.f, delta}];
    [pathPlusVert addLineToPoint:(CGPoint){bounds.size.width / 2.f, bounds.size.height - delta}];
    
    UIBezierPath *pathPlusHoriz = [[UIBezierPath alloc] init];
    [pathPlusHoriz moveToPoint:(CGPoint){delta, bounds.size.height / 2.f}];
    [pathPlusHoriz addLineToPoint:(CGPoint){bounds.size.width - delta, bounds.size.height / 2.f}];

    pathPlusVert.lineWidth = lineWidth;
    pathPlusHoriz.lineWidth = lineWidth;
    
    [[UIColor lightGrayColor] setStroke];
    
    [pathPlusVert stroke];
    [pathPlusHoriz stroke];
    
}


@end
