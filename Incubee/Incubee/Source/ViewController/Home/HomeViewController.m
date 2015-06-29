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

    [self showActivity:YES withMsg:@"Fetching all projects"];

    isFirstTimeLoading = YES;
    
    [[ICAppManager sharedInstance] getAllProject:nil notifyTo:self forSelector:@"projectDataRefreshed:"];
    
    self.navigationController.navigationBarHidden = YES;
    
    _projectList = [[ICDataManager sharedInstance] getAllProjects];
    
    [self setupCards];
    
//    [self showLoginScreen];
    
    if(_projectList.count!=0)
    {
        int r1 = arc4random_uniform((int)_projectList.count);
        
        int r2 = arc4random_uniform((int)_projectList.count);
    
        _firstCard = [_projectList objectAtIndex:r1];
        
        _secondCard = [_projectList objectAtIndex:r2];
        
        [_firstViewC setProject:_firstCard];
        
        [_secondViewC setProject:_secondCard];
        
        [_currentlyShowingVC showProject];
        
    }
    
}

-(void)setupCards{

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CardViewStoryboard" bundle:nil];
    
    
    // First Card
    _firstViewC = (ICCardViewController*)[sb instantiateViewControllerWithIdentifier:@"ICCardVCSB"];
    
    _firstViewC.delegate = self;
    
    [_firstViewC willMoveToParentViewController:self];
    
    [self addChildViewController:_firstViewC];
    
    [self.view addSubview:_firstViewC.view];
    
    [_firstViewC didMoveToParentViewController:self];
    
    // Second Card
    
    _secondViewC = (ICCardViewController*)[sb instantiateViewControllerWithIdentifier:@"ICCardVCSB"];
    
    _secondViewC.delegate = self;
    
    [_secondViewC willMoveToParentViewController:self];
    
    [self addChildViewController:_secondViewC];
    
    [self.view addSubview:_secondViewC.view];
    
    [_secondViewC didMoveToParentViewController:self];

    _currentlyShowingVC = _secondViewC;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ICCardViewDelegate - 

-(void)updateDescLable{

    _projDescLable.text = _currentlyShowingVC.project.companyDescription;

}

-(void)followProject{
    
    [self goNextProject:nil];
}

-(void)dontFollowProject{


}

- (IBAction)goNextProject:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [_currentlyShowingVC dismissShowing];
    
    
    int r = arc4random_uniform((int)_projectList.count);
    
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
    
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [[ICAppManager sharedInstance] getAllProject:nil notifyTo:self forSelector:@"projectDataRefreshed:"];


}
- (IBAction)saveProjTapped:(id)sender {
    
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self goNextProject:nil];

}
- (IBAction)dislikeProjTapped:(id)sender {
    
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self goNextProject:nil];
}

-(void)showLoginScreen{

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ICLoginViewController" bundle:nil];
    
    UINavigationController *loginNavigationController = [sb instantiateViewControllerWithIdentifier:@"LoginNavigationStoryBoard"];
    
    loginNavigationController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:loginNavigationController animated:YES completion:nil];
        
}

-(void)showActivity:(BOOL)inShowActivity withMsg:(NSString*)inMsg{

    if(inShowActivity)
    {
        _activityLable.text = inMsg;
        
        [_activityIndicator startAnimating];
        
        _activityView.hidden = NO;
        
        [self.view bringSubviewToFront:_activityView];
    }
    else
    {
        _activityView.hidden = YES;

        [self.view sendSubviewToBack:_activityView];

        [_activityIndicator stopAnimating];
    
        _activityLable.text  = nil;
    }
    
}

#pragma mark - Network Notifications -
-(void)projectDataRefreshed:(ICRequest*)inRequest{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));

    [self showActivity:NO withMsg:nil];
    
    if(inRequest.error.localizedDescription == nil)
    {
        _projectList = [[ICDataManager sharedInstance] getAllProjects];

        if(isFirstTimeLoading)
        {
            int r1 = arc4random_uniform((int)_projectList.count);
            
            int r2 = arc4random_uniform((int)_projectList.count);
            
            _firstCard = [_projectList objectAtIndex:r1];
            
            _secondCard = [_projectList objectAtIndex:r2];
            
            [_firstViewC setProject:_firstCard];
            
            [_secondViewC setProject:_secondCard];

            [_currentlyShowingVC showProject];
            
            isFirstTimeLoading = NO;
        }

    }
    else
    {
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
        
    }
    
    
    
    
}
@end
