//
//  SpotListViewController.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/16/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "SSViewController.h"
@class SpotCategory;

@interface SpotListViewController : UIViewController <UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource>{
    IBOutlet UIBarButtonItem *sortButton;
   // IBOutlet UIPickerView *pickerView;
    IBOutlet UITableView *myTableView;
    NSArray *spots;
    SpotCategory *spotCategory;
    NSInteger sortBy;
    IBOutlet UINavigationBar *myNavbar;
    IBOutlet UINavigationItem *myNavItem;
    IBOutlet UIBarButtonItem *backButton;
}

@property (nonatomic, retain) UIBarButtonItem *sortButton;
@property (nonatomic, retain) UITableView *myTableView;
@property (nonatomic, retain) SpotCategory *spotCategory;
@property (nonatomic, retain) NSArray *spots;
@property (nonatomic, assign) NSInteger sortBy;
@property (nonatomic, retain) UINavigationBar *myNavBar;
@property (nonatomic, retain) UINavigationItem *myNavItem;
@property (nonatomic, retain) UIBarButtonItem *backButton;

-(IBAction)sortButtonPressed:(id)sender;
-(IBAction)backButtonPressed:(id)sender;
-(void)popupActionSheet;
-(void) sortSpotsBy:(NSInteger)code ;
-(void) openCategoryView;
@end
