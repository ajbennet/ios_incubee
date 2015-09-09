//
//  ICChatViewController.h
//  Incubee
//
//  Created by Rithesh Rao on 20/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "ICConstants.h"

@interface ICChatViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *chatArray;

@property(nonatomic,assign)CHAT_VIEW_MODE chatMode;

@property(nonatomic,strong)NSString *to;

@property(nonatomic,assign)BOOL isCustomer;

@property (strong, nonatomic) IBOutlet UITableView *chatTableView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *chatBottomSpace;

@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@property (strong, nonatomic) IBOutlet UITextField *chatTextField;

- (IBAction)sendButtonTapped:(id)sender;

@end
