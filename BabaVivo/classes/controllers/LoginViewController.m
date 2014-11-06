//
//  LoginViewController.m
//  IOS-App
//
//  Created by Vinicius Oliveira on 10/7/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import "LoginViewController.h"
#import "FFVSessionControl.h"
#import "MainTableViewController.h"
#import <FacebookSDK/Facebook.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property BOOL isFirstLoginDone;
@end

@implementation LoginViewController

#pragma ViewController Delegate

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self layout];
    [self facebookConfigurations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma Style Configuration

-(void) layout
{
    self.navigationController.navigationBarHidden = YES;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)resizeLoginView:(FBLoginView*)loginview
{
    for(UIView * view in loginview.subviews)
    {
        if([view isKindOfClass:[UILabel class]])
        {
            view.frame = CGRectMake( view.frame.origin.x-23, view.frame.origin.y, view.frame.size.width/2, view.frame.size.height /2);
        }
        else
        {
            view.frame = CGRectMake( view.frame.origin.x, view.frame.origin.y, view.frame.size.width/2, view.frame.size.height /2);
        }
    }
    for(UILabel * label in loginview.subviews)
    {
        label.font = [UIFont systemFontOfSize:12];
    }
}

#pragma Configurations

-(void) facebookConfigurations
{
    self.loginView.delegate = self;
    self.loginView.readPermissions = @[@"public_profile", @"email"];
//    [self resizeLoginView:self.loginView];
}

#pragma Facebook Delegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    // Set flag
    self.isFirstLoginDone = YES;
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    if(self.isFirstLoginDone) {
        [FFVSessionControl authenticateUser:^(User* user){
            
            
            MainTableViewController *main = [[MainTableViewController alloc] initWithNibName:@"MainTableViewController" bundle:nil];
            
            [self.navigationController pushViewController:main animated:YES];
            
        } failure:^(NSError* error){
            NSLog(@"Error: %@", error);
        }];
    }
    
    self.isFirstLoginDone = NO;
    
}


- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
