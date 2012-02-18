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

@implementation CoverFlowViewController

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
    [[self navigationController] setNavigationBarHidden:YES animated:NO];

    loadImagesOperationQueue = [[NSOperationQueue alloc] init];
    
    // get categories
    categories = [[NSManagedObjectContext defaultManagedObjectContext] fetchAllOfEntity:[[NSManagedObjectContext defaultManagedObjectContext] entityDescriptionForName:@"SpotCategory"] predicate:nil sortKey:@"name_en_us" ascending:YES error:nil];
    
	NSString *imageName;
   // NSArray *imagesArray = [NSArray arrayWithObjects:@"58",@"56",@"279",@"54", nil];
    int i = 0;
    NSString *path = [[NSBundle mainBundle] resourcePath];
	for (SpotCategory *cat in categories) {
		imageName = [NSString stringWithFormat:@"%@.png", cat.spotcategory_id];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[path stringByAppendingPathComponent:imageName]]) {
            [(AFOpenFlowView *)self.view setImage:[UIImage imageNamed:imageName] forIndex:i];
        } else {
            [(AFOpenFlowView *)self.view setImage:[UIImage imageNamed:@"279.png"] forIndex:i];
        }
        i++;
		NSLog(@"%d is the index",i);
        
	}
	[(AFOpenFlowView *)self.view setNumberOfImages:i+1];
}

#pragma mark -
#pragma mark coverflow delegate methods

// delegate protocol to tell which image is selected
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index{
    
	SpotListViewController *controller = [[[SpotListViewController alloc] initWithNibName:@"SpotListViewController" bundle:nil] autorelease];
    controller.spotCategory = [categories objectAtIndex:index];
    [self.navigationController pushViewController:controller animated:YES];
    
}

// setting the image 1 as the default pic
- (UIImage *)defaultImage {
    
	return [UIImage imageNamed:@"58.png"];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation==UIInterfaceOrientationPortrait) {
        [self.navigationController popViewControllerAnimated:NO];
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

@end
