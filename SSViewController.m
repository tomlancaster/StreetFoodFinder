//
//  SSViewController.m
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/11/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "SSViewController.h"
#import "Telco.h"
#import "Telco+Extras.h"
#import "User.h"
#import "AppDelegate.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"

@implementation SSViewController

@synthesize HUD;
@synthesize myTableView;
@synthesize telcoImages;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        [self initHUD];
        self.view.backgroundColor = COLOR_BEIGE;
         self.telcoImages = [NSArray arrayWithObjects:@"viettel_50x50", @"mobifone_50x50", @"vinaphone_50x50", @"vietnamobile_50x50", @"beeline_50x50", @"sfone_50x50", @"evn_50x50", nil];
        self.myTableView.backgroundColor = [UIColor clearColor];
        self.myTableView.separatorColor = [UIColor lightGrayColor];
       // self.myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return self;
}

-(void) dealloc {
    HUD.delegate = nil;
    [HUD hide:YES];
    SafeRelease(HUD);
    SafeRelease(myTableView);
    SafeRelease(telcoImages);
    [super dealloc];
}

-(void) initHUD {
    
    self.HUD = [[MBProgressHUD alloc] initWithWindow:((AppDelegate *)[[UIApplication sharedApplication] delegate]).window];
    self.HUD.delegate = self;
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window addSubview:self.HUD];
	
}


- (void)hudWasHidden {
    // Remove HUD from screen when the HUD was hidded
    
    [self.HUD removeFromSuperview];
    
}
-(void) populateTelcoFromResponse:(NSString *) response  {
    
    [self doPopulateWithResponse:response];
    //    self.HUD.labelText = NSLocalizedString(@"Synching Data", nil);
    //  [self.HUD showWhileExecuting:@selector(doPopulateWithResponse:) onTarget:self withObject:response animated:YES];
    
}

-(void) doPopulateWithResponse:(NSString *) response {
    User *theUser = GetGlobalUser();
    [Telco populateFromResponse:response withUser:theUser]; 
    NSError *error;
    if (![[NSManagedObjectContext defaultManagedObjectContext] save:&error]) {
		
		DLog(@"error: %@", [error localizedDescription]);
		
		if (error != nil) {
			// [error retain];
			DLog(@"Failed to save merged %@: %@", @"viewcontroller", [error localizedDescription]);
			NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
			if(detailedErrors != nil && [detailedErrors count] > 0) {
				for(NSError* detailedError in detailedErrors) {
					DLog(@"  DetailedError: %@", [detailedError userInfo]);
				}
			}
			else {
				DLog(@"  %@", [error userInfo]);
				
			}
		}
		//return nil;
		
	}    
  
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath  {
    [cell.textLabel setFont:FONT_MAIN];
    [cell.detailTextLabel setFont:FONT_DETAIL];
}
@end
