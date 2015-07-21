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

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [GIDSignIn sharedInstance].delegate = [ICUserAccountManager sharedInstance];
    
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"No Thanks"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    _noThanksButton.titleLabel.attributedText = [attributeString copy];
    
    
    _googleSignInButton.style = kGIDSignInButtonStyleWide;
    
    _googleSignInButton.colorScheme = kGIDSignInButtonColorSchemeLight;
    
    [self.view setNeedsLayout];
    
    [self.view layoutIfNeeded];


    
    
//    
//    GIDSignInButton *signInButton = [[GIDSignInButton alloc] init];
//    [signInButton setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [signInButton setStyle:kGIDSignInButtonStyleStandard];
//    [signInButton setColorScheme:kGIDSignInButtonColorSchemeLight];
//    NSLayoutConstraint *vConstraint = [NSLayoutConstraint constraintWithItem:signInButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
//    NSLayoutConstraint *hConstraint = [NSLayoutConstraint constraintWithItem:signInButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    [self.view addConstraint:vConstraint];
//    [self.view addConstraint:hConstraint];
//    
//    [self.view addSubview:signInButton];

    
    
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
    
    
}

- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController{

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self presentViewController:viewController animated:YES completion:nil];

}

- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController{

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [viewController dismissViewControllerAnimated:YES completion:nil];

    
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
    
    UIViewController *controller = [sb instantiateViewControllerWithIdentifier:@"IncubeeLoginStoryBoard"];
    
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController pushViewController:controller animated:YES];

    
}

- (IBAction)noThanksTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
