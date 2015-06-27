//
//  ICIncubeeLoginViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICIncubeeLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *googleButton;

@property (weak, nonatomic) IBOutlet UIButton *twitterButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)googleLoginTapped:(id)sender;
- (IBAction)twitterLoginTapped:(id)sender;

- (IBAction)loginTapped:(id)sender;
@end
