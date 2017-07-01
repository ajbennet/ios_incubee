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
    
    _activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeLineScalePulseOutRapid tintColor:[[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"] size:20.0f];
    _activityIndicatorView.frame = CGRectMake(0.0f, 0.0f, _threeButtonActivity.frame.size.width, _threeButtonActivity.frame.size.height);
    [_threeButtonActivity addSubview:_activityIndicatorView];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureCell:(int)numberOfLikes{

    if (numberOfLikes == -1){
        _loadingView.hidden = NO;
        [_activityIndicatorView startAnimating];
    }
    else {
        _valueLable.text = [NSString stringWithFormat:@"%i",numberOfLikes];
        _loadingView.hidden = YES;
        [_activityIndicatorView stopAnimating];
    }
}
@end
