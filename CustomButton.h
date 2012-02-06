//
//  CustomButton.h
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/12/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

@class CAGradientLayer;

@interface CustomButton : UIButton {
@private
	UIColor* _gradientStartColor;
	UIColor* _gradientEndColor;
    
	CAGradientLayer* _gradientLayer;
    CAGradientLayer* _glossyLayer;
}

@property (nonatomic, retain) UIColor* gradientStartColor;
@property (nonatomic, retain) UIColor* gradientEndColor;

@end