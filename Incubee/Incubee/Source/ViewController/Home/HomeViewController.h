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

@interface HomeViewController : UIViewController <ICCardViewDelegate>

@property(nonatomic,strong)IBOutlet UIView *v;

@property(nonatomic,strong)ICCardViewController *firstViewC;

@property(nonatomic,strong)ICCardViewController *secondViewC;

@property(nonatomic,strong)ICCardViewController *currentlyShowingVC;

@property (weak, nonatomic) IBOutlet UIButton *dislikeProj;

@property (weak, nonatomic) IBOutlet UIButton *saveProject;
- (IBAction)goNextProject:(id)sender;

- (IBAction)addToCustomer:(id)sender;

- (IBAction)saveProjTapped:(id)sender;

- (IBAction)dislikeProjTapped:(id)sender;

@property(nonatomic,strong)NSArray *projectList;

-(void)projectDataRefreshed:(ICRequest*)inRequest;

@property(nonatomic,strong)Project *firstCard;

@property(nonatomic,strong)Project *secondCard;

@end

