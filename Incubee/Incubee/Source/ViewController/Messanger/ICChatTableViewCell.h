//
//  ICChatTableViewCell.h
//  Incubee
//
//  Created by Rithesh Rao on 20/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Messages;

@interface ICChatTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIView *incomingView;

@property (strong, nonatomic) IBOutlet UIImageView *incomingBubbleImageView;

@property (strong, nonatomic) IBOutlet UILabel *incomingChatLable;

@property (strong, nonatomic) IBOutlet UILabel *incomingDateLable;

@property (strong, nonatomic) IBOutlet UIView *outgoingView;
@property (strong, nonatomic) IBOutlet UIImageView *outgoingBubbleImageView;
@property (strong, nonatomic) IBOutlet UILabel *outgoingDateLable;

@property (strong, nonatomic) IBOutlet UILabel *outgoingChatLable;
@property(nonatomic,strong)Messages *message;

@end
