//
//  AFMapViewGestureRecognizer.h
//  MapTinkoffPartners
//
//  Created by Александр on 10.04.16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchesEventBlock)(NSSet * touches, UIEvent * event);

@interface AFMapViewGestureRecognizer : UIGestureRecognizer {
    TouchesEventBlock touchesBeganCallback;
}

@property(copy) TouchesEventBlock touchesBeganCallback;

@end
