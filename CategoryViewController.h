//
//  CategoryViewController.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/10/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AFOpenFlowView.h"
#import "SSViewController.h"
@class SpotCategory;

@interface CategoryViewController : SSViewController  {

    IBOutlet UIBarButtonItem *nearbyButton;
    IBOutlet UINavigationBar *myNavbar;
    IBOutlet UINavigationItem *myNavItem;

}

@property (nonatomic, retain) UIBarButtonItem *nearbyButton;
@property (nonatomic, retain) UINavigationBar *myNavBar;
@property (nonatomic, retain) UINavigationItem *myNavItem;


-(IBAction)openNearbyView:(id)sender;

-(IBAction)descriptionButtonPressed:(id)sender;
-(IBAction)spotsButtonPressed:(id)sender;


-(void) openSpotListPageWithCat:(SpotCategory *) cat;
-(void) openDescriptionOfCategory:(SpotCategory *) cat;

@end
