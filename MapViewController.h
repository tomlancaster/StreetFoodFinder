//
//  MapViewController.h
//  HanoiCityCompanion
//
//  Created by Tom on 10/5/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Spot.h"
#import "MapViewController.h"

#import "SSCLController.h"

@protocol MapViewControllerDelegate;

@class DDAnnotation;


@interface MapViewController : UIViewController <MKMapViewDelegate, SSCLControllerDelegate> {
	NSArray *spots;
	IBOutlet MKMapView *mapView;
	CLLocationCoordinate2D location;
	id <MapViewControllerDelegate> delegate;
	MKReverseGeocoder *_reverseGeocoder;
	Spot *spot;
	BOOL isSimulator;
	NSString *callingContext;

    DDAnnotation *meAnnotation;
}

@property(nonatomic,retain) NSArray *spots;
@property(nonatomic,retain) Spot *spot;
@property (nonatomic, retain) NSString *callingContext;
@property (nonatomic, assign) id <MapViewControllerDelegate> delegate;

@property (nonatomic, retain) MKMapView *mapView;


- (void) zoomToAnnotationsBounds:(NSArray *)annotations;
-(void) setMapRegionForMinLat:(double)minLatitude minLong:(double)minLongitude maxLat:(double)maxLatitude maxLong:(double)maxLongitude;
-(void) updateLocationPin;
@end


@protocol MapViewControllerDelegate 

-(void) mapViewControllerDidFinishWithSave:(MapViewController *) controller;
-(void) mapViewControllerDidFinishWithCancel:(MapViewController *) controller;


@end