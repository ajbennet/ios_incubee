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
    
    
//    @"Login if you already uploaded your work at incub.ee"
    
    
    
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    UIFont *font1 = [UIFont fontWithName:@"Lato-Light" size:23.0f];
    
    UIFont *font2 = [UIFont fontWithName:@"Lato-Light"  size:23.0f];
    
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle),
                            NSFontAttributeName:font1,
                            NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor colorWithRed:0.904 green:0.507 blue:0.518 alpha:1.000]}; // Added line
    NSDictionary *dict2 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font2,
                            NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor whiteColor]}; // Added line
    NSDictionary *dict3 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font2,
                            NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor colorWithRed:0.076 green:0.517 blue:0.403 alpha:1.000]}; // Added line
    
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Login"    attributes:dict2]]; //dict1
    
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@" if you already uploaded\n your work at"    attributes:dict2]];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@" www.incub.ee"      attributes:dict3]];
    [_loginButton setAttributedTitle:attString forState:UIControlStateNormal];
    [[_loginButton titleLabel] setNumberOfLines:0];
    [[_loginButton titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];

    
    
    
    
    
    
    
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
    
    [viewController dismissViewControllerAnimated:YES completion:^{
      
        [self dismissViewControllerAnimated:YES completion:nil];

    }];

    
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
    
    NSURL *url = [NSURL URLWithString:@"http://www.incub.ee"];
    
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ICLoginViewController" bundle:nil];
//    
//    _loginViewController = [sb instantiateViewControllerWithIdentifier:@"IncubeeLoginStoryBoard"];
//    
//    _loginViewController.modalPresentationStyle = UIModalPresentationCustom;
//    
//    [self.navigationController pushViewController:_loginViewController animated:YES];
    
}

- (IBAction)noThanksTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:USER_AS_FOUNDER_NOTIFICATION object:nil];
        
        
    }];
    
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
