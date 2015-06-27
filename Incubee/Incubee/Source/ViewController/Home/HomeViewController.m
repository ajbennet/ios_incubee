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
    
    
    NSMutableDictionary *aDic = [[NSMutableDictionary alloc] init];
    
    [aDic setObject:@"Socigo" forKey:@"company_name"];
    [aDic setObject:@"www.socigo.com" forKey:@"company_url"];
    [aDic setObject:@"null" forKey:@"contact_email"];
    [aDic setObject:@"Socigo rethinks the way gaming platform for the modern gamers." forKey:@"description"];
    [aDic setObject:@"Gaming" forKey:@"field"];
    [aDic setObject:@"Mark Cuban" forKey:@"founder"];
    [aDic setObject:@"true" forKey:@"funding"];
    [aDic setObject:@"A New Generation Open Source Gaming Platform" forKey:@"high_concept"];
    [aDic setObject:@"inc_952745e0-ea2e-4365-83b3-cd379072ce57" forKey:@"id"];
    [aDic setObject:@"Belgium" forKey:@"location"];
    [aDic setObject:@"null" forKey:@"logo_url"];
    [aDic setObject:@"Just-launched" forKey:@"project_status"];
    [aDic setObject:@"https://twitter.com/socigo" forKey:@"twitter_url"];
    [aDic setObject:@"https://incubee-images.s3.amazonaws.com/vid_e6c9ce69-e059-40d3-9483-ac86a44fe05c" forKey:@"video"];
    [aDic setObject:@"null" forKey:@"video_url"];
    
    NSArray *a = [[NSArray alloc] initWithObjects:@"https://incubee-images.s3.amazonaws.com/img_5cc1404d-06c6-434d-add0-87a0aee599c5",@"https://incubee-images.s3.amazonaws.com/img_6dc8511c-ad82-415e-8a36-48c54d23749c",@"https://incubee-images.s3.amazonaws.com/img_b54dcad7-8550-43fb-aa77-ce13db53acfb",@"https://incubee-images.s3.amazonaws.com/img_c4014f2b-1bb8-4f49-a631-27935f989a3d",nil];
    
    [aDic setObject:a forKey:@"images"];
    
    
    NSMutableDictionary *aDic2 = [[NSMutableDictionary alloc] init];
    
    [aDic2 setObject:@"Hipmunk" forKey:@"company_name"];
    [aDic2 setObject:@"www.hipmunk.com" forKey:@"company_url"];
    [aDic2 setObject:@"null" forKey:@"contact_email"];
    [aDic2 setObject:@"Fastest way to travel and Hipmunk makes it easier." forKey:@"description"];
    [aDic2 setObject:@"Travel" forKey:@"field"];
    [aDic2 setObject:@"Elon Musk" forKey:@"founder"];
    [aDic2 setObject:@"true" forKey:@"funding"];
    [aDic2 setObject:@"Search flights and hotels faster" forKey:@"high_concept"];
    [aDic2 setObject:@"inc_68237436-bedf-4aa8-8cd9-321893d1255c" forKey:@"id"];
    [aDic2 setObject:@"WA" forKey:@"location"];
    [aDic2 setObject:@"null" forKey:@"logo_url"];
    [aDic2 setObject:@"Launched-with-customers" forKey:@"project_status"];
    [aDic2 setObject:@"http://twitter.com/hipmunk" forKey:@"twitter_url"];
    [aDic2 setObject:@"https://incubee-images.s3.amazonaws.com/vid_9a1bf404-da5d-419f-95ca-6446988268e2" forKey:@"video"];
    [aDic2 setObject:@"null" forKey:@"video_url"];
    
    NSArray *b = [[NSArray alloc] initWithObjects:@"https://incubee-images.s3.amazonaws.com/img_3233ac62-7e66-4f50-b5ed-99260ed08cdb",@"https://incubee-images.s3.amazonaws.com/img_9d3cb74d-dde2-4234-8981-6e6582099492",@"https://incubee-images.s3.amazonaws.com/img_ad648878-2185-4f78-8682-42f286d75f93",@"https://incubee-images.s3.amazonaws.com/img_dfc833ce-d07b-43ce-94b3-df61b0482058",nil];
    
    [aDic2 setObject:b forKey:@"images"];
    
    _dataArray = [[NSArray alloc] initWithObjects:aDic,aDic2,nil];

    
    self.navigationController.navigationBarHidden = YES;

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"CardViewStoryboard" bundle:nil];
    
    _firstViewC = (ICCardViewController*)[sb instantiateViewControllerWithIdentifier:@"ICCardVCSB"];
    
    _firstViewC.delegate = self;
    
    [_firstViewC setProject:[_dataArray objectAtIndex:0]];
    
    [_firstViewC willMoveToParentViewController:self];

    [self addChildViewController:_firstViewC];
    
    [self.view addSubview:_firstViewC.view];

    [_firstViewC didMoveToParentViewController:self];
    
//    [_firstViewC.cardView setBackgroundColor:[UIColor clearColor]];

    // Second View
    
    _secondViewC = (ICCardViewController*)[sb instantiateViewControllerWithIdentifier:@"ICCardVCSB"];
    
    _secondViewC.delegate = self;
    
    [_secondViewC setProject:[_dataArray objectAtIndex:1]];

    [_secondViewC willMoveToParentViewController:self];
    
    [self addChildViewController:_secondViewC];
    
    [self.view addSubview:_secondViewC.view];
    
    [_secondViewC didMoveToParentViewController:self];
    
//    [_secondViewC.cardView setBackgroundColor:[UIColor clearColor]];

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
    
    if(_currentlyShowingVC == _secondViewC)
    {
        [self.view bringSubviewToFront:_firstViewC.view];
        
        [_currentlyShowingVC setProject:[_dataArray objectAtIndex:0]];
        
        _currentlyShowingVC = _firstViewC;
    
    }
    else if(_currentlyShowingVC == _firstViewC)
    {
        [self.view bringSubviewToFront:_secondViewC.view];
        
        [_currentlyShowingVC setProject:[_dataArray objectAtIndex:1]];
        
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
    
}

-(void)showLoginScreen{

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ICLoginViewController" bundle:nil];
    
    UINavigationController *loginNavigationController = [sb instantiateViewControllerWithIdentifier:@"LoginNavigationStoryBoard"];
    
    loginNavigationController.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:loginNavigationController animated:YES completion:nil];
        
}

@end
