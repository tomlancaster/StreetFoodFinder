//
//  CoverFlowViewController.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/18/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "CoverFlowViewController.h"
#import "AFOpenFlowView.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"
#import "SpotCategory.h"
#import "SpotCategory+Extras.h"
#import "SpotListViewController.h"
#import "ApplicationDataService.h"
#import "CategoryDescriptionViewController.h"
#import "CategoryViewController.h"


@implementation CoverFlowViewController

@synthesize categories;
@synthesize selectedCat;
@synthesize showSpotsButton;
@synthesize showDescriptionButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.selectedCat = nil;
    self.categories = nil;
    self.showSpotsButton = nil;
    self.showDescriptionButton = nil;
}

-(void) dealloc {
    SafeRelease(categories);
    SafeRelease(selectedCat);
    SafeRelease(showSpotsButton);
    SafeRelease(showDescriptionButton);
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
#define kSelectedCat 3
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];

    // get categories
    self.categories = [[NSManagedObjectContext defaultManagedObjectContext] fetchAllOfEntity:[[NSManagedObjectContext defaultManagedObjectContext] entityDescriptionForName:@"SpotCategory"] predicate:nil sortKey:@"name_en_us" ascending:YES error:nil];
    
	
    int i = 0;
   
	for (SpotCategory *cat in categories) {
        if (cat.spotcategory_photo != nil) {
            [(AFOpenFlowView *)self.view setImage:cat.spotcategory_photo forIndex:i];
        } else {
            [(AFOpenFlowView *)self.view setImage:[UIImage imageNamed:@"279.png"] forIndex:i];
        }
        i++;
        
		NSLog(@"%d is the index",i);
        
	}
	[(AFOpenFlowView *)self.view setNumberOfImages:i+1];
    [(AFOpenFlowView *)self.view setViewDelegate:self];
    self.selectedCat = [self.categories objectAtIndex:kSelectedCat];
    
}

-(void) viewWillAppear:(BOOL)animated {
    //[self didRotateFromInterfaceOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

#pragma mark -
#pragma mark coverflow delegate methods

// delegate protocol to tell which image is selected
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index{
    if (index < [self.categories count] && index > -1) {
        self.selectedCat = [self.categories objectAtIndex:index];
    }
}

- (void)didSelectCoverIndex:(int)index {
    [self showSpotList];
}

// setting the image 1 as the default pic
- (UIImage *)defaultImage {
    
	return [[self.categories objectAtIndex:kSelectedCat] spotcategory_photo];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation==UIInterfaceOrientationPortrait) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate.transitionController transitionToViewController:appDelegate.categoryViewController withOptions:UIViewAnimationOptionTransitionCrossDissolve];
    }
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark event handling

-(IBAction)descriptionButtonPressed:(id)sender {
    [self showCurrentDescription];
}

-(IBAction)spotListButtonPressed:(id)sender {
    [self showSpotList];
}

-(void) showCurrentDescription {
    if (self.selectedCat != nil) {
        CategoryDescriptionViewController *controller = [[[CategoryDescriptionViewController alloc] initWithNibName:@"CategoryDescriptionViewController" bundle:nil] autorelease];
        controller.cat = self.selectedCat;
        
        [self presentModalViewController:controller animated:YES];
    }
}

-(void) showSpotList {
    SpotListViewController *controller = [[[SpotListViewController alloc] initWithNibName:@"SpotListViewController" bundle:nil] autorelease];
    controller.spotCategory = self.selectedCat;
    UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.transitionController transitionToViewController:navController withOptions:UIViewAnimationOptionTransitionCrossDissolve];
}


@end
