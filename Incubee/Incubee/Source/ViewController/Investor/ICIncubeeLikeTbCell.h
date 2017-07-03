//
//  ICIncubeeLikeTbCell.h
//  Incubee
//
//  Created by R on 01/07/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"

@interface ICIncubeeLikeTbCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *valueLable;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIView *threeButtonActivity;
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;
@property (strong, nonatomic)  DGActivityIndicatorView *activityIndicatorView;
-(void)configureCell:(int)numberOfLikes selected:(BOOL)isSelected;
@end
