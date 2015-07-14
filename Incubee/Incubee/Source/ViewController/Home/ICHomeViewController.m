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
#import "ICUtilityManager.h"


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

        _currentlyShowingVC = _firstViewC;
        
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
    
    // Second Card
    
    _secondViewC = (ICCardViewController*)[sb instantiateViewControllerWithIdentifier:@"ICCardVCSB"];
    
    _secondViewC.delegate = self;
    
    [_secondViewC willMoveToParentViewController:self];
    
    [self addChildViewController:_secondViewC];
    
    [self.view addSubview:_secondViewC.view];
    
    [_secondViewC didMoveToParentViewController:self];
    
    
    // First Card
    _firstViewC = (ICCardViewController*)[sb instantiateViewControllerWithIdentifier:@"ICCardVCSB"];
    
    _firstViewC.delegate = self;
    
    [_firstViewC willMoveToParentViewController:self];
    
    [self addChildViewController:_firstViewC];
    
    [self.view addSubview:_firstViewC.view];
    
    [_firstViewC didMoveToParentViewController:self];
    
    
    //Setting Current Showing Project

    _currentlyShowingVC = _firstViewC;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ICCardViewDelegate - 

-(void)followCurrentProject:(CGPoint)movedPoint{
    
    [_currentlyShowingVC dismissShowing];

    CGAffineTransform translate = CGAffineTransformTranslate(_currentlyShowingVC.cardView.transform, movedPoint.x+500.0f, movedPoint.y);
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    if(_currentlyShowingVC == _secondViewC)
    {
        _currentlyShowingVC.cardSelectStatusImage.image = [UIImage imageNamed:@"LikeButton"];
        
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             _secondViewC.cardView.transform = translate;
                             
                             _secondViewC.cardSelectStatusImage.alpha = 1.0f;
                             
                         } completion:^(BOOL finished) {
                             
                             [self.view bringSubviewToFront:_firstViewC.view];
                             
                             _currentlyShowingVC = _firstViewC;
                             
                             // now configre SecondView.
                             
                             _currentlyShowingIndexoffset++;
                             
                             _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
                             
                             _secondCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
                             
                             [_secondViewC setProject:_secondCard];
                             
                             [self.view bringSubviewToFront:_optionView];
                             
                             [_currentlyShowingVC showProject];
                             
                             _secondViewC.cardView.transform = CGAffineTransformIdentity;
                             
                             _secondViewC.cardSelectStatusImage.alpha = 0.0f;
                             
                             _secondViewC.cardView.layer.borderColor = [UIColor clearColor].CGColor;
                             
                             _secondViewC.cardView.layer.borderWidth = 0.0f;
                             
                         }];
    }
    else if(_currentlyShowingVC == _firstViewC)
    {
        _currentlyShowingVC.cardSelectStatusImage.image = [UIImage imageNamed:@"LikeButton"];
        
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             _firstViewC.cardView.transform = translate;
                             
                             _firstViewC.cardSelectStatusImage.alpha = 1.0f;
                             
                             
                             
                         } completion:^(BOOL finished) {
                             {
                                 
                                 [self.view bringSubviewToFront:_secondViewC.view];
                                 
                                 _currentlyShowingVC = _secondViewC;
                                 
                                 // now configre FirstView.
                                 
                                 _currentlyShowingIndexoffset++;
                                 
                                 _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
                                 
                                 _firstCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
                                 
                                 [_firstViewC setProject:_firstCard];
                                 
                                 [self.view bringSubviewToFront:_optionView];
                                 
                                 [_currentlyShowingVC showProject];
                                 
                                 _firstViewC.cardView.transform = CGAffineTransformIdentity;
                                 
                                 _firstViewC.cardSelectStatusImage.alpha = 0.0f;
                                 
                                 _firstViewC.cardView.layer.borderColor = [UIColor clearColor].CGColor;
                                 
                                 _firstViewC.cardView.layer.borderWidth = 0.0f;

                                 
                                 
                             }
                         }];
    }
    
    
}

-(void)dontFollowCurrentProject:(CGPoint)movedPoint{

    [_currentlyShowingVC dismissShowing];

    CGAffineTransform translate;
    
    translate = CGAffineTransformTranslate(_currentlyShowingVC.cardView.transform, movedPoint.x-500.0f, movedPoint.y);
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    if(_currentlyShowingVC == _secondViewC)
    {
        _currentlyShowingVC.cardSelectStatusImage.image = [UIImage imageNamed:@"LikeButton"];
        
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             _secondViewC.cardView.transform = translate;
                             
                             _secondViewC.cardSelectStatusImage.alpha = 1.0f;
                             
                         } completion:^(BOOL finished) {
                             
                             [self.view bringSubviewToFront:_firstViewC.view];
                             
                             _currentlyShowingVC = _firstViewC;
                             
                             // now configre SecondView.
                             
                             _currentlyShowingIndexoffset++;
                             
                             _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
                             
                             _secondCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
                             
                             [_secondViewC setProject:_secondCard];
                             
                             [self.view bringSubviewToFront:_optionView];
                             
                             [_currentlyShowingVC showProject];
                             
                             _secondViewC.cardView.transform = CGAffineTransformIdentity;
                             
                             _secondViewC.cardSelectStatusImage.alpha = 0.0f;
                             
                             _secondViewC.cardView.layer.borderColor = [UIColor clearColor].CGColor;
                             
                             _secondViewC.cardView.layer.borderWidth = 0.0f;

                             
                             
                         }];
    }
    else if(_currentlyShowingVC == _firstViewC)
    {
        _currentlyShowingVC.cardSelectStatusImage.image = [UIImage imageNamed:@"LikeButton"];
        
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.5f initialSpringVelocity:0.9f options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             _firstViewC.cardView.transform = translate;
                             
                             _firstViewC.cardSelectStatusImage.alpha = 1.0f;
                             
                             
                         } completion:^(BOOL finished) {
                             {
                                 
                                 [self.view bringSubviewToFront:_secondViewC.view];
                                 
                                 _currentlyShowingVC = _secondViewC;
                                 
                                 // now configre FirstView.
                                 
                                 _currentlyShowingIndexoffset++;
                                 
                                 _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
                                 
                                 _firstCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
                                 
                                 [_firstViewC setProject:_firstCard];
                                 
                                 [self.view bringSubviewToFront:_optionView];
                                 
                                 [_currentlyShowingVC showProject];
                                 
                                 _firstViewC.cardView.transform = CGAffineTransformIdentity;
                                 
                                 _firstViewC.cardSelectStatusImage.alpha = 0.0f;
                                 
                                 _firstViewC.cardView.layer.borderColor = [UIColor clearColor].CGColor;
                                 
                                 _firstViewC.cardView.layer.borderWidth = 0.0f;
                                 

                                 
                                 
                             }
                         }];
    }
    
    
}

-(void)updateCurrentProjDescLable{
    
    _projDescLable.text = _currentlyShowingVC.project.companyDescription;
    
}

-(void)draggingBeginForCurrentShowingController{

    if(_currentlyShowingVC == _firstViewC)
    {
        _secondViewC.cardView.transform = CGAffineTransformMakeTranslation(0, 20.0f);
    }
    else if(_currentlyShowingVC == _secondViewC)
    {
        _firstViewC.cardView.transform = CGAffineTransformMakeTranslation(0, 20.0f);
    }
}
-(void)dragedCurrentShowingController:(CGPoint)inMovedPoint{

    float xAxisMoved = (fabs(inMovedPoint.x))/5.0f;
    
    float f;
    
    if(xAxisMoved>=20.0f)
    {
        f=0;
    }
    else if(xAxisMoved<20.0f)
    {
        f= 20.0f- xAxisMoved;
    }
    
//    NSLog(@"xAxisMoved : %f f:%f",xAxisMoved,f);
    
    if(f>0)
    {
    if(_currentlyShowingVC == _firstViewC)
    {
        _secondViewC.cardView.transform = CGAffineTransformMakeTranslation(0,f);
    }
    else if(_currentlyShowingVC == _secondViewC)
    {
        _firstViewC.cardView.transform = CGAffineTransformMakeTranslation(0,f);
    }
    }

}


-(void)draggingEndsForCurrentShowingController{
    
    if(_currentlyShowingVC == _firstViewC)
    {
        _secondViewC.cardView.transform = CGAffineTransformIdentity;
    }
    else if(_currentlyShowingVC == _secondViewC)
    {
        _firstViewC.cardView.transform = CGAffineTransformIdentity;
    }
}

#pragma mark - IBActions -

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

    CGAffineTransform scleTransform = CGAffineTransformMakeScale(0.9, 0.9);

    CGAffineTransform translate = CGAffineTransformMakeTranslation(500.0f, 0.0f);
    
    if(_currentlyShowingVC == _secondViewC)
    {
        _currentlyShowingVC.cardSelectStatusImage.image = [UIImage imageNamed:@"LikeButton"];
        
        _secondViewC.cardView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"].CGColor;
        
        _secondViewC.cardView.layer.borderWidth = 4.0f;
        
        _secondViewC.cardSelectStatusImage.alpha = 1.0f;

        _firstViewC.cardView.transform = CGAffineTransformMakeTranslation(0, 20.0f);
        
        [UIView animateWithDuration:0.4f delay:0.15 usingSpringWithDamping:0.8f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             _firstViewC.cardView.transform = CGAffineTransformIdentity;

                             _secondViewC.cardView.transform = CGAffineTransformConcat(translate, scleTransform);
                             
                         } completion:^(BOOL finished) {
                             
                             [self.view bringSubviewToFront:_firstViewC.view];
                             
                             _currentlyShowingVC = _firstViewC;
                             
                             // now configre SecondView.
                             
                             _currentlyShowingIndexoffset++;
                             
                             _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
                             
                             _secondCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
                             
                             [_secondViewC setProject:_secondCard];
                             
                             [self.view bringSubviewToFront:_optionView];
                             
                             [_currentlyShowingVC showProject];
                             
                             _secondViewC.cardView.transform = CGAffineTransformIdentity;
                             
                             _secondViewC.cardSelectStatusImage.alpha = 0.0f;
                             
                             _secondViewC.cardView.layer.borderColor = [UIColor clearColor].CGColor;
                             
                             _secondViewC.cardView.layer.borderWidth = 0.0f;
                         }];
    }
    else if(_currentlyShowingVC == _firstViewC)
    {
        _currentlyShowingVC.cardSelectStatusImage.image = [UIImage imageNamed:@"LikeButton"];
        
        _secondViewC.cardView.transform = CGAffineTransformMakeTranslation(0, 20.0f);

        _firstViewC.cardSelectStatusImage.alpha = 1.0f;
        
        _firstViewC.cardView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"].CGColor;
        
        _firstViewC.cardView.layer.borderWidth = 4.0f;

        
        [UIView animateWithDuration:0.4f delay:0.15 usingSpringWithDamping:0.8f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             _secondViewC.cardView.transform = CGAffineTransformIdentity;

                             _firstViewC.cardView.transform = CGAffineTransformConcat(translate, scleTransform);
                             
                             

                         } completion:^(BOOL finished) {
                             {
                                 
                                 [self.view bringSubviewToFront:_secondViewC.view];

                                 _currentlyShowingVC = _secondViewC;
                                 
                                 // now configre FirstView.
                                 
                                 _currentlyShowingIndexoffset++;
                                 
                                 _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
                                 
                                 _firstCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
                                 
                                 [_firstViewC setProject:_firstCard];
                                 
                                 [self.view bringSubviewToFront:_optionView];
                                 
                                 [_currentlyShowingVC showProject];
                                 
                                 _firstViewC.cardView.transform = CGAffineTransformIdentity;
                                 
                                 _firstViewC.cardSelectStatusImage.alpha = 0.0f;
                                 
                                 _firstViewC.cardView.layer.borderColor = [UIColor clearColor].CGColor;
                                 
                                 _firstViewC.cardView.layer.borderWidth = 0.0f;
                                 
                                 
                                 
                             }
                         }];
    }

}

- (IBAction)dislikeProjTapped:(id)sender {
    
    [_currentlyShowingVC dismissShowing];
    
    CGAffineTransform translate = CGAffineTransformMakeTranslation(-500.0f, 0.0f);
    
    CGAffineTransform scleTransform = CGAffineTransformMakeScale(0.9, 0.9);
    
    if(_currentlyShowingVC == _secondViewC)
    {
        _currentlyShowingVC.cardSelectStatusImage.image = [UIImage imageNamed:@"DislikeButton"];
        
        _currentlyShowingVC.cardSelectStatusImage.alpha = 1.0f;
        
        _secondViewC.cardView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#FB7575"].CGColor;
        
        _secondViewC.cardView.layer.borderWidth = 4.0f;

        _firstViewC.cardView.transform = CGAffineTransformMakeTranslation(0, 20.0f);
        
        [UIView animateWithDuration:0.4f delay:0.15 usingSpringWithDamping:0.8f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             _firstViewC.cardView.transform = CGAffineTransformIdentity;

                             _secondViewC.cardView.transform = CGAffineTransformConcat(translate, scleTransform);
                             
                         } completion:^(BOOL finished) {
                             
                             [self.view bringSubviewToFront:_firstViewC.view];
                             
                             _currentlyShowingVC = _firstViewC;
                             
                             // now configre SecondView.
                             
                             _currentlyShowingIndexoffset++;
                             
                             _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
                             
                             _secondCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
                             
                             [_secondViewC setProject:_secondCard];
                             
                             [self.view bringSubviewToFront:_optionView];
                             
                             [_currentlyShowingVC showProject];
    
                            _secondViewC.cardView.transform = CGAffineTransformIdentity;
                                 
                            _secondViewC.cardSelectStatusImage.alpha = 0.0f;
                             
                             _secondViewC.cardView.layer.borderColor = [UIColor clearColor].CGColor;
                             
                             _secondViewC.cardView.layer.borderWidth = 0.0f;
                             

                    
                         }];
    }
    else if(_currentlyShowingVC == _firstViewC)
    {
        _currentlyShowingVC.cardSelectStatusImage.image = [UIImage imageNamed:@"DislikeButton"];
        
        _currentlyShowingVC.cardSelectStatusImage.alpha = 1.0f;
        
        _currentlyShowingVC.cardView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#FB7575"].CGColor;
        
        _currentlyShowingVC.cardView.layer.borderWidth = 4.0f;
    
        _secondViewC.cardView.transform = CGAffineTransformMakeTranslation(0, 20.0f);

        [UIView animateWithDuration:0.4f delay:0.15 usingSpringWithDamping:0.8f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             _secondViewC.cardView.transform = CGAffineTransformIdentity;

                             _firstViewC.cardView.transform = CGAffineTransformConcat(translate, scleTransform);
                             
                         } completion:^(BOOL finished) {
                             {
                                 
                                 [self.view bringSubviewToFront:_secondViewC.view];
                                 
                                 _currentlyShowingVC = _secondViewC;
                                 
                                 // now configre FirstView.
                                 
                                 _currentlyShowingIndexoffset++;
                                 
                                 _currentlyShowingIndexoffset = (_currentlyShowingIndexoffset )% _projectList.count;
                                 
                                 _firstCard = [_projectList objectAtIndex:_currentlyShowingIndexoffset];
                                 
                                 [_firstViewC setProject:_firstCard];
                                 
                                 [self.view bringSubviewToFront:_optionView];
                                 
                                 [_currentlyShowingVC showProject];
                                 
                                 _firstViewC.cardView.transform = CGAffineTransformIdentity;
                                 
                                 _firstViewC.cardSelectStatusImage.alpha = 0.0f;
                                 
                                 _firstViewC.cardView.layer.borderColor = [UIColor clearColor].CGColor;
                                 
                                 _firstViewC.cardView.layer.borderWidth = 0.0f;
                                 

                             }
                         }];
    }
    
}

#pragma mark -
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
