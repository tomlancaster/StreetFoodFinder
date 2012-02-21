//
//  ReviewTableViewController.m
//  HanoiCityCompanion
//
//  Created by Tom on 10/13/09.
//  Copyright 2009 Sunshine Open Solutions. All rights reserved.
//

#import "ReviewTableViewController.h"
#import "ReviewTableViewCell.h"

#import "NormalCellBackground.h"
#import "Review.h"


@implementation ReviewTableViewController
@synthesize reviews, spot, sortOrder;



- (void)dealloc {
	[reviews release];
	[spot release];
	
    [super dealloc];
}


- (void)viewDidLoad {

    [super viewDidLoad];
	self.navigationItem.title = NSLocalizedString(@"Reviews", @"");
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Sort", nil)
																			  style:UIBarButtonItemStyleBordered
																			 target:self
																			 action:@selector(popupActionSheet)] autorelease];
	
	[self sortReviewsBy:sortOrder];
	[self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[[UIView alloc] init] autorelease]];
	
}


- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	//NSLog(@"called numberof rows in section: %i", [reviews count]);
    return [self.reviews count];
}

/* from http://www.bdunagan.com/2009/06/28/custom-uitableviewcell-from-a-xib-in-interface-builder/ 
 this is a way to load a custom tableviewcell from a xib */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	//return [[UITableViewCell alloc] init];
	static NSString *CellIdentifier = @"ReviewTableViewCell";
    ReviewTableViewCell *cell = (ReviewTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	

    if (cell == nil) {
		// Create a temporary UIViewController to instantiate the custom cell.
        UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"ReviewTableViewCell" bundle:nil];
		// Grab a pointer to the custom cell.

        cell = (ReviewTableViewCell *)temporaryController.view;
        [temporaryController release];
    }
	
	
	Review *currentReview = [self.reviews objectAtIndex:indexPath.row];
	NSString *reviewerLabelValue = currentReview.username;
	
	[cell setRating:[currentReview.rating floatValue]];

	
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"MMM d ''yy"]; 
	NSString *dateString = [dateFormat stringFromDate:currentReview.created_on];
	[dateFormat release];
	
	NSString *dateFormatString = NSLocalizedString(@"on %@, %@ said...", @"");
	[cell setReviewerLabelText:[NSString stringWithFormat:dateFormatString, dateString, reviewerLabelValue]];
	
    [cell.reviewLabel setText:currentReview.body];
    //[cell.reviewLabel sizeToFit];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

	
	/* add the numer of pixels in the top meta row to the calculation of the review height given its width, text, font and linebreak mode */
	float rowHeight = 40.0; /* height of top row */
	Review  *currentReview = [self.reviews objectAtIndex:indexPath.row];
	NSString *text = currentReview.body;
	//NSLog(@"review body: %@", text);
	UIFont *font = [UIFont fontWithName:@"Verdana" size:FONT_SIZE];
    
	float tableWidth = [tableView frame].size.width - 20;
    DLog(@"tableWidth: %f", tableWidth);
	struct CGSize suggestedSize;
	suggestedSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(tableWidth, 20000.0) lineBreakMode:UILineBreakModeWordWrap];
	//NSLog(@"suggested size: %f", suggestedSize.height);
	
	return suggestedSize.height + rowHeight + 10.0; /* add some padding */
}

#pragma mark action sheet methods

-(void)popupActionSheet {
	UIActionSheet *popupQuery = [[UIActionSheet alloc]
								 initWithTitle:nil
								 delegate:self
								 cancelButtonTitle:@"Cancel"
								 destructiveButtonTitle:nil
								 otherButtonTitles:NSLocalizedString(@"Sort by Date", @""), NSLocalizedString(@"Sort by Stars",@""),nil];
	
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
	[popupQuery showInView:self.view];
	[popupQuery release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
	[self sortReviewsBy:buttonIndex];
	[self.tableView reloadData];
}


-(void) sortReviewsBy:(NSInteger)code {
	
	if (code == 0) {
		
		NSSortDescriptor *dateSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"created_on" ascending:NO selector:@selector(compare:)] autorelease];
		[self.reviews sortUsingDescriptors:[NSArray arrayWithObjects:dateSortDescriptor, nil]];
		
		//Sort by Date
	} else if (code == 1) {
		// Sort By Stars
		NSSortDescriptor *ratingSortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"rating" ascending:NO selector:@selector(compare:)] autorelease];
		[self.reviews sortUsingDescriptors:[NSArray arrayWithObjects:ratingSortDescriptor, nil]];
	} 
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
	





@end

