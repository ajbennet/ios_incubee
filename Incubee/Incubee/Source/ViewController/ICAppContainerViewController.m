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
    
    [self initUserLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - User -
-(void)initUserLogin{

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
        
    UITabBar *tabBar = _tabController.tabBar;
    UITabBarItem *tabBarItem1
    = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];


    tabBarItem1.selectedImage = [[UIImage imageNamed:@"HomeTabIconSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem1.image = [[UIImage imageNamed:@"HomeTabIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    tabBarItem1.title = @"";

    tabBarItem2.selectedImage = [[UIImage imageNamed:@"SearchTabIconSelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.image = [[UIImage imageNamed:@"SearchTabIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem2.title = @"";

    tabBarItem3.selectedImage = [[UIImage imageNamed:@"MsgTabIconSelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.image = [[UIImage imageNamed:@"MsgTabIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem3.title = @"";

    tabBarItem4.selectedImage = [[UIImage imageNamed:@"ProfileTabIconSelected"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem4.image = [[UIImage imageNamed:@"ProfileTabIcon"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabBarItem4.title = @"";
    tabBarItem1.imageInsets = tabBarItem2.imageInsets = tabBarItem3.imageInsets = tabBarItem4.imageInsets = UIEdgeInsetsMake(12, 0, -12, 0);;



}

-(void)investorLoggedIn{

    NSLog(@"%@",NSStringFromSelector(_cmd));

    // Clearing the current view controller.
    [_tabController willMoveToParentViewController:nil];
    [_tabController.view removeFromSuperview];
    [_tabController removeFromParentViewController];
    _tabController = nil;
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"ICInvestorStoryboard" bundle:nil];
    
    UINavigationController* nav = [st instantiateViewControllerWithIdentifier:@"InvestorStoryBoard"];

    [self addChildViewController:nav];
    
    nav.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
                           forView:self.view
                             cache:YES];
    
    [self.view addSubview:nav.view];
    [UIView commitAnimations];

    
    
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
