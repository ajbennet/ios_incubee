//
//  ICCardViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 23/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MediaPlayer/MPMoviePlayerController.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <MediaPlayer/MediaPlayer.h>


@protocol ICCardViewDelegate <NSObject>

@required

-(void)followProject;

-(void)dontFollowProject;

@end


@interface ICCardViewController : UIViewController

@property(nonatomic,strong) MPMoviePlayerController *moviePlayer;

@property (weak, nonatomic) IBOutlet UIView *cardView;

@property(nonatomic,assign)CGPoint panCoord;

@property(nonatomic,assign)CGRect originalFrame;

@property(nonatomic,assign)id<ICCardViewDelegate> delegate;

@property(nonatomic,strong)NSDictionary *project;

@property (weak, nonatomic) IBOutlet UIView *moviePlayerView;

-(void)showProject;

-(void)stopShowingProj;

@property (weak, nonatomic) IBOutlet UILabel *projectTitleLable;

@property (weak, nonatomic) IBOutlet UILabel *projectOwnerLable;

@property (weak, nonatomic) IBOutlet UILabel *projectDescLable;


@property (weak, nonatomic) IBOutlet UIImageView *im1;

@property (weak, nonatomic) IBOutlet UIImageView *im3;

- (IBAction)twitterTapped:(id)sender;

- (IBAction)facebookTapped:(id)sender;

- (IBAction)shareToTapped:(id)sender;


@end
