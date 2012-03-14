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
    IBOutlet UIImageView *pCatImageView;
    IBOutlet UITextView *pBodyTextView;
    IBOutlet UIImageView *lCatImageView;
    IBOutlet UITextView *lBodyTextView;
    IBOutlet UIView *pView;
    IBOutlet UIView *lView;
    SpotCategory *cat;
    IBOutlet UINavigationBar *myNavBar;
    IBOutlet UINavigationItem *myNavItem;
    IBOutlet UIBarButtonItem *backButton;
    
}
-(IBAction)backButtonPressed:(id)sender;

@property (nonatomic, retain) UIImageView *lCatImageView;
@property (nonatomic, retain) UITextView *lBodyTextView;
@property (nonatomic, retain) UIImageView *pCatImageView;
@property (nonatomic, retain) UITextView *pBodyTextView;
@property (nonatomic, retain) UIView *lView;
@property (nonatomic, retain) UIView *pView;
@property (nonatomic, retain) SpotCategory * cat;
@property (nonatomic, retain) UINavigationBar *myNavBar;
@property (nonatomic, retain) UINavigationItem *myNavItem;
@property (nonatomic, retain) UIBarButtonItem *backButton;

@end
