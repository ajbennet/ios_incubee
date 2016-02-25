//
//  ICReviewTableViewCell.m
//  Incubee
//
//  Created by Rithesh Rao on 09/02/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import "ICReviewTableViewCell.h"

@implementation ICReviewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if(self){
        
        
        return self;
    }
    
    return nil;
}


-(void)setReview:(Review *)review{
    
    _review = review;
    
    _reviewTitle.text = review.reviewTitle;
    
    _reviewDesc.text = review.reviewDescription;
    
    _reviewRating.rating = review.rating.intValue;
    
    _reviewImageView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#6D6D6D"].CGColor;
    
    _reviewImageView.layer.borderWidth = 1.0f;
    
    _reviewImageView.backgroundColor = [UIColor whiteColor];
    
    _reviewImageView.layer.cornerRadius = _reviewImageView.frame.size.width/2;
    
    NSString *reviewImageURL = [[ICDataManager sharedInstance] getCustomerPic:_review.user_id];
    
    _reviewImageView.image = [UIImage imageNamed:@"person_silhouette"];
    
    _reviewImageView.clipsToBounds = YES;
    
    if(reviewImageURL)
    {
        ICImageManager *im1 = [[ICImageManager alloc] init];
        
        [_reviewImageView setImageUrl:reviewImageURL];
        
        [im1 getImage:reviewImageURL withDelegate:self];
    }
}

-(void)imageDataRecived:(NSData*)inImageData ofURL:(NSString *)inUrl{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([_reviewImageView.imageUrl isEqualToString:inUrl])
        {
            _reviewImageView.image = [UIImage imageWithData:inImageData];
            
            _reviewImageView.layer.masksToBounds = YES;
            
        }
    });
    
}



@end