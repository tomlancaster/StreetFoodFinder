//
//  ReviewTableViewController.h
//  HanoiCityCompanion
//
//  Created by Tom on 10/13/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Spot.h"


@interface ReviewTableViewController : UITableViewController <UIActionSheetDelegate> {
	NSMutableArray *reviews;
	Spot *spot;
	NSInteger sortOrder;
	
}
@property (retain) NSMutableArray *reviews;
@property (nonatomic, retain) Spot *spot;
@property  NSInteger sortOrder;

-(void)popupActionSheet;

-(void) sortReviewsBy:(NSInteger)code;

- (void) getReviews;

@end
