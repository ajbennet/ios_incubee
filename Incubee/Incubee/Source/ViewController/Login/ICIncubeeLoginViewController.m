//
//  ICIncubeeLoginViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICIncubeeLoginViewController.h"

#import "ICUserAccountManager.h"

@interface ICIncubeeLoginViewController ()

@end

@implementation ICIncubeeLoginViewController


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [self configureGoogleButton];
    
    _googleSignInButton.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    
    self.title = @"Login";
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Cross"] style:UIBarButtonItemStyleDone target:self action:@selector(closeTaped)];
    
    self.navigationItem.leftBarButtonItem = backButton;
    
    _googleSignInButton.hidden = YES;
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [GIDSignIn sharedInstance].delegate = [ICUserAccountManager sharedInstance];
    
    [GIDSignIn sharedInstance].shouldFetchBasicProfile = YES;
    
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

-(void)closeTaped{

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}


-(void)configureGoogleButton{
    
    float containerHeight = _googleLoginContainer.frame.size.height;
    
    float containerWidth = _googleLoginContainer.frame.size.width;
    
    
    float buttonHeight = _googleSignInButton.frame.size.height;
    
    float buttonWidth = _googleSignInButton.frame.size.width;
    
    
    float buttonOriginX = (containerWidth - buttonWidth)/2.0f;
    
    float buttonOriginY = (containerHeight - buttonHeight)/2.0f;
    
    _googleSignInButton.frame = CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight);
    
}

#pragma mark - GIDSigninUIDelegate -
// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
    
}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
    
    
}
@end
