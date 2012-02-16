//
//  SSCLController.h
//  XCC
//
//  Created by Tom on 8/28/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SSCLControllerDelegate

-(void) locationDidUpdateFrom:(CLLocationCoordinate2D) oldCoordinate to:(CLLocationCoordinate2D) newCoordinate;

-(void) headingDidUpdateTo:(CLHeading *) newHeading;

@end


@interface SSCLController : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	CLLocationCoordinate2D chosenLocation;
	CLLocationCoordinate2D gpsLocation;
	BOOL usingGPS;
	id <SSCLControllerDelegate> delegate;
	CLLocationDirection currentHeading;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D chosenLocation;
@property (nonatomic, assign, getter=isUsingGPS, setter=setUsingGPS:) BOOL usingGPS;
@property (nonatomic, assign) id <SSCLControllerDelegate> delegate;
@property (nonatomic, assign) CLLocationDirection currentHeading;

+ (SSCLController *)sharedSSCLController;

-(CLLocationCoordinate2D) searchCenter;

//- (CLLocationDirection)directionToLocation:(CLLocationCoordinate2D)newCoordinate;


@end
