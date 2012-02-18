//
//  SpotSearchTableViewCell.h
//  HanoiCityCompanion
//
//  Created by Tom on 10/11/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "SSCLController.h"
#import "Spot.h"


@interface SpotSearchTableViewCell : UITableViewCell  {
	

	
	IBOutlet UILabel *spotNameLabel;
	IBOutlet UILabel *spotAddressLabel;
	IBOutlet UILabel *spotRatingLabel;
	IBOutlet UILabel *spotNumRatingsLabel;
	IBOutlet UILabel *spotDistanceLabel; 
	IBOutlet RatingView *ratingView;
	IBOutlet UILabel *SpotCategoriesLabel;
	
    IBOutlet UIButton *adLinkButton;
    

	
    BOOL isAd;

    Spot *spot;


}

@property (nonatomic, assign) BOOL isAd;
@property (nonatomic, retain) UIButton *adLinkButton;
@property (nonatomic, retain) Spot *spot;


-(void)setSpotNameLabelText:(NSString *)_text;
-(void)setSpotAddressLabelText:(NSString *)_text;

-(void)setSpotNumRatingsLabelText:(NSString *)_text;
-(void)setRating:(float)newRating;
-(void)setSpotDistanceLabelText:(NSString *)_text;
-(void)setSpotCategoriesLabelText:(NSString *)_text;

-(IBAction)linkButtonClick:(id)sender;



-(void) initializeWithSpot:(Spot *) theSpot;

-(void) updateDistanceLabel;

@end
