//
//  AFMapViewGestureRecognizer.m
//  MapTinkoffPartners
//
//  Created by Александр on 10.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFMapViewGestureRecognizer.h"

@implementation AFMapViewGestureRecognizer

@synthesize touchesBeganCallback;

-(id) init{
    if (self = [super init])
    {
        self.cancelsTouchesInView = NO;
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (touchesBeganCallback)
        touchesBeganCallback(touches, event);
}

- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    return NO;
}

- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    return NO;
}

@end
