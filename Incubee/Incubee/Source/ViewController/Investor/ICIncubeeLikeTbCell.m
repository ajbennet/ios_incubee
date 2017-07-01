//
//  ICIncubeeLikeTbCell.m
//  Incubee
//
//  Created by R on 01/07/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "ICIncubeeLikeTbCell.h"

@implementation ICIncubeeLikeTbCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(int)numberOfLikes{

    if (numberOfLikes == -1){
        _loadingView.hidden = NO;
        [_activityIndicator startAnimating];
    }
    else {
        _valueLable.text = [NSString stringWithFormat:@"%i",numberOfLikes];
        _loadingView.hidden = YES;
        [_activityIndicator stopAnimating];
    }    
}
@end
