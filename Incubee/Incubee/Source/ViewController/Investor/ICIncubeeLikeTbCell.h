//
//  ICIncubeeLikeTbCell.h
//  Incubee
//
//  Created by R on 01/07/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICIncubeeLikeTbCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *valueLable;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

-(void)configureCell:(int)numberOfLikes;
@end
