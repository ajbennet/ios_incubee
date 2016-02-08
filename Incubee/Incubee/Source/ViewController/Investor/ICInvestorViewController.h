//
//  ICInvestorViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 12/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICInvestorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UITextViewDelegate,UITextFieldDelegate>{

    NSString *adhocTitle;
    
    NSString *adhocEmail;
    
    NSString *meetSelected;
    
    NSString *statusSelected;
    
    NSString *adhocComments;

}

@property (strong, nonatomic) IBOutlet UITableView *investorTableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottonConstraint;


- (IBAction)inviteButtonTapped:(id)sender;

- (IBAction)addButtonTapped:(id)sender;

#pragma mark - Network -
-(void)inviteFounderRequest:(ICRequest*)inRequest;

-(void)adhocIncubeeAddRequest:(ICRequest*)inRequest;

-(void)getAllIncubeesRequest:(ICRequest*)inRequest;

#pragma mark - Adhoc -

@property (weak, nonatomic) IBOutlet UIView *adhocView;

@property (weak, nonatomic) IBOutlet UIButton *adhocSubmit;

@property (weak, nonatomic) IBOutlet UIButton *adhocCancel;

- (IBAction)adhocSubmitTapped:(id)sender;

- (IBAction)adhocCancelTapped:(id)sender;



@property (weak, nonatomic) IBOutlet UITextField *adhocTitleTextField;

@property (weak, nonatomic) IBOutlet UITextField *adhocEmailTextFiled;


@property (weak, nonatomic) IBOutlet UISegmentedControl *meetSegmentView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *statusSegmentView;

@property (weak, nonatomic) IBOutlet StarRatingControl *starRatingView;


@property (weak, nonatomic) IBOutlet UITextView *commentReviewTextView;


@property (weak, nonatomic) IBOutlet UIView *adhocTopView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adhocBottomConstraitns;

- (IBAction)statusValueChanged:(id)sender;

- (IBAction)meetValueChanged:(id)sender;

@end
