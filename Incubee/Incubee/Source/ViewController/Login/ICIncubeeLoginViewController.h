//
//  ICIncubeeLoginViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface ICIncubeeLoginViewController : UIViewController<GIDSignInUIDelegate>



@property (strong, nonatomic) IBOutlet UIView *googleLoginContainer;

@property (strong, nonatomic) IBOutlet GIDSignInButton *googleSignInButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)googleLoginTapped:(id)sender;
- (IBAction)twitterLoginTapped:(id)sender;

- (IBAction)loginTapped:(id)sender;
@end
