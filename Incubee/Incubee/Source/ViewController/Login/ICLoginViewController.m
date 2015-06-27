//
//  ICLoginViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 17/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICLoginViewController.h"
#import "ICDataManager.h"

@interface ICLoginViewController ()

@end

@implementation ICLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _googleSignInButton.style = kGIDSignInButtonStyleWide;
        
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [GIDSignIn sharedInstance].delegate = self;
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;

    
}

// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
    
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error{

    if(error==nil)
    {
        NSLog(@"%@",NSStringFromSelector(_cmd));

        [self signInSuccesfull];
    }
    else
    {
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Google" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }
    
}


- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)signInSuccesfull{

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
    
    UIViewController *controller = [sb instantiateViewControllerWithIdentifier:@"IncubeeLoginStoryBoard"];
    
    controller.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController pushViewController:controller animated:YES];

    
}

- (IBAction)noThanksTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
