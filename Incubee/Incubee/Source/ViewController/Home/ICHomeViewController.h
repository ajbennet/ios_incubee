//
//  FirstViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 17/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICCardViewController.h"
#import "ICRequest.h"
#import "Project.h"

@interface ICHomeViewController : UIViewController <ICCardViewDelegate>{

    BOOL isFirstTimeLoading;
}

@property(nonatomic,strong)NSArray *projectList;

@property(nonatomic,assign)int currentlyShowingIndexoffset;

@property(nonatomic,strong)IBOutlet UIView *optionView;

@property(nonatomic,strong)ICCardViewController *firstViewC;

@property(nonatomic,strong)ICCardViewController *secondViewC;

@property(nonatomic,strong)ICCardViewController *currentlyShowingVC;

@property (weak, nonatomic) IBOutlet UILabel *projDescLable;

@property(nonatomic,strong)Project *firstCard;

@property(nonatomic,strong)Project *secondCard;



#pragma mark - Activity View - 

@property (weak, nonatomic) IBOutlet UIView *activityView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UILabel *activityLable;


@property (weak, nonatomic) IBOutlet UIButton *dislikeProj;

@property (weak, nonatomic) IBOutlet UIButton *likeProjButton;

- (IBAction)likeProjectTapped:(id)sender;

- (IBAction)dislikeProjTapped:(id)sender;


- (IBAction)goNextProject:(id)sender;

- (IBAction)addToCustomer:(id)sender;


- (IBAction)refreshView:(id)sender;

#pragma mark - Network Notifications -

- (void)projectDataRefreshed:(ICRequest*)inRequest;

- (void)loginResponse:(ICRequest*)inRequest;



@end

