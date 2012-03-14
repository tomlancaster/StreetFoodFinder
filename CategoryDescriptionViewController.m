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

@implementation CategoryDescriptionViewController

@synthesize lBodyTextView;
@synthesize lCatImageView;
@synthesize pBodyTextView;
@synthesize pCatImageView;
@synthesize pView;
@synthesize lView;
@synthesize cat;
@synthesize myNavBar;
@synthesize myNavItem;
@synthesize backButton;

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.pBodyTextView = nil;
    self.pCatImageView = nil;
    self.lBodyTextView = nil;
    self.lCatImageView = nil;
    self.lView = nil;
    self.pView = nil;
}

-(void) dealloc {
    SafeRelease(pBodyTextView);
    SafeRelease(pCatImageView);
    SafeRelease(lBodyTextView);
    SafeRelease(lCatImageView);
    SafeRelease(lView);
    SafeRelease(pView);
    SafeRelease(cat);
    SafeRelease(myNavBar);
    SafeRelease(myNavItem);
    SafeRelease(backButton);
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
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    self.myNavItem.title = [self.cat getLocalizedName];
    
    self.myNavItem.leftBarButtonItem = self.backButton;
    self.lCatImageView.image = self.cat.spotcategory_photo;
    self.lBodyTextView.text = [self.cat getLocalizedDescription];
        
    self.pCatImageView.image = self.cat.spotcategory_photo;
    self.pBodyTextView.text = [self.cat getLocalizedDescription];
}

-(void) viewWillAppear:(BOOL)animated {
    
    // which view to show?
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation) ) {
        [self.view addSubview:self.lView];
        [self.pView removeFromSuperview];
    } else {
        [self.view addSubview:self.pView];
        [self.lView removeFromSuperview];
    }
    

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
                                        
-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (UIDeviceOrientationIsLandscape(toInterfaceOrientation)) {
        [self.lView setHidden:NO];
        [self.pView setHidden:YES];
    } else {
        [self.lView setHidden:YES];
        [self.pView setHidden:NO];
    }
}

-(IBAction)backButtonPressed:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}



@end
