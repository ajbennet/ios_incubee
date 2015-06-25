//
//  ICLoginViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 17/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICLoginViewController.h"

@interface ICLoginViewController ()

@end

@implementation ICLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = YES;
    
    _googleSignInButton.style = kGIDSignInButtonStyleWide;
        
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [self.view setNeedsLayout];
    
    [self.view layoutIfNeeded];
    
    [_googleSignInButton setNeedsLayout];
    
    [_googleSignInButton layoutIfNeeded];

    
//    if(_googleSignInButton.currentUser){
//    
//        [self signINSuccesfull];
//        
//    }
}

// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
//    [myActivityIndicator stopAnimating];
    
    if(signIn.currentUser){
    
        [self signINSuccesfull];
        
    }
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn
presentViewController:(UIViewController *)viewController {

        NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self presentViewController:viewController animated:YES completion:nil];
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn
dismissViewController:(UIViewController *)viewController {
    
        NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if(signIn.currentUser)
        {
                [self signINSuccesfull];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)signINSuccesfull{

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITabBarController *controller = [sb instantiateViewControllerWithIdentifier:@"TabbarControllerStoryboard"];
    
    [self.navigationController pushViewController:controller animated:NO];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
