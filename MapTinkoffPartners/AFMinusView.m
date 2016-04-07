//
//  AFMinusButtonView.m
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFMinusView.h"

@implementation AFMinusView

- (void)drawRect:(CGRect)rect {
    
    CGRect bounds = self.bounds;
    CGFloat delta = 10;
    NSInteger lineWidth = 2;
    
    CGFloat radius = MIN(bounds.size.width, bounds.size.height);
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)] CGPath]];
    
    self.layer.mask = circleLayer;
    
    UIBezierPath *pathMinus = [[UIBezierPath alloc] init];
    [pathMinus moveToPoint:(CGPoint){delta, bounds.size.height / 2.f}];
    [pathMinus addLineToPoint:(CGPoint){bounds.size.width - delta, bounds.size.height / 2.f}];
    
    pathMinus.lineWidth = lineWidth;
    
    [[UIColor lightGrayColor] setStroke];

    [pathMinus stroke];
}


@end
