//
//  ICReviewTableViewCell.h
//  Incubee
//
//  Created by Rithesh Rao on 09/02/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarRatingControl.h"

@interface ICReviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ICImageView *reviewImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewTitle;
@property (weak, nonatomic) IBOutlet StarRatingControl *reviewRating;
@property (weak, nonatomic) IBOutlet UILabel *reviewDesc;
@property (strong, nonatomic) IBOutlet UILabel *dateLable;

@property(nonatomic,strong)Review *review;
@property (strong, nonatomic) IBOutlet UIImageView *editableImageView;

@end
