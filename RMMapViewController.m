//
//  RMMapViewController.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/14/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "RMMapViewController.h"
#import "RMCloudMadeMapSource.h"
#import "RMDBMapSource.h"
#import "RMMarker.h"
#import "Spot.h"
#import "RMMarkerManager.h"
#import "RMMarker.h"
#import "Spot.h"
#import "SSCLController.h"
#import "MapAnnotationView.h"

@implementation RMMapViewController
@synthesize mapView;
@synthesize spots;
@synthesize spot;

-(void) dealloc {
    [xMarker release];
    SafeRelease(spots);
    SafeRelease(spot);
    SafeRelease(contents);
    SafeRelease(mapView);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    mapView = [[RMMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
	[mapView setBackgroundColor:[UIColor whiteColor]];
	mapView.delegate = self;	
    
	id <RMTileSource> tileSource = [[[RMDBMapSource alloc] initWithPath:@"hanoi_tiles.sqlite"] autorelease];
	
	contents = [[RMMapContents alloc] initWithView:mapView tilesource:tileSource]; 
	
	[contents setTileSource:tileSource];
	[contents setMaxZoom:17.0f];
	[contents setMinZoom:12.0f];
	
	[contents setZoom:14.0f];
	[contents setMapCenter:CLLocationCoordinate2DMake(21.06, 105.94)];
	
	self.view = mapView; 	
    if (self.spot != nil) {
        [contents setMapCenter:CLLocationCoordinate2DMake([self.spot.lat doubleValue], [self.spot.lng doubleValue])];
    }
    [SSCLController sharedSSCLController].delegate = self;
	
    [self addMarkers];
   /*
    [mapView setConstraintsSW:((CLLocationCoordinate2D){20.96,105.7}) 
     NE:((CLLocationCoordinate2D){21.06,105.94})]; 
    
 */
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.spot != nil) {
        [contents setMapCenter:CLLocationCoordinate2DMake([self.spot.lat doubleValue], [self.spot.lng doubleValue])];
    }
}


- (void)addMarkers
{

    
	UIImage *redMarkerImage = [UIImage imageNamed:@"marker-red.png"];
	//UIImage *blueMarkerImage = [UIImage imageNamed:@"marker-blue.png"];
	
    RMMarker *newMarker;
    if (self.spots.count > 0) {
        for (Spot *theSpot in self.spots) {
            newMarker = [[RMMarker alloc] initWithUIImage:redMarkerImage anchorPoint:CGPointMake(0.5, 1.0)];
            [contents.markerManager addMarker:newMarker AtLatLong:CLLocationCoordinate2DMake([theSpot.lat doubleValue], [theSpot.lng doubleValue])];
            [newMarker changeLabelUsingText:theSpot.name font:[UIFont fontWithName:@"Verdana" size:15.0f] foregroundColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
            
            
        }
    } else if (self.spot != nil) {
        newMarker = [[RMMarker alloc] initWithUIImage:redMarkerImage anchorPoint:CGPointMake(0.5, 1.0)];
        [contents.markerManager addMarker:newMarker AtLatLong:CLLocationCoordinate2DMake([self.spot.lat doubleValue], [self.spot.lng doubleValue])];
         [newMarker changeLabelUsingText:self.spot.name font:[UIFont fontWithName:@"Verdana" size:15.0f] foregroundColor:[UIColor blackColor] backgroundColor:[UIColor whiteColor]];
    }
   
    [newMarker hideLabel];
    [newMarker release];
    
    [self updateLocationPin];

}

-(UIView *) createLabelAnnotationForSpot:(Spot *) theSpot {
    MapAnnotationView *annot = [[[MapAnnotationView alloc] initWithNibName:@"MapAnnotationView" bundle:nil] autorelease];
    annot.label.text = theSpot.name;
    return annot.view;
}

-(void) updateLocationPin {
    
    CLLocationCoordinate2D locationCenter = [[SSCLController sharedSSCLController] searchCenter];
    [contents.markerManager removeMarker:xMarker];
    // mark current location
    UIImage *xMarkerImage = [UIImage imageNamed:@"marker-X.png"];
    xMarker = [[RMMarker alloc] initWithUIImage:xMarkerImage anchorPoint:CGPointMake(0.5, 0.5)];
    [self.mapView.contents.markerManager addMarker:xMarker AtLatLong:locationCenter];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) zoomToAnnotationsBounds:(NSArray *)annotations {
    /*
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
     */
}

-(void) setMapRegionForMinLat:(double)minLatitude minLong:(double)minLongitude maxLat:(double)maxLatitude maxLong:(double)maxLongitude {
    /*
    MKCoordinateRegion region;
    region.center.latitude = (minLatitude + maxLatitude) / 2;
    region.center.longitude = (minLongitude + maxLongitude) / 2;
    region.span.latitudeDelta = (maxLatitude - minLatitude);
    region.span.longitudeDelta = (maxLongitude - minLongitude);
    
    // MKMapView BUG: this snaps to the nearest whole zoom level, which is wrong- it doesn't respect the exact region you asked for. See http://stackoverflow.com/questions/1383296/why-mkmapview-region-is-different-than-requested
    [self.mapView setRegion:region animated:YES];
     */
}



#pragma mark -
#pragma mark Delegate methods

- (void) afterMapMove: (RMMapView*) map {
  
}

- (void) afterMapZoom: (RMMapView*) map byFactor: (float) zoomFactor near:(CGPoint) center {
    
}

- (void) tapOnMarker: (RMMarker*) marker onMap: (RMMapView*) map {
    [marker toggleLabel];
}

- (void) tapOnLabelForMarker: (RMMarker*) marker onMap: (RMMapView*) map {
    
}

#pragma mark -
#pragma mark SSCLControllerDelegate

-(void) locationDidUpdateFrom:(CLLocationCoordinate2D) oldCoordinate to:(CLLocationCoordinate2D) newCoordinate {
    
    [self updateLocationPin];
}

-(void) headingDidUpdateTo:(CLHeading *) newHeading {
    
    
}


@end
