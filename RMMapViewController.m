//
//  RMMapViewController.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/14/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "RMMapViewController.h"
#import "RMCloudMadeMapSource.h"

@implementation RMMapViewController
@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[mapView setDelegate:self];
	id myTilesource = [[[RMCloudMadeMapSource alloc] initWithAccessKey:@"0199bdee456e59ce950b0156029d6934" styleNumber:999] autorelease];
    
	// have to initialize the RMMapContents object explicitly if we want it to use a particular tilesource
	[[[RMMapContents alloc] initWithView:mapView 
							  tilesource:myTilesource] autorelease];
    
    /* -- Uncomment to constrain view
     [mapView setConstraintsSW:((CLLocationCoordinate2D){-33.942221,150.996094}) 
     NE:((CLLocationCoordinate2D){-33.771157,151.32019})]; */
    
    [self updateInfo];
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateInfo];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark Delegate methods

- (void) afterMapMove: (RMMapView*) map {
  
}

- (void) afterMapZoom: (RMMapView*) map byFactor: (float) zoomFactor near:(CGPoint) center {
    
}



@end
