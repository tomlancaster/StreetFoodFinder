//
//  SpotDetailsTableViewCell.m
//  HanoiCityCompanion
//
//  Created by Tom on 2/6/10.
//  Copyright 2010 Sunshine Open Solutions. All rights reserved.
//

#import "SpotDetailsTableViewCell.h"


@implementation SpotDetailsTableViewCell

@synthesize imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setRating:(float)newRating
{
	ratingView.rating = newRating;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

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


-(void)setSpotNumRatingsLabelText:(NSString *)_text {
	if ([_text isEqualToString:@"1"] ) {
		NSString *review = NSLocalizedString(@"%@ review", @"");
		spotNumRatingsLabel.text = [NSString stringWithFormat:review, _text];
	} else {
		NSString *review = NSLocalizedString(@"%@ reviews", @"");
		spotNumRatingsLabel.text = [NSString stringWithFormat:review, _text];
	}
}

-(void)setSpotCatsLabelText:(NSString *)_text {
	spotCatsLabel.text = _text;
}

-(void)setSpecialityLabelText:(NSString *)_text {
	specialityLabel.text = _text;
}

/*
-(void)setImageURL:(NSString *) logoURL {
    TTImageView *theImage = [[[TTImageView alloc] init] autorelease];
    theImage.frame = CGRectMake(0,0,60,60);
    theImage.delegate = self;
    if (![logoURL isEqualToString:@""]) {
        theImage.urlPath = [NSString stringWithFormat:@"%@%@", WEB_BASE_URL, logoURL];
    } else {
        return;
    }
    
   
    theImage.backgroundColor = [UIColor clearColor];
    [theImage.layer setMasksToBounds:YES];
    //[spotImage.layer setCornerRadius:4.0f];
    [theImage.layer setBorderWidth:0.0f];
    [theImage.layer setCornerRadius:4.0f];
    //[spotImage.layer setBorderWidth: 2.0f];
    //spotImage.backgroundColor = [UIColor clearColor];
    [spotImage addSubview:theImage];
}
 */

- (void)dealloc {
	SafeRelease(spotNameLabel);
    SafeRelease(spotAddressLabel);
    SafeRelease(spotRatingLabel);
    SafeRelease(spotNumRatingsLabel);
    SafeRelease(spotDistanceLabel);
    SafeRelease(ratingView);
    SafeRelease(spotImage);
    SafeRelease(spotCatsLabel);
    SafeRelease(specialityLabel);
    SafeRelease(imageView);
    SafeRelease(spinner);
    [super dealloc];
}

#pragma mark -
#pragma mark TTImageViewDelegate

- (void)imageViewDidStartLoad {
    spinner.hidden = NO;
}


@end
