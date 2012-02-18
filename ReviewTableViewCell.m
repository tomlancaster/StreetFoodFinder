//
//  ReviewTableViewCell.m
//  HanoiCityCompanion
//
//  Created by Tom on 10/13/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import "ReviewTableViewCell.h"
#import "RatingView.h"

@implementation ReviewTableViewCell

@synthesize reviewerLabel, reviewRatingLabel, reviewDateLabel, ratingView, reviewLabel;


- (void)dealloc {
	
    [reviewerLabel release];
	[reviewRatingLabel release];
	[reviewDateLabel release];
	[ratingView release];
    SafeRelease(reviewLabel);
    [super dealloc];

}




- (void)setRating:(float)newRating
{
	ratingView.rating = newRating;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setReviewerLabelText:(NSString *)_text {
	reviewerLabel.text = _text;
}





@end
