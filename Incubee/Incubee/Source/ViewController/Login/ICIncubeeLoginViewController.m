//
//  ICIncubeeLoginViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICIncubeeLoginViewController.h"

@interface ICIncubeeLoginViewController ()

@end

@implementation ICIncubeeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    
    self.title = @"Login";
    
    _googleButton.layer.cornerRadius = _twitterButton.layer.cornerRadius = _loginButton.layer.cornerRadius = 5.0f;
    
    _googleButton.layer.borderColor = _twitterButton.layer.borderColor = _loginButton.layer.borderColor = [UIColor grayColor].CGColor;

        _googleButton.layer.borderWidth = _twitterButton.layer.borderWidth = _loginButton.layer.borderWidth = 1.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)googleLoginTapped:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)twitterLoginTapped:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)loginTapped:(id)sender {
    
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
