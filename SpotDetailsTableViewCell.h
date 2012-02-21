//
//  SpotDetailsTableViewCell.h
//  HanoiCityCompanion
//
//  Created by Tom on 2/6/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"


@interface SpotDetailsTableViewCell : UITableViewCell {
	
	IBOutlet UILabel *spotNameLabel;
	IBOutlet UILabel *spotAddressLabel;
	IBOutlet UILabel *spotRatingLabel;
	IBOutlet UILabel *spotNumRatingsLabel;
	IBOutlet UILabel *spotDistanceLabel; 
	IBOutlet RatingView *ratingView;
	IBOutlet UIImageView *spotImage;
	IBOutlet UILabel *spotCatsLabel;
	IBOutlet UILabel *specialityLabel;
    IBOutlet UIActivityIndicatorView *spinner;
    IBOutlet UIImageView *imageView;
	
}

@property (nonatomic, retain) UIImageView *imageView;


-(void)setSpotNameLabelText:(NSString *)_text;
-(void)setSpotAddressLabelText:(NSString *)_text;

-(void)setSpotNumRatingsLabelText:(NSString *)_text;
-(void)setRating:(float)newRating;
-(void)setSpotDistanceLabelText:(NSString *)_text;
-(void)setSpotCatsLabelText:(NSString *)_text;
-(void)setSpecialityLabelText:(NSString *)_text;

-(void)setImageURL:(NSString *) logoURL;
@end
