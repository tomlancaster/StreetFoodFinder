//
//  AddAnnotation.m
//  Exercise
//
//  Created by Tom on 9/4/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import "AddAnnotation.h"


@implementation AddAnnotation

@synthesize coordinate,mtitle,msubtitle, spot;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

- (NSString *) title {
	return [self mtitle];
}

- (NSString *) subtitle {
	return [self msubtitle];
}

-(void) dealloc {
	
	SafeRelease(spot);
	[super dealloc];
}

@end
