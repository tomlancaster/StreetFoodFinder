//
//  CustomCellBackground.m
//  XCC
//
//  Created by Tom Lancaster on 10/19/11.
//  Copyright (c) 2011 Sunshine Open Solutions. All rights reserved.
//

#import "CustomCellBackground.h"
#import "Common.h"

@implementation CustomCellBackground

@synthesize topColor;
@synthesize bottomColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    
        
    CGRect paperRect = self.bounds;
    
    drawLinearGradient(context, paperRect, self.topColor, self.bottomColor);
}

-(void) dealloc {
    SafeRelease(topColor);
    SafeRelease(bottomColor);
    [super dealloc];
}


@end
