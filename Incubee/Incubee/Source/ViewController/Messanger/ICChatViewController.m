//
//  ICChatViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 20/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICChatViewController.h"
#import "ICChatTableViewCell.h"
#import "Messages.h"
#import "ICDataManager.h"
#import "ICAppManager.h"
#import "ICAppManager+Networking.h"
#import "ICConstants.h"

#import "ICMessengerManager.h"

#define CHAT_CELL_ID @"ChatCell"

@interface ICChatViewController ()

@end

@implementation ICChatViewController

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;

}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.title = _to;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messgesSync) name:CHAT_VIEW_REFRESH object:nil];
    
    _chatArray = [[NSMutableArray alloc] initWithArray:[[ICDataManager sharedInstance] getMessages:_to]];
    
    [_chatTableView reloadData];

    _chatTableView.contentOffset = CGPointMake(0, 0);
    
    [_chatTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionBottom animated:NO];

}

- (void) keyboardWillShow:(NSNotification *)note {
    
    NSDictionary *info  = note.userInfo;
    
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    _chatBottomSpace.constant = (keyboardFrame.size.height - 48.0f);
    
    [_chatTableView setNeedsUpdateConstraints];
    
}

- (void) keyboardWillHide:(NSNotification *)note {
    
    _chatBottomSpace.constant = 0.0f;
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    Messages *mg = [_chatArray objectAtIndex:indexPath.row];
    
    NSString *msg = mg.body;
    
//    CGSize size = [msg sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Lato-regular" size:17.0f]}];
    
    CGSize size = [msg sizeWithFont:[UIFont fontWithName:@"Lato-regular" size:17.0f] constrainedToSize:CGSizeMake(tableView.frame.size.width/2, 1024) lineBreakMode:NSLineBreakByWordWrapping];


    return size.height + 30;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _chatArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    ICChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CHAT_CELL_ID];
    
    if(cell==nil)
    {
        cell = [[ICChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CHAT_CELL_ID];
    
    }
    
    [cell setMessage:[_chatArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (IBAction)sendButtonTapped:(id)sender {
    
    [_chatTextField resignFirstResponder];
    
    [[ICAppManager sharedInstance] sendMsg:nil
                                   textMsg:_chatTextField.text
                                        to:_to
                                      type:(_chatMode == CHAT_VIEW_CUSTOMER_TO_FOUNDER)? @"USR" : @"INC"
                               isToFounder:(_chatMode == CHAT_VIEW_CUSTOMER_TO_FOUNDER)? YES:  NO
                                  notifyTo:self forSelector:@selector(chatResponse:)];
    
}

-(void)messgesSync{

    _chatArray = [[NSMutableArray alloc] initWithArray:[[ICDataManager sharedInstance] getMessages:_to]];
    
    [_chatTableView reloadData];    
    
}

-(void)chatResponse:(ICRequest*)inRequest{

    if(inRequest.error)
    {
    
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"" message:inRequest.error.localizedDescription
                                                    delegate:nil cancelButtonTitle:@"Okay"
                                           otherButtonTitles:nil];
        
        [al show];
    
    }
    else
    {
        _chatTextField.text = nil;
        
        [[ICMessengerManager sharedInstance] syncChat];
    }

}
@end
