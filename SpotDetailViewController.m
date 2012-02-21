//
//  SpotDetailViewController.m
//  HanoiCityCompanion
//
//  Created by Tom on 2/6/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import "SpotDetailViewController.h"
#import "SpotDetailsTableViewCell.h"
#import "MapViewController.h"
#import "DeviceDetection.h"
#import "SSCLController.h"
#import "MBProgressHUD.h"
#import "NormalCellBackground.h"
#import "MWPhotoBrowser.h"
#import "SpotCategory+Extras.h"
#import "SpotPhoto.h"
#import "Spot+Extras.h"
#import "Review.h"
#import "Spot.h"

#define RADIANS_TO_DEGREES(radians) ((radians) * 180.0 / M_PI)

@implementation SpotDetailViewController

@synthesize selectedSpot, reviews;

@synthesize selectedSpotId;
@synthesize popoverController;
@synthesize imageView;
@synthesize detailsCell;
@synthesize photos;

- (void)dealloc {
	[selectedSpot release];
	[reviews release];
    SafeRelease(photos);
    SafeRelease(popoverController);
    SafeRelease(imageView);
    SafeRelease(detailsCell);
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    

	self.navigationItem.title = NSLocalizedString(@"Spot Details",@"");
    myTableView.backgroundColor = [UIColor clearColor];
	
    [myTableView setBackgroundView:nil];
    [myTableView setBackgroundView:[[[UIView alloc] init] autorelease]];
   
    

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    //self.navigationController.navigationBar.tintColor = TNH_RED;
	self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	//[myTableView reloadData];
     [SSCLController sharedSSCLController].delegate = self;
	
}

-(void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [SSCLController sharedSSCLController].delegate = nil;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}




- (void)viewOnMap {
	MapViewController *mvController = [[MapViewController alloc] initWithNibName:@"MapView" bundle:[NSBundle mainBundle]];
	NSArray *spots  = [[NSArray alloc] initWithObjects:self.selectedSpot,nil];
	mvController.spots = spots;
    mvController.hidesBottomBarWhenPushed = YES;
	[spots release];
	[self.navigationController pushViewController:mvController animated:YES];
	[mvController release];
}

-(void)viewReviews {
	ReviewTableViewController *rvtController = [[ReviewTableViewController alloc] initWithNibName:@"reviews" bundle:[NSBundle mainBundle]];
	rvtController.spot = self.selectedSpot;
	rvtController.sortOrder = 1;//[sortOrderSegmentedControl selectedSegmentIndex];
    rvtController.reviews = [NSMutableArray arrayWithArray:[self.selectedSpot.reviews allObjects]];
	[self.navigationController pushViewController:rvtController	animated:YES];
	[rvtController release];
}




#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
		if (indexPath.section == 0) {
			
			static NSString *DetailsCellIdentifier = @"SpotDetailsTableViewCell";

			self.detailsCell = (SpotDetailsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:DetailsCellIdentifier];
			
			if (self.detailsCell == nil) {
				// Create a temporary UIViewController to instantiate the custom cell.
				UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"SpotDetailsTableViewCell" bundle:nil];
				// Grab a pointer to the custom cell.
				self.detailsCell = (SpotDetailsTableViewCell *)temporaryController.view;
				
				[temporaryController release];
				
				
			}
			
			
			[self.detailsCell setSpotNameLabelText:selectedSpot.name];	
			[self.detailsCell setRating:[selectedSpot.star_rating floatValue]];
			[self.detailsCell setSpotAddressLabelText:selectedSpot.address];
			[self.detailsCell setSpotNumRatingsLabelText:[selectedSpot.num_reviews stringValue]];
			[self.detailsCell setSpotCatsLabelText:[NSString stringWithFormat:NSLocalizedString(@"Category: %@", @""), [selectedSpot.spot_category getLocalizedName]]];
			//[self.detailsCell setSpecialityLabelText:selectedSpot.restaurantspeciality];
            
			[self updateDistanceLabel];
			compassNeedle = [UIImage imageNamed:@"icon-compass"];
            
            self.detailsCell.imageView.image = compassNeedle;

			self.detailsCell.accessoryType = UITableViewCellAccessoryNone;
			self.detailsCell.selectionStyle = UITableViewCellSelectionStyleNone;
			return self.detailsCell;
		
			
		} else if (indexPath.section == 1) {
			// reviews button
			static NSString *CellIdentifier = @"ReviewsCell";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell == nil) {
				
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				
			}
			NSString *browseText;
			int numReviews = [selectedSpot.num_reviews intValue];
            cell.imageView.image = [UIImage imageNamed:@"icon-review"];
			if ( numReviews == 1) {
				browseText = NSLocalizedString(@"Read 1 Review", @"");
				cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-accessory-arrow"]] autorelease];
			} else if (numReviews > 0) {
				browseText = [NSString stringWithFormat:NSLocalizedString(@"Browse %i Reviews", @""), numReviews];
				cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-accessory-arrow"]] autorelease];
			} else {
				browseText = NSLocalizedString(@"No Reviews of this Spot",@"");
				cell.accessoryType = UITableViewCellAccessoryNone;
			}
			cell.textLabel.text = browseText;
			
			return cell;
		} else if (indexPath.section == 2) {
			// phone
			static NSString *CellIdentifier = @"PhoneCell";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell == nil) {
				
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				
			}
			
            cell.imageView.image = [UIImage imageNamed:@"icon-phone"];
			if (![selectedSpot.phone isEqualToString:@"-1"]) {
			
				cell.textLabel.text = selectedSpot.phone;
				cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-accessory-arrow"]] autorelease];
			} else {
				cell.textLabel.text = NSLocalizedString(@"Unknown", @"phone number not known");
			}
			
			return cell;
		} else if (indexPath.section == 3)  {
			// address
			static NSString *CellIdentifier = @"MapCell";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell == nil) {
				
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				
			}
			
            cell.imageView.image = [UIImage imageNamed:@"icon-map-marker"];
			cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-accessory-arrow"]] autorelease];
			
            cell.textLabel.numberOfLines = 0;
			cell.textLabel.text = self.selectedSpot.address;
				
				
			return cell;
        } else if (indexPath.section == 4) {
             // add photo
            static NSString *CellIdentifier = @"PhotosCell";
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			
			if (cell == nil) {
				
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
				
			}
			
            cell.imageView.image = [UIImage imageNamed:@"icon-photos"];
			cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-accessory-arrow"]] autorelease];

			cell.textLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%i photos",nil), [[self.selectedSpot.spot_photos allObjects] count]];
            return cell;

        } 
			
			
}


-(void) updateDistanceLabel {
    SSCLController *ssCL = [SSCLController sharedSSCLController];	
    if (![ssCL isUsingGPS]) {
        [self.detailsCell setSpotDistanceLabelText:@"n.a."];
    } else {
        float distanceFromCenter = [self.selectedSpot distanceInMFromCoord:[ssCL searchCenter]];
        
        if (distanceFromCenter) {
            [self.detailsCell setSpotDistanceLabelText:[NSString stringWithFormat:@"%.0f m", distanceFromCenter]];
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) {
		return 100;
	} else if (indexPath.section == 4) {
		return 100;
	}
	return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	switch (indexPath.section) {
		case 0:
			break;
		case 1:
			if ([self.selectedSpot.num_reviews intValue] > 0 ) {
				[self viewReviews];
			}
			break;
		
		case 2: 
		{
			if (![self.selectedSpot.phone isEqualToString:@""]) {
                UIDevice *device = [UIDevice currentDevice];
                if ([[device model] isEqualToString:@"iPhone"] ) {
                    
                    
                    NSString *phoneNum = [NSString stringWithFormat:@"tel://%@", self.selectedSpot.phone];
                
                   
                    NSString *escaped = [phoneNum stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

                    [[UIApplication sharedApplication] openURL:[NSURL
                                                                URLWithString:escaped]];
                }
				
			}
			
		}
            break;
		case 3:
			[self viewOnMap];
			break;
        case 4:
            [self viewPhotos];
            break;
       	}
										
	
			
				
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[[NormalCellBackground alloc] init] autorelease];
    cell.selectedBackgroundView = [[[NormalCellBackground alloc] init] autorelease];
   
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.shadowOffset = CGSizeMake(0, 1);
    cell.textLabel.font = [UIFont fontWithName:@"Verdana" size:15];
    
    CALayer *l = [cell.backgroundView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:5.0];  
    [l setBorderWidth:1.0];
    [l setBorderColor:[[UIColor darkGrayColor] CGColor]];
}





#pragma mark    

-(void) viewPhotos {
    // Create array of `MWPhoto` objects
    self.photos = [NSMutableArray array];
    for (SpotPhoto *photo in [self.selectedSpot.spot_photos allObjects]) {
        MWPhoto *mphoto = [MWPhoto photoWithImage:photo.photo];
        mphoto.caption = photo.caption;
        [self.photos addObject:mphoto];
    }
    [self.photos addObjectsFromArray:[self.selectedSpot.spot_photos allObjects]];
    if ([self.photos count] == 0) {
        return;
    }
    // Create & present browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    // Set options
    browser.wantsFullScreenLayout = YES; // Decide if you want the photo browser full screen, i.e. whether the status bar is affected (defaults to YES)
    browser.displayActionButton = NO; // Show action button to save, copy or email photos (defaults to NO)
    [browser setInitialPageIndex:1]; // Example: allows second image to be presented first
    // Present
    [self.navigationController pushViewController:browser animated:YES];
    [browser release];
    
    
}

#pragma mark -
#pragma mark MWPhoto Delegate methods

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}




-(float) angleFromCoordinate:(CLLocationCoordinate2D)first 
                toCoordinate:(CLLocationCoordinate2D)second {
    
    float deltaLongitude = second.longitude - first.longitude;
    float deltaLatitude = second.latitude - first.latitude;
    float angle = (M_PI * .5f) - atan(deltaLatitude / deltaLongitude);
    
    if (deltaLongitude > 0)      return angle;
    else if (deltaLongitude < 0) return angle + M_PI;
    else if (deltaLatitude < 0)  return M_PI;
    
    return 0.0f;
}


#pragma mark -
#pragma mark SSCLControllerDelegate

-(void) headingDidUpdateTo:(CLHeading *)newHeading {
	
    
    // ignore if we don't have a location
    if (!self.selectedSpot.lat) {
        return;
    }
    CLLocationCoordinate2D spotCoord;
    spotCoord.latitude = [self.selectedSpot.lat floatValue];
    spotCoord.longitude = [self.selectedSpot.lng floatValue];
    float degrees = RADIANS_TO_DEGREES([self angleFromCoordinate:[[SSCLController sharedSSCLController] searchCenter] toCoordinate:spotCoord]);
    self.detailsCell.imageView.transform = CGAffineTransformMakeRotation((degrees - newHeading.magneticHeading - 135) * M_PI / 180);
        
	
}

-(void) locationDidUpdateFrom:(CLLocationCoordinate2D)oldCoordinate to:(CLLocationCoordinate2D)newCoordinate {
   
    // ignore if we don't have a location
    if (!self.selectedSpot.lat) {
        return;
    }
    [self updateDistanceLabel];
}


@end

