//
//  FirstViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 23/05/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <MediaPlayer/MediaPlayer.h>

@interface HomeViewController : UIViewController

@property(nonatomic,strong)NSArray *projectList;


@property (weak, nonatomic) IBOutlet UIButton *yesButton;

@property (weak, nonatomic) IBOutlet UIButton *noButton;

@property(nonatomic,strong) MPMoviePlayerController *moviePlayer;

@property(nonatomic,assign)CGPoint panCoord;

@property(nonatomic,assign)CGPoint selectedCoord;

@property(nonatomic,assign)CGRect originalFrame;

@property(nonatomic,assign)UIView *showingCard;

@property(nonatomic,strong)NSDictionary *selectedCard;

- (IBAction)nextCardTapped:(id)sender;

#pragma mark Card A

@property (weak, nonatomic) IBOutlet UIView *cardA;

@property (weak, nonatomic) IBOutlet UIView *aMediaView;

@property (weak, nonatomic) IBOutlet UILabel *aTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *aDescLab;

@property (weak, nonatomic) IBOutlet UIImageView *aImageView;

@property (weak, nonatomic) IBOutlet UIView *aMovieView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *aActivityIndicator;

#pragma mark Card B

@property (weak, nonatomic) IBOutlet UIView *cardB;

@property (weak, nonatomic) IBOutlet UIView *bMediaView;

@property (weak, nonatomic) IBOutlet UILabel *bTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *bDescLab;

@property (weak, nonatomic) IBOutlet UIImageView *bImageView;

@property (weak, nonatomic) IBOutlet UIView *bMovieView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *bActivityIndicator;

@end

