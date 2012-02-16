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

@implementation SpotListViewController
@synthesize sortButton;
@synthesize spotCategory;
@synthesize myTableView;
@synthesize spots;

-(void) dealloc {
    SafeRelease(sortButton);
    SafeRelease(spotCategory);
    SafeRelease(spots);
    SafeRelease(myTableView);
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
    
    Spot *info = [self.spots objectAtIndex:indexPath.row];
    cell.textLabel.text = info.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Distance: %f", [info getDistanceFromHere]];
    
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
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = 
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle 
                 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = self.sortButton;
    if (self.spotCategory != nil) {
        self.title = [self.spotCategory getLocalizedName];
    } else {
        self.title = NSLocalizedString(@"Search Results", @"screen title");
    }
    self.sortButton.title = NSLocalizedString(@"Sort", @"change order");
    if (self.spotCategory != nil) {
        self.spots = [self.spotCategory.spots allObjects];
    }
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
	
	if (code == 0) {
		self.spots = [self.spots sortedArrayUsingSelector:@selector(sortByDistance:)];
		
		//Sort by Date
	} else if (code == 1) {
		self.spots = [self.spots sortedArrayUsingSelector:@selector(sortByRating:)];
	} else if (code == 2) {
		self.spots = [self.spots sortedArrayUsingSelector:@selector(sortByName:)];
	}
}


@end
