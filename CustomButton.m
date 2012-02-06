//
//  CustomButton.m
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/12/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "CustomButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation CustomButton

@synthesize gradientStartColor = _gradientStartColor;
@synthesize gradientEndColor = _gradientEndColor;


-(void)awakeFromNib;
{
    _gradientLayer = [[CAGradientLayer alloc] init];
    _gradientLayer.bounds = self.bounds;
    
    _gradientLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    _glossyLayer = [[CAGradientLayer alloc] init];
	_glossyLayer.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2);
    _glossyLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/4);
    [self.layer addSublayer:_glossyLayer];
    
    [self.layer insertSublayer:_gradientLayer atIndex:0];
    
    
	self.layer.cornerRadius = 5.0f; // пусть будет хардкод, для теста
	self.layer.masksToBounds = YES;
	self.layer.borderWidth = 1.0f; 
    
}

-(id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        if (!CGRectIsEmpty(frame)) {
            [self setFrame:frame];
        }
        

    }
    return self;
}

-(void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    _gradientLayer = [[CAGradientLayer alloc] init];
    _gradientLayer.bounds = self.bounds;
    
    _gradientLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    
    _glossyLayer = [[CAGradientLayer alloc] init];
    _glossyLayer.bounds = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2);
    _glossyLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/4);
    [self.layer addSublayer:_glossyLayer];
    
    [self.layer insertSublayer:_gradientLayer atIndex:0];
    
    
    self.layer.cornerRadius = 5.0f; // пусть будет хардкод, для теста
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1.0f; 
}

// draw gradient layer

- (void)drawRect:(CGRect)rect;
{
    if (_gradientStartColor && _gradientEndColor)
    {
        [_gradientLayer setColors:
		 [NSArray arrayWithObjects: (id)[_gradientStartColor CGColor]
		  , (id)[_gradientEndColor CGColor], nil]];
    }
    
    [_glossyLayer setColors:
	 [NSArray arrayWithObjects: 
	  (id)[[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.99f] CGColor]
	  , (id)[[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.2f] CGColor], nil]];
    
    [super drawRect:rect];
}

- (void)dealloc {
	[_gradientEndColor release];
	[_gradientStartColor release];
	[_gradientLayer release];
    [super dealloc];
}

@end