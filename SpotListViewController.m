//
//  SpotListViewController.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/16/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "SpotListViewController.h"
#import "NSManagedObjectContext+Helpers.h"
#import "NSManagedObjectContext+SimpleFetches.h"
#import "Spot.h"
#import "Spot+Extras.h"
#import "SpotCategory.h"
#import "SpotCategory+Extras.h"
#import "SpotDetailViewController.h"
#import "SpotSearchTableViewCell.h"
#import "NormalCellBackground.h"
#import "CategoryViewController.h"
#import "CoverFlowViewController.h"

@implementation SpotListViewController
@synthesize sortButton;
@synthesize spotCategory;
@synthesize myTableView;
@synthesize spots;
@synthesize sortBy;
@synthesize myNavBar;
@synthesize myNavItem;
@synthesize backButton;

-(void) dealloc {
    SafeRelease(sortButton);
    SafeRelease(spotCategory);
    SafeRelease(spots);
    SafeRelease(myTableView);
    SafeRelease(myNavBar);
    SafeRelease(myNavItem);
    SafeRelease(backButton);
    sortBy = 0;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Spot *spot = [self.spots objectAtIndex:indexPath.row];
    [(SpotSearchTableViewCell *) cell initializeWithSpot:spot];
    cell.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-accessory-arrow"]] autorelease];
    
}

#pragma mark -
#pragma mark UITableView methods

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [self.spots count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SpotSearchTableViewCell";
    SpotSearchTableViewCell *cell = (SpotSearchTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		// Create a temporary UIViewController to instantiate the custom cell.
        UIViewController *temporaryController = [[[UIViewController alloc] initWithNibName:@"SpotSearchTableViewCell" bundle:nil] autorelease];
		// Grab a pointer to the custom cell.
        cell = (SpotSearchTableViewCell *)temporaryController.view;
        
    }
    
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SpotDetailViewController *controller = [[[SpotDetailViewController alloc] initWithNibName:@"SpotDetails" bundle:nil] autorelease];
    controller.selectedSpot = [self.spots objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    cell.backgroundView = [[[NormalCellBackground alloc] init] autorelease];
    cell.selectedBackgroundView = [[[NormalCellBackground alloc] init] autorelease];
 
    CALayer *l = [cell.backgroundView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:5.0];  
    [l setBorderWidth:1.0];
    [l setBorderColor:[[UIColor darkGrayColor] CGColor]];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [myTableView setBackgroundView:nil];
    [myTableView setBackgroundView:[[[UIView alloc] init] autorelease]];
    self.navigationItem.rightBarButtonItem = self.sortButton;
    self.navigationItem.leftBarButtonItem = self.backButton;
    self.navigationController.navigationBar.tintColor = TNH_RED;
    self.backButton.title = NSLocalizedString(@"Dishes", @"button title");
    if (self.spotCategory != nil) {
        self.title = [self.spotCategory getLocalizedName];
    } else {
        self.title = NSLocalizedString(@"Search Results", @"screen title");
    }
    self.sortButton.title = NSLocalizedString(@"Sort", @"change order");
    if (self.spotCategory != nil) {
        self.spots = [self.spotCategory.spots allObjects];
    }
    if (self.sortBy > 0) {
        [self sortSpotsBy:self.sortBy];
        [self.myTableView reloadData];
    }
}

-(void) viewWillAppear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark event handling

-(IBAction)backButtonPressed:(id)sender {
    [self openCategoryView];
}

-(void) openCategoryView {
     AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
        CategoryViewController *controller = [[[CategoryViewController alloc] initWithNibName:@"CategoryViewController"  bundle:nil] autorelease];
        [appDelegate.transitionController transitionToViewController:controller withOptions:UIViewAnimationOptionTransitionNone];
    } else {
        CoverFlowViewController *controller = [[[CoverFlowViewController alloc] initWithNibName:@"CoverFlowViewController" bundle:nil] autorelease];
        [appDelegate.transitionController transitionToViewController:controller withOptions:UIViewAnimationOptionTransitionNone];
    }
}

#pragma mark action sheet methods

-(IBAction)sortButtonPressed:(id)sender {
    [self popupActionSheet];
}

-(void)popupActionSheet {
	UIActionSheet *popupQuery = [[UIActionSheet alloc]
								 initWithTitle:nil
								 delegate:self
								 cancelButtonTitle:@"Cancel"
								 destructiveButtonTitle:nil
								 otherButtonTitles:NSLocalizedString(@"Sort by Distance", @""),
                                 NSLocalizedString(@"Sort By Rating",@""),
                                 NSLocalizedString(@"Sort by Name",@""),nil];
	
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
	[popupQuery release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	[self sortSpotsBy:buttonIndex];
	[self.myTableView reloadData];
}


-(void) sortSpotsBy:(NSInteger)code {
	
	if (code == 0) { // distance
		self.spots = [self.spots sortedArrayUsingSelector:@selector(sortByDistance:)];
	} else if (code == 1) { // rating
		self.spots = [self.spots sortedArrayUsingSelector:@selector(sortByRating:)];
	} else if (code == 2) { // name
		self.spots = [self.spots sortedArrayUsingSelector:@selector(sortByName:)];
	}
}


@end
