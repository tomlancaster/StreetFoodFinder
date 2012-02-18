//
//  CoverFlowViewController.m
//  StreetFoodFinder
//
//  Created by Tom Lancaster on 2/18/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "CoverFlowViewController.h"
#import "AFOpenFlowView.h"

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
    
	NSString *imageName;
    NSArray *imagesArray = [NSArray arrayWithObjects:@"58",@"56",@"279",@"54", nil];
    int i = 0;
	for (NSString *picNumber in imagesArray) {
		imageName = [NSString stringWithFormat:@"%@.png", picNumber];
		[(AFOpenFlowView *)self.view setImage:[UIImage imageNamed:imageName] forIndex:i];
        i++;
		NSLog(@"%d is the index",i);
        
	}
	[(AFOpenFlowView *)self.view setNumberOfImages:i+1];
}

#pragma mark -
#pragma mark coverflow delegate methods

// delegate protocol to tell which image is selected
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index{
    
	NSLog(@"%d is selected",index);
    
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
