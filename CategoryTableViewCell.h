//
//  CategoryTableViewCell.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/17/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryTableViewCell : UITableViewCell {
    IBOutlet UIButton *descriptionButton;
    IBOutlet UIButton *spotsButton;
    IBOutlet UILabel *catLabel;
}

@property (nonatomic, retain) UIButton *descriptionButton;
@property (nonatomic, retain) UIButton *spotsButton;
@property (nonatomic, retain) UILabel *catLabel;

@end
