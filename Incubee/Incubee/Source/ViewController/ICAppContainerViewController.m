//
//  ICAppContainerViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 12/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import "ICAppContainerViewController.h"

@interface ICAppContainerViewController ()

@end

@implementation ICAppContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self checkForUserLogin];
    
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UITabBarController *controller = [st instantiateViewControllerWithIdentifier:@"TabbarControllerStoryboard"];
    [self addChildViewController:controller];
    controller.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - User -
-(void)checkForUserLogin{

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ICLoginViewController" bundle:nil];
    
    UINavigationController *loginNavigationController = [sb instantiateViewControllerWithIdentifier:@"LoginNavigationStoryBoard"];
    
    loginNavigationController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self.navigationController presentViewController:loginNavigationController animated:YES completion:nil];
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
