//
//  CoverFlowViewController.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/18/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFOpenFlowView.h"
@class SpotCategory;

@interface CoverFlowViewController : UIViewController <AFOpenFlowViewDelegate> {
    NSOperationQueue *loadImagesOperationQueue;
    NSArray *categories;
    SpotCategory *selectedCat;
    IBOutlet UIButton *showSpotsButton;
    IBOutlet UIButton *showDescriptionButton;
    
}

@property (nonatomic, retain) NSArray *categories;
@property (nonatomic, retain) SpotCategory *selectedCat;
@property (nonatomic, retain) UIButton *showSpotsButton;
@property (nonatomic, retain) UIButton *showDescriptionButton;

-(IBAction)descriptionButtonPressed:(id)sender;
-(IBAction)spotListButtonPressed:(id)sender;
-(void) showCurrentDescription;
-(void) showSpotList;

@end
