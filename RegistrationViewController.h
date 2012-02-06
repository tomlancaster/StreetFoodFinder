//
//  RegistrationViewController.h
//  MuaTheCao
//
//  Created by Tom Lancaster on 1/6/12.
//  Copyright (c) 2012 Sunshine Open Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCTextfieldCell.h"
#import "MBProgressHUD.h"
#import "User.h"
#import "PhoneNumber.h"
#import "AppDelegate.h"
#import "SSViewController.h"
@class SSASIRequest;

@interface RegistrationViewController : SSViewController <ELCTextFieldDelegate> {

    NSArray *labels;
    NSArray *placeholders;
    IBOutlet UINavigationBar *myNavBar;
    IBOutlet UIBarButtonItem *saveButton;
    IBOutlet UIBarButtonItem *loginButton;
     IBOutlet UINavigationItem *myNavItem;
    User *user;
    PhoneNumber *phonenumber;
    BOOL loggedIn;
    IBOutlet UILabel *registerLabel;
    id delegate;
    IBOutlet UIView *headerView;
}


-(IBAction)saveButtonPressed:(id)sender;
-(IBAction)loginButtonPressed:(id)sender;
-(BOOL) doValidation;
-(void) doRegister;

-(void) registerUserDidSucceed:(SSASIRequest *) theRequest;
-(void) registerUserDidFail:(SSASIRequest *) theRequest;

-(void) didLogin;
-(void) doDataMergeWithResponse:(NSString *) response;


@property (nonatomic, retain) UILabel *registerLabel;
@property (assign) BOOL loggedIn;
@property (assign) id delegate;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSArray *labels;
@property (nonatomic, retain) NSArray *placeholders;
@property (nonatomic, retain) UINavigationBar *myNavBar;
@property (nonatomic, retain) UIBarButtonItem *saveButton;
@property (nonatomic, retain) UIBarButtonItem *loginButton;




@end
