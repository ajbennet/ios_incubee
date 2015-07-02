//
//  ICCardViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 23/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICDataManager.h"
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Project.h"
#import "ProjectImage.h"
#import "ICImageManager.h"


@protocol ICCardViewDelegate <NSObject,ICImageManagerDelegate>

@required

-(void)followCurrentProject;

-(void)dontFollowCurrentProject;

-(void)updateCurrentProjDescLable;

@end


@interface ICImageView : UIImageView

@property(nonatomic,strong)NSString *imageUrl;

@end

@interface ICCardViewController : UIViewController

@property(nonatomic,strong) MPMoviePlayerController *moviePlayer;

@property (weak, nonatomic) IBOutlet UIView *cardView;

@property(nonatomic,assign)CGPoint panCoord;

@property(nonatomic,assign)CGRect originalFrame;

@property(nonatomic,assign)id<ICCardViewDelegate> delegate;

@property(nonatomic,strong,setter=setProject:)Project *project;

@property (weak, nonatomic) IBOutlet UIView *moviePlayerView;

@property (weak, nonatomic) IBOutlet UILabel *projectTitleLable;

@property (weak, nonatomic) IBOutlet UILabel *projectOwnerLable;

@property (weak, nonatomic) IBOutlet ICImageView *bottomRightImageView;
@property (weak, nonatomic) IBOutlet ICImageView *bottomLeftImageView;

@property (weak, nonatomic) IBOutlet ICImageView *topRightImageView;

@property (weak, nonatomic) IBOutlet ICImageView *topLeftImageView;

- (IBAction)twitterTapped:(id)sender;

- (IBAction)facebookTapped:(id)sender;

- (IBAction)shareToTapped:(id)sender;

- (void)setProject:(Project *)project;

- (void)showProject;

- (void)dismissShowing;

@property(nonatomic,assign)CGAffineTransform originalTransform;
@property(nonatomic,assign)CGAffineTransform updatedTransform;

@end
