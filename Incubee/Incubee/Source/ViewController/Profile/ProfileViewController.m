//
//  ProfileViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 19/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController (Private)

-(void)showLoginScreen;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *appVersion =[NSString stringWithFormat:@"v%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]] ;
    
    _versionLable.text = appVersion;

    
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

@end
