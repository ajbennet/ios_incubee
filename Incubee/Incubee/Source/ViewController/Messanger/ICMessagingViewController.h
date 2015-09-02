//
//  MessagingTableViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 23/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICMessagingViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *projectArray;

@property(nonatomic,strong)IBOutlet UITableView *projectTableView;

@property (strong, nonatomic) IBOutlet UIView *segmentView;

@property(nonatomic,strong)IBOutlet UISegmentedControl *segmentController;
@end
