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


#define CHAT_CELL_ID @"ChatCell"

@interface ICChatViewController ()

@end

@implementation ICChatViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;

    _chatArray = [[NSMutableArray alloc] initWithArray:[[ICDataManager sharedInstance] getMessages:nil]];

    [_chatTableView reloadData];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _project.companyName;
    
    
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
    
    CGSize size = [msg sizeWithFont:[UIFont fontWithName:@"Lato-regular" size:17.0f] constrainedToSize:CGSizeMake(tableView.frame.size.width/2, 1024) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 20;


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

@end
