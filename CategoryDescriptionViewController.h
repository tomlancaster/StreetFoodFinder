//
//  CategoryDescriptionViewController.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/7/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SpotCategory;

@interface CategoryDescriptionViewController : UIViewController {
    IBOutlet UIImageView *catImageView;
    IBOutlet UITextView *bodyTextView;
    SpotCategory *cat;
    IBOutlet UINavigationBar *myNavBar;
    IBOutlet UINavigationItem *myNavItem;
    IBOutlet UIBarButtonItem *backButton;
    
}
-(IBAction)backButtonPressed:(id)sender;
-(void) openCategoryView;

@property (nonatomic, retain) UIImageView *catImageView;
@property (nonatomic, retain) UITextView *bodyTextView;
@property (nonatomic, retain) SpotCategory * cat;
@property (nonatomic, retain) UINavigationBar *myNavBar;
@property (nonatomic, retain) UINavigationItem *myNavItem;
@property (nonatomic, retain) UIBarButtonItem *backButton;

@end
