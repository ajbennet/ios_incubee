//
//  ICIncubeeViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 19/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import "ICIncubeeViewController.h"

#define EMPTYREVIEWCELL @"EmptyReviewCell"

#define REVIEWCELLID @"ReviewCellId"

#define TEXT_INPUT_CELL_ID @"TextInputCellIdentifier"

@interface ICRatingProgressView : UIView

@property(nonatomic,strong)UIColor *progressColor;

@property(nonatomic,assign)float progress;

@end

@implementation ICRatingProgressView

-(void)drawRect:(CGRect)rect{
    
    CGRect topRect = CGRectMake(0, 0, (rect.size.width * _progress), rect.size.height);
    // Fill the rectangle with grey
    [_progressColor setFill];
    
    UIRectFill( topRect );

}

@end



@interface  ICReviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet ICImageView *reviewImageView;
@property (weak, nonatomic) IBOutlet UILabel *reviewTitle;
@property (weak, nonatomic) IBOutlet StarRatingControl *reviewRating;
@property (weak, nonatomic) IBOutlet UILabel *reviewDesc;

@property(nonatomic,strong)Review *review;
@end

@implementation ICReviewTableViewCell

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



@interface ICIncubeeViewController ()
{

    NSArray *reviewArray;
    
    NSDictionary *reviewDataDic;
    
    NSString *meetSelected;
    
    NSString *statusSelected;
    
}
@end

@implementation ICIncubeeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *imArray = [[ICDataManager sharedInstance] getImageURLs:_incubee.incubeeId];

    if(imArray.count == 4)
    {
        _topLeftImageView.hidden = _topRightImageView.hidden = _bottomLeftImageView.hidden = _bottomRightImageView.hidden = NO;
        
        _bannerImageView.hidden = YES;
        
        
        //    Image1
        {
            NSString *urlString1 = ((IncubeeImage*)[imArray objectAtIndex:0]).imageUrl;
            
            ICImageManager *im1 = [[ICImageManager alloc] init];
            
            [_topLeftImageView setImageUrl:urlString1];
            
            [im1 getImage:urlString1 withDelegate:self];
        }
        //    Image2
        {
            
            NSString *urlString2 = ((IncubeeImage*)[imArray objectAtIndex:1]).imageUrl;
            
            ICImageManager *im2 = [[ICImageManager alloc] init];
            
            [_topRightImageView setImageUrl:urlString2];
            
            [im2 getImage:urlString2 withDelegate:self];
        }
        //    Image3
        {
            
            
            NSString *urlString3 = ((IncubeeImage*)[imArray objectAtIndex:2]).imageUrl;
            
            ICImageManager *im3 = [[ICImageManager alloc] init];
            
            
            [_bottomLeftImageView setImageUrl:urlString3];
            
            [im3 getImage:urlString3 withDelegate:self];
        }
        //    Image4
        {
            
            NSString *urlString4 = ((IncubeeImage*)[imArray objectAtIndex:3]).imageUrl;
            
            ICImageManager *im4 = [[ICImageManager alloc] init];
            
            [_bottomRightImageView setImageUrl:urlString4];
            
            [im4 getImage:urlString4 withDelegate:self];
        }
        
    }
    else if(imArray.count >= 1)
    {
        _topLeftImageView.hidden = _topRightImageView.hidden = _bottomLeftImageView.hidden = _bottomRightImageView.hidden = YES;
        
        _bannerImageView.hidden = NO;
        
        NSString *urlString1 = ((IncubeeImage*)[imArray objectAtIndex:0]).imageUrl;
        
        ICImageManager *im1 = [[ICImageManager alloc] init];
        
        [_bannerImageView setImageUrl:urlString1];
        
        [im1 getImage:urlString1 withDelegate:self];
    }
    
    
    
    [self showMovie];
    
    
    self.title = _incubee.companyName;
    
    _titleLable.text = _incubee.companyName;
    
    _highConceptLbl.text = _incubee.highConcept;
    
    _compnayLable.text = _incubee.founder;
    
    [_reviewTableView reloadData];
    
    
    _investorsProfileImageView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"].CGColor;
    
    _investorsProfileImageView.layer.borderWidth = 2.0f;
    
    _investorsProfileImageView.layer.cornerRadius = 50.0f;
    
    
    ICImageManager *im1 = [[ICImageManager alloc] init];
    
    [_investorsProfileImageView setImageUrl:[[ICDataManager sharedInstance] getUserProfilePic]];
    
    [im1 getImage:[[ICDataManager sharedInstance] getUserProfilePic] withDelegate:self];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.navigationController.navigationBarHidden = NO;
    
    [self showLoadingReview:YES];

    [[ICAppManager sharedInstance] getReview:_incubee.incubeeId withRequest:nil notifyTo:self forSelector:@selector(reviewLoaded:)];
    
    
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

#pragma mark - UITableView -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    if(tableView == _reviewTableView)
    {
        return 80.0f;
    }
    
    return 0.0f;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(tableView == _reviewTableView)
    {
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _reviewTableView.frame.size.width, 80.0f)];
        
        headView.backgroundColor = [UIColor whiteColor];;
        
        UIButton *aWriteReviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [aWriteReviewButton addTarget:self action:@selector(writeReviewHeaderTapped) forControlEvents:UIControlEventTouchUpInside];
        
        aWriteReviewButton.frame = CGRectMake(0, 0, _reviewTableView.frame.size.width, 80.0f);
        
        [headView addSubview:aWriteReviewButton];
        
        if(reviewArray.count==0)
        {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _reviewTableView.frame.size.width, 80.0f)];
            
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.text = [NSString stringWithFormat:@"Be the first person to review\n %@",_incubee.companyName];
            
            lab.font = [UIFont fontWithName:@"Lato-bold" size:20.0f];
            
            lab.numberOfLines = 0;

            lab.textColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"];
            
            [headView addSubview:lab];
            
            return headView;
        }
        else
        {
            
            UILabel *ratingLab = [[UILabel alloc] initWithFrame:CGRectMake(10,0,100,40.0f)];
            
            ratingLab.backgroundColor = [UIColor clearColor];
            
            ratingLab.text = [[reviewDataDic valueForKey:@"averageRating"] stringValue];
            
            ratingLab.textAlignment = NSTextAlignmentCenter;
            
            ratingLab.font = [UIFont fontWithName:@"Lato-bold" size:40.0f];
            
            [headView addSubview:ratingLab];
            
            
            
            
            StarRatingControl *rattingView = [[StarRatingControl alloc] initWithFrame:CGRectMake(3.0f,40.0f,120.0f,40.0f)];
            
            rattingView.userInteractionEnabled = NO;
            
            rattingView.rating = [[reviewDataDic valueForKey:@"averageRating"] intValue];
            
            [headView addSubview:rattingView];

            
            
            UILabel *totalRatingLab = [[UILabel alloc] initWithFrame:CGRectMake(10,60,100,20.0f)];
            
            totalRatingLab.backgroundColor = [UIColor clearColor];
            
            totalRatingLab.text = [NSString stringWithFormat:@"%@ total",[[reviewDataDic valueForKey:@"noOfRatings"] stringValue]];
            
            totalRatingLab.textAlignment = NSTextAlignmentCenter;
            
            totalRatingLab.font = [UIFont fontWithName:@"Lato" size:10.0f];
            
            [headView addSubview:totalRatingLab];

            
            
            
            aWriteReviewButton.userInteractionEnabled = NO;

            
            UIImageView *allRatingView = [[UIImageView alloc] initWithFrame:CGRectZero];
            
            allRatingView.backgroundColor = [UIColor clearColor];
            
            [headView addSubview:allRatingView];
            
            if([[ICDataManager sharedInstance] isReviewWritten:_incubee.incubeeId]==NO)
            {
                
                allRatingView.frame =   CGRectMake(125.0f,5,tableView.frame.size.width-130.0f , 60);
                
                
                aWriteReviewButton.userInteractionEnabled = YES;
                
                UILabel *writeReviewLabl = [[UILabel alloc] initWithFrame:CGRectMake(125,50.0f, tableView.frame.size.width - 130.f, 40.0f)];
                
                writeReviewLabl.text = [NSString stringWithFormat:@"Write you're review on %@",_incubee.companyName];
                
                writeReviewLabl.font = [UIFont fontWithName:@"Lato-bold" size:10.0f];
                
                writeReviewLabl.textAlignment = NSTextAlignmentCenter;
                
                writeReviewLabl.numberOfLines = 0;
                
                writeReviewLabl.textColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"];
                
                [headView addSubview:writeReviewLabl];
                
            }
            else
            {
            
                aWriteReviewButton.userInteractionEnabled = NO;

                 allRatingView.frame =   CGRectMake(125.0f,5,tableView.frame.size.width-130.0f , 70);
            }

            
            CGRect r = allRatingView.frame;
            
            float he = r.size.height/5;
            
            uint rating = 5;
            
            for(uint i = 0;i<5;i++)
            {
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, i*he, 20.0f, he)];
                
                lab.font = [UIFont fontWithName:@"Lato" size:10.0f];

                UIImageView *imview = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*he, 20.0f, he)];
                imview.contentMode = UIViewContentModeScaleAspectFit;
                
                [imview setImage:[UIImage imageNamed:@"star_highlighted"]];
                
                ICRatingProgressView *progreeView = [[ICRatingProgressView alloc] initWithFrame:CGRectMake(30, i*he+1, r.size.width-40,he-2 )];
                

                UILabel *ratingNumberLab = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, progreeView.frame.size.width, progreeView.frame.size.height)];
                
                ratingNumberLab.font = [UIFont fontWithName:@"Lato" size:10.0f];
                
                ratingNumberLab.textAlignment = NSTextAlignmentLeft;

                [progreeView addSubview:ratingNumberLab];
                
                
                NSArray *ratingArray = [reviewDataDic objectForKey:@"noOfStars"];
                
                int currentRating = [[ratingArray objectAtIndex:(rating-1)] intValue];
                
                ratingNumberLab.text = [NSString stringWithFormat:@"%i",currentRating];
                
                int percent = currentRating * 100/[[reviewDataDic valueForKey:@"noOfRatings"] intValue];
                
                
                progreeView.backgroundColor = [UIColor clearColor];
                
                progreeView.progress = percent/100.0f;
                
                [allRatingView addSubview:progreeView];

                switch (rating) {
                    case 5:
                        progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#9FC160"];
                        
                        break;
                    case 4:
                        progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#AED653"];
                        
                        break;
                    case 3:
                        progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#FDD854"];
                        
                        break;
                    case 2:
                        progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#FCB34E"];
                        
                        break;
                    case 1:
                         progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#F88C5D"];
                        
                        break;
                    default:
                        break;
                }
                
                NSMutableAttributedString *myString= [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%i",rating--]];
                
                lab.attributedText = myString;
                
                [allRatingView addSubview:lab];
                
                [allRatingView addSubview:imview];
            
            }
            
            
            
            
            return headView;
            
        }
    }
    else
    {

        return nil;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return reviewArray.count == 0 ? 1 : reviewArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(reviewArray.count==0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EMPTYREVIEWCELL];
        
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EMPTYREVIEWCELL];
            
        }
        
        [cell.textLabel setText:@"No reviews"];
        
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        
        return cell;

    }
    else
    {
        
        ICReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REVIEWCELLID];
        
        if(!cell)
        {
            cell = [[ICReviewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REVIEWCELLID];
            
        }

        Review *review = [reviewArray objectAtIndex:indexPath.row];

        [cell setReview:review];
        
        if([[ICDataManager sharedInstance] isUserAvailable:review.user_id]==NO)
        {
            [[ICAppManager sharedInstance] getCustomerDetails:review.user_id withRequest:nil notifyTo:self forSelector:@selector(customerDetailRetrived:)];
            
        }
        
        
        return cell;

    }
    
    
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if(tableView == _reviewTableView)
//    {
//        _writeReviewView.hidden = NO;
//    }
//    
//}

-(void)showMovie{
    
    if(_moviePlayer)
    {
        [_moviePlayer stop];
        
        [_moviePlayer.view removeFromSuperview];
        
        _moviePlayer = nil;
    }
    
    if(_incubee.video!=nil)
    {
        _moviePlayerView.hidden = NO;
        
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_incubee.video]];
        
        _moviePlayer.view.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_moviePlayerView addSubview:_moviePlayer.view];
        
        NSLayoutConstraint *width =[NSLayoutConstraint
                                    constraintWithItem:_moviePlayer.view
                                    attribute:NSLayoutAttributeWidth
                                    relatedBy:0
                                    toItem:_moviePlayerView
                                    attribute:NSLayoutAttributeWidth
                                    multiplier:1.0
                                    constant:0];
        
        NSLayoutConstraint *height =[NSLayoutConstraint
                                     constraintWithItem:_moviePlayer.view
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:0
                                     toItem:_moviePlayerView
                                     attribute:NSLayoutAttributeHeight
                                     multiplier:1.0
                                     constant:0];
        
        
        NSLayoutConstraint *topConstr = [NSLayoutConstraint
                                         constraintWithItem:_moviePlayer.view
                                         attribute:NSLayoutAttributeTop
                                         relatedBy:0
                                         toItem:_moviePlayerView
                                         attribute:NSLayoutAttributeTop
                                         multiplier:1.0
                                         constant:0.0];
        
        NSLayoutConstraint *bottomConstr = [NSLayoutConstraint
                                            constraintWithItem:_moviePlayer.view
                                            attribute:NSLayoutAttributeBottom
                                            relatedBy:0
                                            toItem:_moviePlayerView
                                            attribute:NSLayoutAttributeBottom
                                            multiplier:1.0
                                            constant:0.0];
        
        [_moviePlayerView addConstraint:width];
        
        [_moviePlayerView addConstraint:height];
        [_moviePlayerView addConstraint:topConstr];
        [_moviePlayerView addConstraint:bottomConstr];
        
        [_moviePlayerView layoutIfNeeded];
        
        [_moviePlayer.view layoutIfNeeded];
        
        _moviePlayer.controlStyle =  MPMovieControlStyleEmbedded;
        
        _moviePlayer.shouldAutoplay = NO;
        
        _moviePlayer.repeatMode = NO;
        
        _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
        
        [_moviePlayer setFullscreen:NO animated:NO];
        
        [_moviePlayer prepareToPlay];
        
        [_moviePlayer.view setBackgroundColor:[UIColor clearColor]];
        
        [_moviePlayerView bringSubviewToFront:_moviePlayer.view];
        
        [_moviePlayer pause];
    }
    else
    {
        _moviePlayerView.hidden = YES;
    }
    
}


#pragma mark - Review -

-(void)customerDetailRetrived:(ICRequest*)inRequest{

    if(inRequest.error == nil)
    {
        [_reviewTableView reloadData];
    }
}

-(void)reviewSubmitted:(ICRequest*)inRequest{

    if(inRequest.error == nil)
    {
        
        [self showLoadingReview:YES];
        
        [[ICAppManager sharedInstance] getReview:_incubee.incubeeId withRequest:nil notifyTo:self forSelector:@selector(reviewLoaded:)];

        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }

}

- (void)reviewLoaded:(ICRequest*)inRequest{

    reviewArray = [[ICDataManager sharedInstance] getReviewArray:_incubee.incubeeId];
    
    reviewDataDic = [inRequest.parsedResponse objectForKey:@"reviewData"];
    
    [self showLoadingReview:NO];
    
    
    _starRatingView.rating = 4;
    
    [_reviewTableView reloadData];
    
    
    if(inRequest.error == nil)
    {
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
        
    }

    
    
    
    

}

-(void)showLoadingReview:(BOOL)inShow{

    if(inShow)
    {
        [_reloadActivityIndicator startAnimating];
        
        [_reviewLoadingView setHidden:NO];
    }
    else
    {
    
        [_reloadActivityIndicator stopAnimating];
        
        [_reviewLoadingView setHidden:YES];
    }
    
}

-(void)resetWriteReview{

    meetSelected = nil;
    
    statusSelected = nil;
    
    _reviewTitle.text = nil;
    
    _commentsTextView.text = nil;
    
    _starRatingView.rating = -1;
    
    _meetSegment.selectedSegmentIndex = -1;
    
    _statusSegment.selectedSegmentIndex = -1;
    
}


-(void)writeReviewHeaderTapped{

    [self resetWriteReview];
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    _writeReviewView.transform = CGAffineTransformMakeTranslation(0, 800);
    
    _writeReviewView.hidden = NO;


    [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        
        _writeReviewView.transform = CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
        
        [_reviewTitle becomeFirstResponder];
    }];

}




- (IBAction)cancelReviewTapped:(id)sender {
    
    
    [self resignTextFirstResponders];
    
    [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        
        _writeReviewView.transform = CGAffineTransformMakeTranslation(0, 800);
        
        
    } completion:^(BOOL finished) {
        
        _writeReviewView.transform = CGAffineTransformIdentity;
        
        _writeReviewView.hidden = YES;
        
    }];
}

-(BOOL)validateReviewSection{

    NSString *reviewError = nil;
    
    if(_commentsTextView.text.length<1)
    {
        reviewError = @"Please write 'Comments'";
        
    }
    
    else if(_starRatingView.rating==-1)
    {
        reviewError = @"Please rate this Product";

        
    }
    
    else if(([statusSelected isEqualToString:@"INT"] || [statusSelected isEqualToString:@"INV"] || [statusSelected isEqualToString:@"PAS"]) == NO)
    {
        
        reviewError = @"Please select 'Status'";

    }
    
    else if(([meetSelected isEqualToString:@"PER"] || [meetSelected isEqualToString:@"PHO"]) == NO)
    {
        
        reviewError = @"Please select 'Meet'";
        
    }
    else if(_reviewTitle.text.length<1)
    {
        reviewError = @"Please write 'Title'";
        
    }
    
    if(reviewError == nil)
    {
        return  YES;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:reviewError delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    
    [alert show];
    
    return NO;

}

- (IBAction)submitReviewTapped:(id)sender {

    [self resignTextFirstResponders];
    
    if([self validateReviewSection]==NO)
    {
        return;
    }
    
    NSMutableDictionary *reviewDic = [[NSMutableDictionary alloc] init];
    
    [reviewDic setObject:_reviewTitle.text forKey:REVIEW_TITLE];
    [reviewDic setObject:_commentsTextView.text forKey:REVIEW_DESC];
    [reviewDic setObject:_incubee.incubeeId forKey:REVIEW_INCUBEE_ID];
    [reviewDic setObject:[NSNumber numberWithInt:(int)_starRatingView.rating] forKey:REVIEW_RATING];
    [reviewDic setObject:meetSelected forKey:REVIEW_MEETING];
    [reviewDic setObject:statusSelected forKey:REVIEW_STATUS];
    
    
    [[ICAppManager sharedInstance] submitReview:reviewDic withRequest:nil notifyTo:self forSelector:@selector(reviewSubmitted:)];
    
    [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        
        _writeReviewView.transform = CGAffineTransformMakeTranslation(0, 800);

        
    } completion:^(BOOL finished) {
        
        _writeReviewView.transform = CGAffineTransformIdentity;

        _writeReviewView.hidden = YES;

    }];

    
}

#pragma mark - TextView -
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{

    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{


}

- (void)textViewDidEndEditing:(UITextView *)textView{


}

- (void)textViewDidChange:(UITextView *)textView{


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
#pragma mark - Keyboard Hide/Unhide -

- (NSInteger)getKeyBoardHeight:(NSNotification *)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    NSInteger keyboardHeight = keyboardFrameBeginRect.size.height;
    return keyboardHeight;
}

-(void)keyboardWillHide:(NSNotification*) notification
{
        _topItemContainer.hidden = NO;
    {
        _reviewContainerBottomConstraints.constant =  5.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [_writeReviewView layoutIfNeeded];
            
        }];
    }
}

-(void)keyboardDidShow:(NSNotification*) notification
{
    if(![_commentsTextView isFirstResponder])
    {
        return;
    }
    
    _topItemContainer.hidden = YES;
    
    NSInteger keyboardHeight = [self getKeyBoardHeight:notification];
    
    if(keyboardHeight!=0)
    {
        _reviewContainerBottomConstraints.constant = keyboardHeight;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [_writeReviewView layoutIfNeeded];
            
        }];
        
        
    }
    
}

-(void)resignTextFirstResponders{

    if([_reviewTitle isFirstResponder])
    {
        [_reviewTitle resignFirstResponder];
    }
    
    
    if([_commentsTextView isFirstResponder])
    {
        [_commentsTextView resignFirstResponder];
    }

}

- (IBAction)meetStatusChanged:(id)sender {
    
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    
    switch (seg.selectedSegmentIndex) {
        case 0:
            meetSelected = @"PER";
            break;
        case 1:
            meetSelected = @"PHO";
            break;
        default:
            break;
    }
    
    [self resignTextFirstResponders];
}

- (IBAction)statusSegValueChanged:(id)sender {
    
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    
    switch (seg.selectedSegmentIndex) {
        case 0:
            statusSelected = @"INT";
            break;
        case 1:
            statusSelected = @"INV";
            break;
        case 2:
            statusSelected = @"PAS";
            break;
        default:
            break;
    }

        [self resignTextFirstResponders];
}

-(void)imageDataRecived:(NSData*)inImageData ofURL:(NSString *)inUrl{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([_topLeftImageView.imageUrl isEqualToString:inUrl])
        {
            _topLeftImageView.image = [UIImage imageWithData:inImageData];
            
        }
        else if([_topRightImageView.imageUrl isEqualToString:inUrl])
        {
            _topRightImageView.image = [UIImage imageWithData:inImageData];
            
        }
        else if([_bottomRightImageView.imageUrl isEqualToString:inUrl])
        {
            _bottomRightImageView.image = [UIImage imageWithData:inImageData];
            
        }
        else if([_bottomLeftImageView.imageUrl isEqualToString:inUrl])
        {
            _bottomLeftImageView.image = [UIImage imageWithData:inImageData];
            
        }
        else if([_bannerImageView.imageUrl isEqualToString:inUrl])
        {
            _bannerImageView.image = [UIImage imageWithData:inImageData];
            
        }
        else if([_investorsProfileImageView.imageUrl isEqualToString:inUrl]){
        
            _investorsProfileImageView.image = [UIImage imageWithData:inImageData];

        }
        
    });
    
}
@end
