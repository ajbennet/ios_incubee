//
//  ICAppContainerViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 12/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import "ICAppContainerViewController.h"

@interface ICAppContainerViewController ()

@property(nonatomic,strong)UITabBarController *tabController;

@end

@implementation ICAppContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(investorLoggedIn) name:USER_AS_FOUNDER_NOTIFICATION object:nil];
    
    [self setupUIAsGuest];
    
    [self checkForUserLogin];
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


-(void)setupUIAsGuest{

    UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
     _tabController = [st instantiateViewControllerWithIdentifier:@"TabbarControllerStoryboard"];
    
    [self addChildViewController:_tabController];
    
    _tabController.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:_tabController.view];
    
    [_tabController didMoveToParentViewController:self];

}

-(void)investorLoggedIn{

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [_tabController removeFromParentViewController];
    
    [_tabController.view removeFromSuperview];
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"ICInvestorStoryboard" bundle:nil];
    
    UINavigationController* nav = [st instantiateViewControllerWithIdentifier:@"InvestorStoryBoard"];

    [self addChildViewController:nav];
    
    nav.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:nav.view];
    
    [nav didMoveToParentViewController:self];

    
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
