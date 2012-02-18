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
    UIView *landscapeView;
    IBOutlet UIView *portraitView;
    IBOutlet UIBarButtonItem *searchButton;
    IBOutlet UIBarButtonItem *nearbyButton;

}

@property (nonatomic, retain) UIView *landscapeView;
@property (nonatomic, retain) UIView *portraitView;
@property (nonatomic, retain) UIBarButtonItem *searchButton;
@property (nonatomic, retain) UIBarButtonItem *nearbyButton;

-(IBAction) openSearchView:(id)sender;

-(IBAction)openNearbyView:(id)sender;

-(IBAction)descriptionButtonPressed:(id)sender;
-(IBAction)spotsButtonPressed:(id)sender;

-(void) openSpotListPageWithCat:(SpotCategory *) cat;
-(void) openDescriptionOfCategory:(SpotCategory *) cat;
@end
