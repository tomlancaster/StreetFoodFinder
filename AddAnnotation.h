//
//  AddAnnotation.h
//  Exercise
//
//  Created by Tom on 9/4/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Spot.h"

@interface AddAnnotation : NSObject<MKAnnotation> {

	CLLocationCoordinate2D coordinate;
	NSString *mtitle;
	NSString *msubtitle;
	Spot *spot;
}

@property (nonatomic,retain) NSString *mtitle;
@property (nonatomic, retain) NSString *msubtitle;
@property (nonatomic, retain) Spot *spot;

-(id)initWithCoordinate:(CLLocationCoordinate2D) c;
	
@end
