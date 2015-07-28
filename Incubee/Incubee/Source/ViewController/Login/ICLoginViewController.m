//
//  ICLoginViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 17/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICLoginViewController.h"
#import "ICDataManager.h"
#import "ICUserAccountManager.h"

@interface ICLoginViewController ()

@end

@implementation ICLoginViewController

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [self configureGoogleButton];
    
    _googleSignInButton.hidden = NO;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [GIDSignIn sharedInstance].delegate = [ICUserAccountManager sharedInstance];
    
    [GIDSignIn sharedInstance].shouldFetchBasicProfile = YES;
    
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"No Thanks"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    _noThanksButton.titleLabel.attributedText = [attributeString copy];
    
    _googleSignInButton.style = kGIDSignInButtonStyleWide;
    
    _googleSignInButton.colorScheme = kGIDSignInButtonColorSchemeLight;
    
    NSLog(@"_googleConstrients.constant %f",_googleConstrients.constant);
    
    _googleSignInButton.hidden = YES;
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - GIDSigninUIDelegate -
// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    if(error==nil && signIn.currentUser!=nil)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController{

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self presentViewController:viewController animated:YES completion:nil];

}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController{

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [viewController dismissViewControllerAnimated:YES completion:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginButtonTapped:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ICLoginViewController" bundle:nil];
    
    _loginViewController = [sb instantiateViewControllerWithIdentifier:@"IncubeeLoginStoryBoard"];
    
    _loginViewController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController pushViewController:_loginViewController animated:YES];
    
}

- (IBAction)noThanksTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)configureGoogleButton{
    
    float containerHeight = _googleButtonContainerView.frame.size.height;
    
    float containerWidth = _googleButtonContainerView.frame.size.width;
    
    
    float buttonHeight = _googleSignInButton.frame.size.height;
    
    float buttonWidth = _googleSignInButton.frame.size.width;
    
    
    float buttonOriginX = (containerWidth - buttonWidth)/2.0f;
    
    float buttonOriginY = (containerHeight - buttonHeight)/2.0f;
    
    _googleSignInButton.frame = CGRectMake(buttonOriginX, buttonOriginY, buttonWidth, buttonHeight);

}

@end
