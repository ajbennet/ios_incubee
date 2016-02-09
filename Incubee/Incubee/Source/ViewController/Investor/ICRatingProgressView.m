//
//  ICRatingProgressView.m
//  Incubee
//
//  Created by Rithesh Rao on 09/02/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import "ICRatingProgressView.h"

@implementation ICRatingProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect)rect{
    
    CGRect topRect = CGRectMake(0, 0, (rect.size.width * _progress), rect.size.height);
    // Fill the rectangle with grey
    [_progressColor setFill];
    
    UIRectFill( topRect );
    
}

@end
