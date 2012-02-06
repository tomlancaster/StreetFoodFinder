//
//  RegistrationViewController.m
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import "RegistrationViewController.h"
#import "NSManagedObjectContext+Helpers.h"
#import "User+Extras.h"
#import "LoginViewController.h"
#import "JSONKit.h"
#import "User.h"
#import "Telco.h"
#import "Telco+Extras.h"
#import "Product.h"
#import "ViewController.h"
#import "ViewController.h"
@interface RegistrationViewController (Private)
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RegistrationViewController

@synthesize labels;
@synthesize placeholders;

@synthesize saveButton;
@synthesize myNavBar;
@synthesize user;
@synthesize loggedIn;
@synthesize loginButton;
@synthesize delegate;
@synthesize registerLabel;

- (void)dealloc {
    
    SafeRelease(labels);
    SafeRelease(placeholders);
    SafeRelease(saveButton);
    SafeRelease(myNavBar);
    SafeRelease(loginButton);
    SafeRelease(registerLabel);
    SafeRelease(headerView);
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.labels = [NSArray arrayWithObjects:NSLocalizedString(@"Name", nil),
                   NSLocalizedString(@"Email", nil),
                   NSLocalizedString(@"Password", nil),
                   NSLocalizedString(@"Confirm Password", nil),
                  
                   nil];
    
    self.placeholders = [NSArray arrayWithObjects:NSLocalizedString(@"Enter Name", nil),
                         NSLocalizedString(@"Enter Email", nil),
                         NSLocalizedString(@"Enter Password", nil),
                         NSLocalizedString(@"Enter Password Confirmation", nil),
                        
                         nil];
    myNavItem.title = NSLocalizedString(@"Register", @"");
    self.myNavBar.tintColor = [UIColor darkGrayColor];
    self.registerLabel.text = NSLocalizedString(@"Register to Mua Thẻ Cào", nil);
    self.registerLabel.font = FONT_MAIN;
    self.user = [[NSManagedObjectContext defaultManagedObjectContext] insertNewObjectForEntityWithName:@"User"];
   
    
}

-( void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([(AppDelegate *)[[UIApplication sharedApplication] delegate] isLoggedIn]) {
        [[NSManagedObjectContext defaultManagedObjectContext] deleteObject:self.user];
        [[NSManagedObjectContext defaultManagedObjectContext] save:nil];
        [self dismissModalViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark Table view data source

- (void)configureCell:(ELCTextfieldCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.leftLabel.text = [self.labels objectAtIndex:indexPath.row];
    cell.rightTextField.placeholder = [self.placeholders objectAtIndex:indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    //Disables UITableViewCell from accidentally becoming selected.
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    if (indexPath.row == 2 || indexPath.row == 3) {
        [cell.rightTextField setSecureTextEntry:YES];
    }
    if (indexPath.row == 1) {
        [cell.rightTextField setKeyboardType:UIKeyboardTypeEmailAddress];
    }
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    ELCTextfieldCell *cell = (ELCTextfieldCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ELCTextfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}



#pragma mark ELCTextFieldCellDelegate Methods

-(void)textFieldDidReturnWithIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.row == [labels count] -1) {
        [[(ELCTextfieldCell*)[self.myTableView cellForRowAtIndexPath:indexPath] rightTextField] setReturnKeyType:UIReturnKeyGo];
    }
    if(indexPath.row < [labels count]-1) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:indexPath.section];
        [[(ELCTextfieldCell*)[self.myTableView cellForRowAtIndexPath:path] rightTextField] becomeFirstResponder];
        [self.myTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    else {
        
        [[(ELCTextfieldCell*)[self.myTableView cellForRowAtIndexPath:indexPath] rightTextField] resignFirstResponder];
        [self saveButtonPressed:nil];
    }
}

- (void)updateTextLabelAtIndexPath:(NSIndexPath*)indexPath string:(NSString*)string {
    switch (indexPath.row) {
        case 0:
        {
            self.user.name = string;
        }
            break;
        case 1:
        {
            self.user.email = string;
        }
            break;
        case 2:
        {
            self.user.password = string;
        }
            break;
        case 3:
        {
            self.user.password_confirmation = string;
        }
            break;
                  
    }
    
}

#pragma mark -
#pragma Event Handling

-(void) didLogin {
    self.loggedIn = YES;
    SetGlobalUser(self.user);
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setLoggedIn:YES];
}

-(IBAction)saveButtonPressed:(id)sender {
    // validate, then send to server
    
    if([self doValidation]) {
        [self.view endEditing:TRUE];

        [self.HUD showWhileExecuting:@selector(doRegister) onTarget:self withObject:nil animated:YES];
    } 
}

-(IBAction)loginButtonPressed:(id)sender {
    // flip to the login form
    LoginViewController *controller = [[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil] autorelease];
    controller.delegate = self.delegate;
    [[NSManagedObjectContext defaultManagedObjectContext] deleteObject:self.user];
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

-(void) doRegister {
    [self.user registerUserWithDelegate:self finishSelector:@selector(registerUserDidSucceed:) failureSelector:@selector(registerUserDidFail:)];    
}

-(void) registerUserDidSucceed:(SSASIRequest *) theRequest {
    DLog(@"register succeeded: %@", theRequest);
    if ([theRequest responseStatusCode] != 200) {
        [self registerUserDidFail:theRequest];
        return;
    }
    //remove password before saving user
    self.user.password = nil;
    self.user.password_confirmation = nil;
    SetGlobalUser(self.user);
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] setLoggedIn:YES];
    NSString *response = [theRequest responseString];
    self.HUD.labelText = NSLocalizedString(@"Merging Data", nil);
    [self.HUD showWhileExecuting:@selector(doPopulateWithResponse:) onTarget:self withObject:response animated:YES];
    
    [self dismissModalViewControllerAnimated:YES];
}



-(void) registerUserDidFail:(SSASIRequest *) theRequest {
    DLog(@"register failed: %@", theRequest);
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Registration Failed", nil) 
                                                     message:[theRequest responseString]
                                                    delegate:nil 
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil] autorelease];
    [alert show];
   
    
}

-(BOOL) doValidation {
    // start with simple tests for existence of email, likeness of password and confirmation
    NSString *errorString = @"";
    if (self.user.email.length < 4) {
        errorString = [errorString stringByAppendingString:NSLocalizedString(@"Please provide an email address", nil)];
    }
    if (self.user.password.length < 6) {
        errorString = [errorString stringByAppendingString:NSLocalizedString(@"Please enter a password of at least 6 characters", nil)];
    }
    if (![self.user.password isEqualToString:self.user.password_confirmation]) {
        errorString = [errorString stringByAppendingString:NSLocalizedString(@"Password and confirmation do not match", nil)];
    }
    if (![errorString isEqualToString:@""]) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Validation Errors", nil) 
                                                         message:errorString
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil] autorelease];
        [alert show];
        return NO;
    } else {
        return YES;
    }
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    labels = nil;
    placeholders = nil;
    //if (!self.loggedIn) {
    //    [[NSManagedObjectContext defaultManagedObjectContext] deleteObject:self.user];
   // }
}




@end
