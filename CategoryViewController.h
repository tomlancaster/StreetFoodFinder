//
//  CategoryViewController.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/10/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AFOpenFlowView.h"
#import "SSViewController.h"

@interface CategoryViewController : SSViewController  {
    UIView *landscapeView;
    IBOutlet UIView *portraitView;
}

@property (nonatomic, retain) UIView *landscapeView;
@property (nonatomic, retain) UIView *portraitView;

@end
