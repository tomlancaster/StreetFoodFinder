//
//  RMMapViewController.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/14/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"

@interface RMMapViewController : UIViewController <RMMapViewDelegate> {
    IBOutlet RMMapView * mapView;
}

@property (nonatomic, retain) IBOutlet RMMapView * mapView;

- (void)updateInfo;
@end
