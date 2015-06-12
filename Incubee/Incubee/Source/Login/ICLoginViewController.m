//
//  ICLoginViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 12/06/15.
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

- (IBAction)loginComplete:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"TabBarController"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}
@end
