//
//  ICInvestorViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 12/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICInvestorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *investorTableView;

- (IBAction)inviteButtonTapped:(id)sender;
@end
