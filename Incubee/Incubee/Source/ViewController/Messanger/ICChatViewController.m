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
#import "ICUtilityManager.h"
#import "ICImageManager.h"

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
    
    [self setupTitleView];


    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messgesSync) name:CHAT_VIEW_REFRESH object:nil];
    
    _chatArray = [[NSMutableArray alloc] initWithArray:[[ICDataManager sharedInstance] getMessages:_to]];
    
    NSLog(@"%@",_chatArray);
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
    
    float hIs = [msg
     boundingRectWithSize:CGSizeMake(tableView.frame.size.width/2, 1024)
     options:NSStringDrawingUsesLineFragmentOrigin
     attributes:@{ NSFontAttributeName:[UIFont fontWithName:@"Lato-regular" size:17.0f] }
     context:nil]
    .size.height;

    return hIs + 50;

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

#pragma mark - Private -

-(void)setupTitleView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250.0f, 40.0f)];
    
    titleView.backgroundColor = [UIColor clearColor];

    
    
    // Title Image
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 36.0f, 36.0f)];
    
    titleImage.backgroundColor = [UIColor clearColor];
    
    titleImage.layer.cornerRadius = titleImage.bounds.size.width/2;
    
    titleImage.layer.masksToBounds = YES;

    [titleView addSubview:titleImage];
    
    
    
    // TitleLable
    UILabel *titLable = [[UILabel alloc] initWithFrame:CGRectZero];

    [titLable setFont:[UIFont fontWithName:@"Lato-regular" size:20.0f]];
    
    [titLable setTextAlignment:NSTextAlignmentCenter];
    
    [titLable setTextColor:[[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"]];
    
    [titleView addSubview:titLable];

    if(_chatMode==CHAT_VIEW_CUSTOMER_TO_FOUNDER)
    {
        titLable.text = [[ICDataManager sharedInstance] getIncubeeName:_to];
        
        NSArray *imArray = [[ICDataManager sharedInstance] getImageURLs:_to];
        
        if(imArray.count>=1)
        {
            NSString *urlString1 = ((IncubeeImage*)[imArray objectAtIndex:0]).imageUrl;
            
            [titleImage setImage:[UIImage imageWithData:[[ICImageStore sharedInstance] getImage:urlString1]]];
        }
    
    }
    else if(_chatMode==CHAT_VIEW_FOUNDER_TO_CUSTOMER)
    {
        titLable.text = [[ICDataManager sharedInstance] getCustomerName:_to];
        
        if([[ICDataManager sharedInstance] getCustomerPic:_to]==nil)
        {
            [titleImage setImage:[UIImage imageNamed:@"person_silhouette"]];
        }
        else
        {
        
            [titleImage setImage:[UIImage imageWithData:[[ICImageStore sharedInstance] getImage:[[ICDataManager sharedInstance] getCustomerPic:_to]]]];
        }
        
    }
    
    CGSize lableSize = titLable.intrinsicContentSize;
    
    if (lableSize.width>=210) {

        [titLable setFrame:CGRectMake(40.0f, 0, 210.0f, 40.0f)];
    }
    else
    {
        float diff = 250 - (lableSize.width+40.0f);
        
        [titleImage setFrame:CGRectMake((diff/2)+2, 2, 36.0f, 36.0f)];
        
        [titLable setFrame:CGRectMake((diff/2)+40.0f+2.0f, 0.0f, lableSize.width,40.0f)];
    
    }
          
    
    
    self.navigationItem.titleView = titleView;
    
}
@end
