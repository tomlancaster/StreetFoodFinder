//
//  RMMapViewController.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/14/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"
#import "SSCLController.h"
@class Spot;

@interface RMMapViewController : UIViewController <RMMapViewDelegate,SSCLControllerDelegate> {
    IBOutlet RMMapView * mapView;
    NSArray *spots;
    Spot *spot;
    RMMapContents *contents;  
    RMMarker *xMarker;
}

@property (nonatomic, retain) IBOutlet RMMapView * mapView;
@property(nonatomic,retain) NSArray *spots;
@property(nonatomic,retain) Spot *spot;

- (void)addMarkers;
-(void) updateLocationPin;
-(void) createLabelAnnotation;
@end
