//
//  ICAdhocIncubeeViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 09/02/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdhocIncubee+CoreDataClass.h"
#import "StarRatingControl.h"

@interface ICAdhocIncubeeViewController : UIViewController<ICImageManagerDelegate>

@property(nonatomic,assign)AdhocIncubee *adhocIncubee;

@property (weak, nonatomic) IBOutlet UILabel *emailIdLable;

@property (weak, nonatomic) IBOutlet UITableView *adhocTableView;

@property (weak, nonatomic) IBOutlet UIView *writeReviewView;

@property (weak, nonatomic) IBOutlet ICImageView *investorsProfileImageView;


@property (weak, nonatomic) IBOutlet UIView *topItemContainer;


@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;

@property (weak, nonatomic) IBOutlet UITextField *reviewTitle;

- (IBAction)cancelReviewTapped:(id)sender;

- (IBAction)submitReviewTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *meetSegment;

- (IBAction)statusSegValueChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegment;

- (IBAction)meetStatusChanged:(id)sender;

@property (weak, nonatomic) IBOutlet StarRatingControl *starRatingView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *reloadActivityIndicator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reviewContainerBottomConstraints;
@property (weak, nonatomic) IBOutlet UIView *reviewLoadingView;

@property (weak, nonatomic) IBOutlet UIButton *commetsDoneButton;

- (IBAction)commetsDoneTaped:(id)sender;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerTopSpace;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reviewSectionTopConstraint;
@end
