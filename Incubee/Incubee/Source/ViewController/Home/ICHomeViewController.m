//
//  FirstViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 17/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICHomeViewController.h"
#import "ICCardViewController.h"
#import "ICAppManager.h"
#import "ICAppManager+Networking.h"
#import "ICLoginViewController.h"


@interface ICHomeViewController ()

@end

@implementation ICHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.navigationController.navigationBarHidden = YES;
    
    _projectList = [[ICDataManager sharedInstance] getAllProjects];
    
    [self setupCards];
    
//    [self showLoginScreen];
    
    if(_projectList.count!=0)
    {
        _firstCard = [_projectList objectAtIndex:0];
        
        _secondCard = [_projectList objectAtIndex:1];
        
        [_secondViewC setProject:_secondCard];

        [_firstViewC setProject:_firstCard];        

        _currentlyShowingVC = _secondViewC;
        
        [_currentlyShowingVC showProject];
        
        _currentlyShowingIndexoffset = 1;
    }
    else
    {
        isFirstTimeLoading = YES;
    }
    
    [self showActivity:YES withMsg:@"Fetching all projects"];
    
    [[ICAppManager sharedInstance] getAllProject:nil notifyTo:self forSelector:@"projectDataRefreshed:"];
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
    
    //Setting Current Showing Project

    _currentlyShowingVC = _secondViewC;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ICCardViewDelegate - 

-(void)updateCurrentProjDescLable{

    _projDescLable.text = _currentlyShowingVC.project.companyDescription;

}

-(void)followCurrentProject{
    

}

-(void)dontFollowCurrentProject{


}

- (IBAction)goNextProject:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [_currentlyShowingVC dismissShowing];
    
    Project *randProj = [_projectList objectAtIndex:0];

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
    
    [self.view bringSubviewToFront:_optionView];

}

- (IBAction)addToCustomer:(id)sender {
    

}
- (IBAction)likeProjectTapped:(id)sender {
    
    [_currentlyShowingVC dismissShowing];
    
    if(_currentlyShowingVC == _secondViewC)
    {
//        [UIView
//         animateKeyframesWithDuration:3
//         delay:0
//         options:UIViewKeyframeAnimationOptionCalculationModeLinear
//         animations:^{
//             
//         } completion:^(BOOL finished) {
        
        [self.view bringSubviewToFront:_firstViewC.view];
        
        _currentlyShowingVC = _firstViewC;
        
        
        // now configre SecondView.
        
        _currentlyShowingIndexoffset++;
        
        _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
        
        _secondCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
        
        [_secondViewC setProject:_secondCard];
             


//         }];

        
    }
    else if(_currentlyShowingVC == _firstViewC)
    {
        [self.view bringSubviewToFront:_secondViewC.view];
        
        _currentlyShowingVC = _secondViewC;
        
        
        // now configre FirstView.
        
        _currentlyShowingIndexoffset++;
        
        _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
        
        _firstCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
        
        [_firstViewC setProject:_firstCard];
                
    }
    
    [_currentlyShowingVC showProject];

    [self.view bringSubviewToFront:_optionView];

}

- (IBAction)dislikeProjTapped:(id)sender {
    
    {
        
        [_currentlyShowingVC dismissShowing];
        
        if(_currentlyShowingVC == _secondViewC)
        {
            [self.view bringSubviewToFront:_firstViewC.view];
            
            _currentlyShowingVC = _firstViewC;
            
            
            // now configre SecondView.
            
            _currentlyShowingIndexoffset++;
            
            _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
            
            _secondCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
            
            [_secondViewC setProject:_secondCard];
            
        }
        else if(_currentlyShowingVC == _firstViewC)
        {
            [self.view bringSubviewToFront:_secondViewC.view];
            
            _currentlyShowingVC = _secondViewC;
            
            
            // now configre FirstView.
            
            _currentlyShowingIndexoffset++;
            
            _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
            
            _firstCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
            
            [_firstViewC setProject:_firstCard];
            
        }
        
        [_currentlyShowingVC showProject];
        
        [self.view bringSubviewToFront:_optionView];
        
    }

    

}

- (IBAction)refreshView:(id)sender {
    
    [self showActivity:YES withMsg:@"Fetching new projects"];
    
    [[ICAppManager sharedInstance] getAllProject:nil notifyTo:self forSelector:@"projectDataRefreshed:"];

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
    
    if(inRequest.error == nil)
    {
        _projectList = [[ICDataManager sharedInstance] getAllProjects];

        if(isFirstTimeLoading)
        {            
            _firstCard = [_projectList objectAtIndex:0];
            
            _secondCard = [_projectList objectAtIndex:1];
            
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
