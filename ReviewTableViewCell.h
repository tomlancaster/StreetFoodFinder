//
//  ReviewTableViewCell.h
//  HanoiCityCompanion
//
//  Created by Tom on 10/13/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "RatingView.h"


@interface ReviewTableViewCell : UITableViewCell {
	UILabel *reviewerLabel;
	UILabel *reviewRatingLabel;
	UILabel *reviewDateLabel;
	RatingView *ratingView;
    IBOutlet UILabel *reviewLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *reviewerLabel;
@property (nonatomic, retain) IBOutlet UILabel *reviewRatingLabel;
@property (nonatomic, retain) IBOutlet UILabel *reviewDateLabel;
@property (nonatomic, retain) IBOutlet RatingView *ratingView;
@property (nonatomic, retain) UILabel *reviewLabel;

-(void)setReviewerLabelText:(NSString *)_text;

-(void)setRating:(float)newRating;


@end
