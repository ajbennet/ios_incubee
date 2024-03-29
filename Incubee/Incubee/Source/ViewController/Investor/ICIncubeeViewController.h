//
//  ICIncubeeViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 19/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import <MediaPlayer/MediaPlayer.h>
#import "StarRatingControl.h"

@interface ICIncubeeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,ICImageManagerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet ICImageView *bannerImageView;

@property(nonatomic,strong)Incubee *incubee;

@property (strong, nonatomic) IBOutlet UILabel *titleLable;

@property (strong, nonatomic) IBOutlet UILabel *compnayLable;

@property (strong, nonatomic) IBOutlet UILabel *highConceptLbl;

@property (strong, nonatomic) IBOutlet UITableView *reviewTableView;

@property (strong, nonatomic) IBOutlet UIView *writeReviewView;

@property (strong, nonatomic) IBOutlet ICImageView *investorsProfileImageView;

@property(nonatomic,strong) MPMoviePlayerController *moviePlayer;


- (IBAction)cancelReviewTapped:(id)sender;

- (IBAction)submitReviewTapped:(id)sender;



@property (strong, nonatomic) IBOutlet NSLayoutConstraint *reviewContainerBottomConstraints;

@property (strong, nonatomic) IBOutlet UITextField *reviewTitle;

@property (strong, nonatomic) IBOutlet UISegmentedControl *meetSegment;

@property (strong, nonatomic) IBOutlet UISegmentedControl *statusSegment;

@property (strong, nonatomic) IBOutlet UITextView *commentsTextView;

- (IBAction)meetStatusChanged:(id)sender;

- (IBAction)statusSegValueChanged:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *topItemContainer;


@property (weak, nonatomic) IBOutlet ICImageView *bottomRightImageView;
@property (weak, nonatomic) IBOutlet ICImageView *bottomLeftImageView;

@property (weak, nonatomic) IBOutlet ICImageView *topRightImageView;

@property (weak, nonatomic) IBOutlet ICImageView *topLeftImageView;

@property (weak, nonatomic) IBOutlet UIView *reviewLoadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *reloadActivityIndicator;

@property (weak, nonatomic) IBOutlet UIView *moviePlayerView;

@property (weak, nonatomic) IBOutlet StarRatingControl *starRatingView;
@property (weak, nonatomic) IBOutlet UIView *detailsTextContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrainOfContainer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reviewSectionTopConstrinat;

@property (weak, nonatomic) IBOutlet UIButton *commentsDoneButton;
- (IBAction)commetnsDoneTapped:(id)sender;

@end
