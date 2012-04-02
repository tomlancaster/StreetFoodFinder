//
//  CategoryDescriptionViewController.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 3/7/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "CategoryDescriptionViewController.h"
#import "SpotCategory.h"
#import "SpotCategory+Extras.h"
#import "AppDelegate.h"
#import "RMMapViewController.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"

@implementation CategoryDescriptionViewController

@synthesize bodyTextView;
@synthesize catImageView;
@synthesize cat;
@synthesize myNavBar;
@synthesize myNavItem;
@synthesize backButton;
@synthesize mapButton;

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.bodyTextView = nil;
    self.catImageView = nil;


}

-(void) dealloc {
    SafeRelease(bodyTextView);
    SafeRelease(catImageView);
    SafeRelease(cat);
    SafeRelease(myNavBar);
    SafeRelease(myNavItem);
    SafeRelease(backButton);
    SafeRelease(mapButton);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[[self navigationController] setNavigationBarHidden:NO animated:NO];

    self.myNavItem.leftBarButtonItem = self.backButton;
    self.myNavItem.title = [self.cat getLocalizedName];
    self.myNavBar.tintColor = TNH_RED;
    self.myNavItem.rightBarButtonItem = self.mapButton;
    
    self.catImageView.image = self.cat.spotcategory_photo;
    self.bodyTextView.text = [self.cat getLocalizedDescription];
    [FlurryAnalytics logPageView];

}

-(void) viewWillAppear:(BOOL)animated {
    
    // which view to show?
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ) {
        [self.catImageView setFrame:CGRectMake(13, 55, 225, 225)];
        [self.bodyTextView setFrame:CGRectMake(246, 55, 228, 225)];
    } else {
        [self.catImageView setFrame:CGRectMake(48, 56, 225, 225)];
        [self.bodyTextView setFrame:CGRectMake(10, 289, 300, 165)];
    }
    [self.myNavBar setFrame:CGRectMake(0.0 , 0.0, self.view.frame.size.width, 44.0)];


}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
                                        
-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
        [self.catImageView setFrame:CGRectMake(13, 55, 225, 225)];
        [self.bodyTextView setFrame:CGRectMake(246, 55, 228, 225)];
    } else {
        [self.catImageView setFrame:CGRectMake(48, 56, 225, 225)];
        [self.bodyTextView setFrame:CGRectMake(10, 289, 300, 165)];
    }
    [self.myNavBar setFrame:CGRectMake(0.0 , 0.0, self.view.frame.size.width, 44.0)];
}

#pragma mark -
#pragma mark event handling

-(IBAction)backButtonPressed:(id)sender {
    [self openCategoryView];
}

-(IBAction)mapButtonPressed:(id)sender {
    [self viewAllOnMap];
}

-(void) openCategoryView {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
       
        [appDelegate.transitionController transitionToViewController:appDelegate.categoryViewController withOptions:UIViewAnimationOptionTransitionNone];
    } else {
        
        [appDelegate.transitionController transitionToViewController:appDelegate.coverFlowViewController withOptions:UIViewAnimationOptionTransitionNone];
    }
}

-(void) viewAllOnMap {
    RMMapViewController *controller = [[[RMMapViewController alloc] init] autorelease];
    
    controller.hidesBottomBarWhenPushed = YES;
    controller.spots = [self.cat.spots allObjects];
    UINavigationController *navC = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.transitionController transitionToViewController:navC withOptions:UIViewAnimationOptionTransitionNone];
    //[self presentModalViewController:navC animated:YES];
}



@end
