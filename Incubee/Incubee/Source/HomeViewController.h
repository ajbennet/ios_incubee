//
//  FirstViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 23/05/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property(nonatomic,strong)NSArray *projectList;

@property (weak, nonatomic) IBOutlet UIView *cardA;

@property (weak, nonatomic) IBOutlet UIView *cardAmediaView;

@property (weak, nonatomic) IBOutlet UILabel *caedAtitleLable;

@property (weak, nonatomic) IBOutlet UILabel *cardADesc;

@property (weak, nonatomic) IBOutlet UIImageView *mediaImageView;

@property (weak, nonatomic) IBOutlet UIView *mediaMoviePlayerView;

- (IBAction)nextCardTapped:(id)sender;

@end

