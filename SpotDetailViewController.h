//
//  SpotDetailViewController.h
//  HanoiCityCompanion
//
//  Created by Tom on 2/6/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewTableViewController.h"
#import "Spot.h"
#import "SpotDetailsTableViewCell.h"
#import "SSCLController.h"
#import "MWPhotoBrowser.h"

@interface SpotDetailViewController : UIViewController <UITableViewDelegate, 
UITableViewDataSource,  UINavigationControllerDelegate, UIPopoverControllerDelegate , SSCLControllerDelegate, MWPhotoBrowserDelegate> {
	
	Spot *selectedSpot;
	NSArray *reviews;
	IBOutlet UITableView *myTableView;
    NSNumber *selectedSpotId;
    UIPopoverController *popoverController;
    IBOutlet UIImageView *imageView;
    UIImage *compassNeedle;
    SpotDetailsTableViewCell *detailsCell;
    NSMutableArray *photos;
}

-(void)viewReviews;
-(void)viewOnMap;

-(void) viewPhotos;

-(void) updateDistanceLabel;

-(float) angleFromCoordinate:(CLLocationCoordinate2D)first 
                toCoordinate:(CLLocationCoordinate2D)second ;

@property (retain) Spot *selectedSpot;
@property (nonatomic,retain) NSArray *reviews;

@property (nonatomic, retain) NSNumber *selectedSpotId;
@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) SpotDetailsTableViewCell *detailsCell;
@property (nonatomic, retain) NSMutableArray *photos;




@end
