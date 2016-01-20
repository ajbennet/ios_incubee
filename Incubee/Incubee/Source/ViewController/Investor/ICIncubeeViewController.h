//
//  ICIncubeeViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 19/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICIncubeeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)Incubee *incubee;

@property (strong, nonatomic) IBOutlet UILabel *titleLable;

@property (strong, nonatomic) IBOutlet UILabel *compnayLable;

@property (strong, nonatomic) IBOutlet UILabel *highConceptLbl;

@property (strong, nonatomic) IBOutlet UITableView *reviewTableView;

@property (strong, nonatomic) IBOutlet UIView *writeReviewView;

@property (strong, nonatomic) IBOutlet UIImageView *investorsProfileImageView;


- (IBAction)cancelReviewTapped:(id)sender;

- (IBAction)submitReviewTapped:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *writeReviewTableView;


@end
