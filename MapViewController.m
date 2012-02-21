//
//  MapViewController.m
//  HanoiCityCompanion
//
//  Created by Tom on 10/5/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import "MapViewController.h"
#import "AddAnnotation.h"
#import "DDAnnotation.h"
#import "SSCLController.h"
#import "DeviceDetection.h"
#import "DDAnnotationView.h"
#import "SpotDetailViewController.h"
#import "Spot.h"

@implementation MapViewController

@synthesize spots;
@synthesize callingContext;
@synthesize spot;
@synthesize delegate;

@synthesize mapView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
}

- (void)viewWillDisappear:(BOOL)animated {
	
	[super viewWillDisappear:animated];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    [SSCLController sharedSSCLController].delegate = self;
	// determine if this is the sim. If so we don't need to show user location.
	// If it's not the sim, and we're picking a search center, 
	// and we don't have a search center - 
	// then center on the user location
	// if we have a search center, center on it. If not, center on current location
	if ([DeviceDetection detectDevice] == MODEL_IPHONE_SIMULATOR) {
		isSimulator = YES;
		
	} else {
		isSimulator = NO;
	}
	
	if ([callingContext isEqualToString:@"spotEdit"]) {
		
		
		
		// Configure the save and cancel buttons for spot add
		UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
		self.navigationItem.rightBarButtonItem = saveButton;
		[saveButton release];
		
		UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
		self.navigationItem.leftBarButtonItem = cancelButton;
		[cancelButton release];

        MKCoordinateRegion region;
        MKCoordinateSpan span;
        
        span.latitudeDelta = 0.02;
        span.longitudeDelta = 0.02;
        region.span = span;
        region.center = [[SSCLController sharedSSCLController] searchCenter];
        
        [self updateLocationPin];
        [self.mapView setRegion:region animated:YES];
		
		
	} else if ([callingContext isEqualToString:@"viewAllOnMap"]) {
        CLLocationCoordinate2D theLocation;
        double latitude;
        double longitude;
        for (int idx = 0; idx < [spots count]; idx++) {
            latitude = [[[spots objectAtIndex:idx] valueForKey:@"lat"] doubleValue];
            longitude = [[[spots objectAtIndex:idx] valueForKey:@"lng"] doubleValue];
            theLocation.latitude = latitude;
            theLocation.longitude = longitude;

            AddAnnotation *addAnnotation = [[AddAnnotation alloc] initWithCoordinate:theLocation];
            addAnnotation.mtitle = [[spots objectAtIndex:idx] valueForKey:@"name"];
            
            addAnnotation.msubtitle = [[spots objectAtIndex:idx] valueForKey:@"address"];
            addAnnotation.spot = [spots objectAtIndex:idx];
            [self.mapView addAnnotation:addAnnotation];
            
            [addAnnotation release];
        }
        
        [self zoomToAnnotationsBounds:self.mapView.annotations];
    } else {
        self.spot = [self.spots objectAtIndex:0];
        CLLocationCoordinate2D theLocation;
        double latitude = [self.spot.lat doubleValue];
        double longitude = [self.spot.lng doubleValue];
        theLocation.latitude = latitude;
        theLocation.longitude = longitude;
        AddAnnotation *addAnnotation = [[AddAnnotation alloc] initWithCoordinate:theLocation];
        addAnnotation.mtitle = self.spot.name;
        
        addAnnotation.msubtitle = self.spot.address;
        addAnnotation.spot = self.spot;
        [self.mapView addAnnotation:addAnnotation];
        
        [addAnnotation release];
        [self zoomToAnnotationsBounds:self.mapView.annotations];
    }
		
}


- (void) zoomToAnnotationsBounds:(NSArray *)annotations {
    
    CLLocationDegrees minLatitude = DBL_MAX;
    CLLocationDegrees maxLatitude = -DBL_MAX;
    CLLocationDegrees minLongitude = DBL_MAX;
    CLLocationDegrees maxLongitude = -DBL_MAX;
   
    NSUInteger numPoints = [annotations count] + 1; 
    CLLocationCoordinate2D *arrayPtr = malloc(numPoints * sizeof(CLLocationCoordinate2D));
    arrayPtr[0] = [[SSCLController sharedSSCLController] searchCenter];
    for (int i = 1; i < numPoints; i++) {
        arrayPtr[i] = [[annotations objectAtIndex:i - 1] coordinate];
    }
         
   
     
    for (int i = 0; i < numPoints; i++) {
        double annotationLat = arrayPtr[i].latitude;
        double annotationLong = arrayPtr[i].longitude;
        minLatitude = fmin(annotationLat, minLatitude);
        maxLatitude = fmax(annotationLat, maxLatitude);
        minLongitude = fmin(annotationLong, minLongitude);
        maxLongitude = fmax(annotationLong, maxLongitude);
     }
    
    
    
    // See function below
    [self setMapRegionForMinLat:minLatitude minLong:minLongitude maxLat:maxLatitude maxLong:maxLongitude];
    
    // If your markers were 40 in height and 20 in width, this would zoom the map to fit them perfectly. Note that there is a bug in mkmapview's set region which means it will snap the map to the nearest whole zoom level, so you will rarely get a perfect fit. But this will ensure a minimum padding.
    UIEdgeInsets mapPadding = UIEdgeInsetsMake(40.0, 10.0, 0.0, 10.0);
    CLLocationCoordinate2D relativeFromCoord = [self.mapView convertPoint:CGPointMake(0, 0) toCoordinateFromView:self.mapView];
    
    // Calculate the additional lat/long required at the current zoom level to add the padding
    CLLocationCoordinate2D topCoord = [self.mapView convertPoint:CGPointMake(0, mapPadding.top) toCoordinateFromView:self.mapView];
    CLLocationCoordinate2D rightCoord = [self.mapView convertPoint:CGPointMake(0, mapPadding.right) toCoordinateFromView:self.mapView];
    CLLocationCoordinate2D bottomCoord = [self.mapView convertPoint:CGPointMake(0, mapPadding.bottom) toCoordinateFromView:self.mapView];
    CLLocationCoordinate2D leftCoord = [self.mapView convertPoint:CGPointMake(0, mapPadding.left) toCoordinateFromView:self.mapView];
    
    double latitudeSpanToBeAddedToTop = relativeFromCoord.latitude - topCoord.latitude;
    double longitudeSpanToBeAddedToRight = relativeFromCoord.latitude - rightCoord.latitude;
    double latitudeSpanToBeAddedToBottom = relativeFromCoord.latitude - bottomCoord.latitude;
    double longitudeSpanToBeAddedToLeft = relativeFromCoord.latitude - leftCoord.latitude;
    
    maxLatitude = maxLatitude + latitudeSpanToBeAddedToTop;
    minLatitude = minLatitude - latitudeSpanToBeAddedToBottom;
    
    maxLongitude = maxLongitude + longitudeSpanToBeAddedToRight;
    minLongitude = minLongitude - longitudeSpanToBeAddedToLeft;
    
    [self setMapRegionForMinLat:minLatitude minLong:minLongitude maxLat:maxLatitude maxLong:maxLongitude];
}

-(void) setMapRegionForMinLat:(double)minLatitude minLong:(double)minLongitude maxLat:(double)maxLatitude maxLong:(double)maxLongitude {
    
    MKCoordinateRegion region;
    region.center.latitude = (minLatitude + maxLatitude) / 2;
    region.center.longitude = (minLongitude + maxLongitude) / 2;
    region.span.latitudeDelta = (maxLatitude - minLatitude);
    region.span.longitudeDelta = (maxLongitude - minLongitude);
    
    // MKMapView BUG: this snaps to the nearest whole zoom level, which is wrong- it doesn't respect the exact region you asked for. See http://stackoverflow.com/questions/1383296/why-mkmapview-region-is-different-than-requested
    [self.mapView setRegion:region animated:YES];
}

-(void) updateLocationPin {
    
    CLLocationCoordinate2D locationCenter = [[SSCLController sharedSSCLController] searchCenter];
    SafeRelease(meAnnotation);
    meAnnotation = [[[DDAnnotation alloc] initWithCoordinate:locationCenter addressDictionary:nil] autorelease];
    meAnnotation.title = NSLocalizedString(@"Drag to Move Pin", nil);	
    [mapView removeAnnotation:meAnnotation];
    [mapView addAnnotation:meAnnotation];
   
    
   // [self setMapRegionForMinLat:locationCenter.latitude minLong:locationCenter.longitude maxLat:locationCenter.latitude maxLong:locationCenter.longitude];
}



#pragma mark -
#pragma mark DDAnnotationCoordinateDidChangeNotification

// NOTE: DDAnnotationCoordinateDidChangeNotification won't fire in iOS 4, use -mapView:annotationView:didChangeDragState:fromOldState: instead.
- (void)coordinateChanged_:(NSNotification *)notification {
	
	DDAnnotation *annotation = notification.object;
	[[SSCLController sharedSSCLController] setChosenLocation:annotation.coordinate];
	[[SSCLController sharedSSCLController] setUsingGPS:NO];
	
}

#pragma mark -
#pragma mark SSCLControllerDelegate

-(void) locationDidUpdateFrom:(CLLocationCoordinate2D) oldCoordinate to:(CLLocationCoordinate2D) newCoordinate {
    if ([self.callingContext isEqualToString:@"spotEdit"]) {
        [self updateLocationPin];
    }
}

-(void) headingDidUpdateTo:(CLHeading *) newHeading {
    
    
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
	
	if (oldState == MKAnnotationViewDragStateDragging) {
		DDAnnotation *annotation = (DDAnnotation *)annotationView.annotation;
		[[SSCLController sharedSSCLController] setChosenLocation:annotation.coordinate];
		[[SSCLController sharedSSCLController] setUsingGPS:NO];
				
	}
}


- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>) annotation{
	/*
	if (annotation == theMapView.userLocation) {
		return nil;
	}
	 */
	if ([annotation isKindOfClass:[MKUserLocation class]]) {	
        return nil;  //Let the system use the "blue dot" for the user location
	}
	
	if ([annotation isKindOfClass:[DDAnnotation class]]) {
		static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
		MKAnnotationView *draggablePinView = [mapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
		if (draggablePinView) {
			draggablePinView.annotation = annotation;
		
		} else {
			draggablePinView = [[[DDAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPinAnnotationIdentifier] autorelease];
			
			if ([draggablePinView isKindOfClass:[DDAnnotationView class]]) {
				((DDAnnotationView *)draggablePinView).mapView = mapView;
			} else {
				// NOTE: draggablePinView will be draggable enabled MKPinAnnotationView when running under iOS 4.
			}
		}
		return draggablePinView;
	} else {
		
		MKPinAnnotationView *annView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"spotloc"];
		if (annView == nil) {
			annView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"spotloc"] autorelease];
			// Set up the right callout
			UIButton *myDetailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			myDetailButton.frame = CGRectMake(0, 0, 30, 30);
			myDetailButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
			myDetailButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
			// Set the button as the callout view
			annView.rightCalloutAccessoryView = myDetailButton;
			
		}
		
		//if (annotation.title == youTitle) {
			annView.pinColor = MKPinAnnotationColorGreen;
		//} else {
		//	annView.pinColor = MKPinAnnotationColorGreen;
		//}
		annView.animatesDrop=TRUE;
		annView.canShowCallout = YES;
		annView.calloutOffset = CGPointMake(-5, 5);
		return annView;
	}		
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	// go to detail view
	SpotDetailViewController *controller = [[SpotDetailViewController alloc] initWithNibName:@"SpotDetails" bundle:nil];
	
	AddAnnotation *theAnnotation = (AddAnnotation *) view.annotation;
	controller.selectedSpot = theAnnotation.spot;
	[self.navigationController pushViewController:controller animated:YES];
    [controller release];
	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	mapView.delegate = nil;
    [SSCLController sharedSSCLController].delegate = nil;
}


- (void)dealloc {
    
	[spots release];
	[spot release];
	//SafeRelease(delegate);
	delegate = nil;
	mapView.delegate = nil;
    [SSCLController sharedSSCLController].delegate = nil;
	[super dealloc];
}


#pragma mark -
#pragma mark Save and cancel operations

- (IBAction)save {
	if ([callingContext isEqualToString:@"spotEdit"]) {
		
		CLLocationCoordinate2D sc = [[SSCLController sharedSSCLController] searchCenter];
		self.spot.lat = [NSNumber numberWithDouble:sc.latitude];
		self.spot.lng = [NSNumber numberWithDouble:sc.longitude];
	}
	
	
	//[_locationManager stopUpdatingLocation];
	if (callingContext == @"setSearchCenter") {
		
	} else {
		
		
	}
	[delegate mapViewControllerDidFinishWithSave:self];
}


- (IBAction)cancel {
	[delegate mapViewControllerDidFinishWithCancel:self];
	
}


@end
