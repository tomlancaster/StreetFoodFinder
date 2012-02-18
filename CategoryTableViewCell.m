//
//  CategoryTableViewCell.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/17/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell
@synthesize descriptionButton;
@synthesize spotsButton;
@synthesize catLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc {
    SafeRelease(descriptionButton);
    SafeRelease(spotsButton);
    SafeRelease(catLabel);
    [super dealloc];
}

@end
