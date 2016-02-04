//
//  ICInvestorViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 12/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICInvestorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UITableView *investorTableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottonConstraint;

- (IBAction)inviteButtonTapped:(id)sender;

#pragma mark - Network -
-(void)inviteFounderRequest:(ICRequest*)inRequest;

@end
