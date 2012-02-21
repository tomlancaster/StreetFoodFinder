//
//  SSCLController.m
//  XCC
//
//  Created by Tom on 8/28/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import "SSCLController.h"
#import "SynthesizeSingleton.h"


@implementation SSCLController

SYNTHESIZE_SINGLETON_FOR_CLASS(SSCLController);

@synthesize locationManager;
@synthesize chosenLocation;
@synthesize usingGPS;
@synthesize delegate;
@synthesize currentHeading;

- (id) init {
    self = [super init];
    if (self != nil) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self; // send loc updates to myself
		CLLocationCoordinate2D initialLocation;
		//initialLocation.latitude = CENTER_LATITUDE;
		//initialLocation.longitude = CENTER_LONGITUDE;
		gpsLocation = initialLocation;
		chosenLocation = initialLocation;
		
		[self.locationManager startUpdatingLocation];
		
		if ([CLLocationManager respondsToSelector:@selector(headingAvailable)] && [CLLocationManager headingAvailable]) {
			
			self.locationManager.headingFilter = 5;
			
			[self.locationManager startUpdatingHeading];
			
		}
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
	gpsLocation = newLocation.coordinate;
	usingGPS = YES;
	[delegate locationDidUpdateFrom:oldLocation.coordinate to:newLocation.coordinate];
	
}


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
	
	if (newHeading.headingAccuracy < 0)
		
		return;
	
	
	
	// Use the true heading if it is valid.
	
	CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
									   
									   newHeading.trueHeading : newHeading.magneticHeading);
	
	
	
	self.currentHeading = theHeading;
	[delegate headingDidUpdateTo:newHeading];
	//[self updateHeadingDisplays];
	
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	DLog(@"%@", [error description]);
}

-(CLLocationCoordinate2D) searchCenter {
	if (usingGPS) {
		return gpsLocation;
	} else {
		return chosenLocation;
	}
}

- (void)dealloc {
    SafeRelease(locationManager);
    [super dealloc];
}


@end
