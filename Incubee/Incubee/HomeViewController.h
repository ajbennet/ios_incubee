//////
//  FirstViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 17/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICCardViewController.h"

@interface HomeViewController : UIViewController <ICCardViewDelegate>

@property(nonatomic,strong)IBOutlet UIView *v;

@property(nonatomic,strong)ICCardViewController *firstViewC;

@property(nonatomic,strong)ICCardViewController *secondViewC;

@property(nonatomic,strong)ICCardViewController *currentlyShowingVC;

- (IBAction)goNextProject:(id)sender;

- (IBAction)addToCustomer:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *saveProject;

- (IBAction)saveProjTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *dislikeProj;

- (IBAction)dislikeProjTapped:(id)sender;


@property(nonatomic,strong)NSArray* dataArray;

@end

