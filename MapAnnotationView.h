//
//  MapAnnotationView.h
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/15/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapAnnotationView : UIViewController {
    IBOutlet UILabel *label;
}

@property (nonatomic, retain) UILabel *label;
@end
