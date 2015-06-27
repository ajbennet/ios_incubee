//
//  FirstViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 17/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "HomeViewController.h"
#import "ICCardViewController.h"
#import "ICAppManager.h"
#import "ICAppManager+Networking.h"
#import "ICLoginViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[ICAppManager sharedInstance] getAllProject:nil notifyTo:self forSelector:@"projectDataRefreshed"];
    
    self.navigationController.navigationBarHidden = YES;
    
    _projectList = [[ICDataManager sharedInstance] getAllProjects];

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CardViewStoryboard" bundle:nil];
    
    _firstViewC = (ICCardViewController*)[sb instantiateViewControllerWithIdentifier:@"ICCardVCSB"];
    
    _firstViewC.delegate = self;
    
    int r = arc4random()%_projectList.count;
    
    _firstCard = [_projectList objectAtIndex:r];
    
    [_firstViewC setProject:_firstCard];
    
    [_firstViewC willMoveToParentViewController:self];

    [self addChildViewController:_firstViewC];
    
    [self.view addSubview:_firstViewC.view];

    [_firstViewC didMoveToParentViewController:self];
    
    // Second View
    
    _secondViewC = (ICCardViewController*)[sb instantiateViewControllerWithIdentifier:@"ICCardVCSB"];
    
    _secondViewC.delegate = self;
    
    r = arc4random()%_projectList.count;
    
    _secondCard = [_projectList objectAtIndex:r];

    [_secondViewC setProject:_secondCard];

    [_secondViewC willMoveToParentViewController:self];
    
    [self addChildViewController:_secondViewC];
    
    [self.view addSubview:_secondViewC.view];
    
    [_secondViewC didMoveToParentViewController:self];
    
    _currentlyShowingVC = _secondViewC;
    
    [_currentlyShowingVC.view layoutSubviews];
    
    [_secondViewC showProject];
    
    [self showLoginScreen];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ICCardViewDelegate - 

-(void)gotChanged{
    NSLog(@"%@",NSStringFromSelector(_cmd));

}

-(void)followProject{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self goNextProject:nil];
}

-(void)dontFollowProject{

    NSLog(@"%@",NSStringFromSelector(_cmd));

}

- (IBAction)goNextProject:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [_currentlyShowingVC stopShowingProj];
    
    
    int r = arc4random()%_projectList.count;
    
    Project *randProj = [_projectList objectAtIndex:r];

    if(_currentlyShowingVC == _secondViewC)
    {
        [self.view bringSubviewToFront:_firstViewC.view];
        
        [_currentlyShowingVC setProject:randProj];
        
        _currentlyShowingVC = _firstViewC;
    
    }
    else if(_currentlyShowingVC == _firstViewC)
    {
        [self.view bringSubviewToFront:_secondViewC.view];
        
        [_currentlyShowingVC setProject:randProj];
        
        _currentlyShowingVC = _secondViewC;
    }
    
    [_currentlyShowingVC showProject];
    
    [self.view bringSubviewToFront:_v];

}

- (IBAction)addToCustomer:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [[ICAppManager sharedInstance] getAllProject:nil notifyTo:self forSelector:@"projectDataRefreshed"];


}
- (IBAction)saveProjTapped:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self goNextProject:nil];

}
- (IBAction)dislikeProjTapped:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self goNextProject:nil];
}

-(void)projectDataRefreshed:(ICRequest*)inRequest{

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    _projectList = [[ICDataManager sharedInstance] getAllProjects];
    
    [self goNextProject:nil];
    
}

-(void)showLoginScreen{

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ICLoginViewController" bundle:nil];
    
    UINavigationController *loginNavigationController = [sb instantiateViewControllerWithIdentifier:@"LoginNavigationStoryBoard"];
    
    loginNavigationController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:loginNavigationController animated:YES completion:nil];
        
}

@end
