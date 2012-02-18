//
//  SpotSearchTableViewCell.m
//  HanoiCityCompanion
//
//  Created by Tom on 10/11/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import "SpotSearchTableViewCell.h"
#import "SSCLController.h"
#import "RatingView.h" 
#import "Spot+Extras.h"
#import "SpotCategory+Extras.h"

@implementation SpotSearchTableViewCell

@synthesize isAd;
@synthesize adLinkButton;
@synthesize spot;


-(void) initializeWithSpot:(Spot *) theSpot {
    self.spot = theSpot;
    [self setSpotNameLabelText:spot.name];	
	[self setRating:[spot.star_rating floatValue]];
	[self setSpotAddressLabelText:spot.address];
	[self setSpotNumRatingsLabelText:[spot.num_reviews stringValue]];
	
	
	[self setSpotCategoriesLabelText:[spot.spot_category getLocalizedName]];

    
    [self updateDistanceLabel];
    //[self calculateUserAngle:user];

    
}

- (void)setRating:(float)newRating
{
	[ratingView setRating:newRating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSpotNameLabelText:(NSString *)_text {
	spotNameLabel.text = _text;	
}
-(void)setSpotAddressLabelText:(NSString *)_text {
	spotAddressLabel.text = _text;	
}

-(void)setSpotDistanceLabelText:(NSString *)_text {
	spotDistanceLabel.text = _text;
}

-(void) updateDistanceLabel {
    SSCLController *ssCL = [SSCLController sharedSSCLController];	
	if (![ssCL isUsingGPS]) {
		[self setSpotDistanceLabelText:@"n.a."];
	} else {
		float distanceFromCenter;
		distanceFromCenter = [self.spot distanceInMFromCoord:[ssCL searchCenter]];
		if (distanceFromCenter >= 0) {
			[self setSpotDistanceLabelText:[NSString stringWithFormat:@"%.0f m", distanceFromCenter]];
		}
		
	}
 
}
	
-(void)setSpotNumRatingsLabelText:(NSString *)_text {
	if ([_text isEqualToString:@"1"] ) {
		NSString *review = NSLocalizedString(@"%@ review", @"");
		spotNumRatingsLabel.text = [NSString stringWithFormat:review, _text];
	} else {
		NSString *review = NSLocalizedString(@"%@ reviews", @"");
		spotNumRatingsLabel.text = [NSString stringWithFormat:review, _text];
	}
}

-(void)setSpotCategoriesLabelText:(NSString *)_text {
	SpotCategoriesLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Category: %@", @""), _text];
}

- (void)dealloc {
    SafeRelease(spotNameLabel);
    SafeRelease(adLinkButton);
    SafeRelease(spotAddressLabel);
    SafeRelease(spotRatingLabel);
    SafeRelease(spotNumRatingsLabel);
    SafeRelease(spotDistanceLabel);
    SafeRelease(ratingView);
    SafeRelease(SpotCategoriesLabel);

    SafeRelease(spot);

    [super dealloc];
}



#pragma mark events



@end
