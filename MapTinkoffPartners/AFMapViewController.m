//
//  ViewController.m
//  MapTinkoffPartners
//
//  Created by Александр on 07.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import "AFMapViewController.h"
#import <MapKit/MapKit.h>

@interface AFMapViewController ()

@property (weak, nonatomic) IBOutlet UIView *buttonZoomPlusView;
@property (weak, nonatomic) IBOutlet UIView *buttonZoomMinusView;

@property (weak, nonatomic) IBOutlet UIButton *plusZoomButton;
@property (weak, nonatomic) IBOutlet UIButton *minusZoomButton;


@end

@implementation AFMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
//    CAShapeLayer *circleLayerPlus = [CAShapeLayer layer];
//    [circleLayerPlus setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 50, 50)] CGPath]];
//    
//    CAShapeLayer *circleLayerMinus = [CAShapeLayer layer];
//    [circleLayerMinus setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 50, 50)] CGPath]];
//    
//    self.buttonZoomPlusView.layer.mask = circleLayerPlus;
//    self.buttonZoomMinusView.layer.mask = circleLayerMinus;
    
    [self.plusZoomButton setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
    [self.minusZoomButton setBackgroundImage:[self imageWithColor:[UIColor darkGrayColor]] forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private methods

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
