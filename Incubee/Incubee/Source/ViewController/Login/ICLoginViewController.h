//
//  ICLoginViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 17/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface ICLoginViewController : UIViewController <GIDSignInUIDelegate>

@property (weak, nonatomic)IBOutlet GIDSignInButton *googleSignInButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UIButton *noThanksButton;

- (IBAction)loginButtonTapped:(id)sender;

- (IBAction)noThanksTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *googleButtonContainerView;

@end
