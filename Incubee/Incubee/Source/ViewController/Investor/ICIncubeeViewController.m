//
//  ICIncubeeViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 19/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import "ICIncubeeViewController.h"
#import "ICReviewTableViewCell.h"
#import "ICRatingProgressView.h"
#import "ICIncubeeLikeTbCell.h"

#define EMPTYREVIEWCELL @"EmptyReviewCell"

#define REVIEWCELLID @"ReviewCellId"

#define TEXT_INPUT_CELL_ID @"TextInputCellIdentifier"


@interface ICIncubeeViewController ()
{

    NSArray *reviewArray;
    
    NSDictionary *reviewDataDic;
    
    NSString *meetSelected;
    
    NSString *statusSelected;
    
    int likeValue;
    
    BOOL isUserAlreadyLiked;
    
}
@end

@implementation ICIncubeeViewController

NSString *reviewEditorId = nil;


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
    else if(!imArray)
    {
        _topLeftImageView.hidden = _topRightImageView.hidden = _bottomLeftImageView.hidden = _bottomRightImageView.hidden = YES;
        
        _bannerImageView.hidden = NO;

    }
    
    
    
    [self showMovie];
    
    
    self.title = _incubee.companyName;
    
    _titleLable.text = _incubee.companyName;
    
    _highConceptLbl.text = _incubee.highConcept;
    
    _compnayLable.text = _incubee.founder;
    
    [_reviewTableView reloadData];
    
    
    _investorsProfileImageView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
//    _investorsProfileImageView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#6D6D6D"].CGColor;
    
    
    _investorsProfileImageView.layer.borderWidth = 2.0f;
    
    _investorsProfileImageView.layer.cornerRadius = 40.0f;
    
    
    ICImageManager *im1 = [[ICImageManager alloc] init];
    
    [_investorsProfileImageView setImageUrl:[[ICDataManager sharedInstance] getUserProfilePic]];
    
    [im1 getImage:[[ICDataManager sharedInstance] getUserProfilePic] withDelegate:self];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.navigationController.navigationBarHidden = NO;
    
    [self showLoadingReview:YES];
    
    likeValue = -1;
    
    [_reviewTableView registerNib:[UINib nibWithNibName:@"ICIncubeeLikeTbCell" bundle:nil] forCellReuseIdentifier:@"LikeCellID"];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 1:{
            return 100.0f;
        }
            break;
        default:
        case 0:{
            return 40.0f;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    switch (section) {
        case 1:{
            return 80.0f;
        }
            break;
        default:
        case 0:{
            return 0.0f;
        }
            break;
    }
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 1:{
            
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _reviewTableView.frame.size.width, 100.0f)];
            
            headView.backgroundColor = [UIColor whiteColor];;
            
            UIButton *aWriteReviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [aWriteReviewButton addTarget:self action:@selector(writeReviewHeaderTapped) forControlEvents:UIControlEventTouchUpInside];
            
            aWriteReviewButton.frame = CGRectMake(0, 0, _reviewTableView.frame.size.width, 80.0f);
            
            [headView addSubview:aWriteReviewButton];
            
            if(reviewArray.count == 0 || reviewDataDic == nil)
            {
                
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _reviewTableView.frame.size.width, 80.0f)];
                
                lab.textAlignment = NSTextAlignmentCenter;
                
                lab.text = [NSString stringWithFormat:@"Be the first person to review\n %@",_incubee.companyName];
                
                lab.font = [UIFont fontWithName:@"Lato-regular" size:17.0f];
                
                lab.numberOfLines = 0;
                
                lab.textColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#6D6D6D"];
                
                [headView addSubview:lab];
                
                return headView;
            }
            else
            {
                
                UILabel *ratingLab = [[UILabel alloc] initWithFrame:CGRectMake(10,5,50,60.0f)];
                
                ratingLab.backgroundColor = [UIColor clearColor];
                
                ratingLab.text = [[reviewDataDic valueForKey:@"averageRating"] stringValue];
                
                ratingLab.textAlignment = NSTextAlignmentCenter;
                
                ratingLab.font = [UIFont fontWithName:@"Lato-bold" size:40.0f];
                
                [headView addSubview:ratingLab];
                
                
                
                
                StarRatingControl *rattingView = [[StarRatingControl alloc] initWithFrame:CGRectMake(60.0f,20.0f,120.0f,40.0f)];
                
                rattingView.userInteractionEnabled = NO;
                
                rattingView.rating = [[reviewDataDic valueForKey:@"averageRating"] intValue];
                
                [headView addSubview:rattingView];
                
                
                
                UILabel *totalRatingLab = [[UILabel alloc] initWithFrame:CGRectMake(60,40,120,20.0f)];
                
                totalRatingLab.backgroundColor = [UIColor clearColor];
                
                totalRatingLab.text = [NSString stringWithFormat:@"%@ reviews",[[reviewDataDic valueForKey:@"noOfRatings"] stringValue]];
                
                totalRatingLab.textAlignment = NSTextAlignmentCenter;
                
                totalRatingLab.font = [UIFont fontWithName:@"Lato" size:12.0f];
                
                [headView addSubview:totalRatingLab];
                
                
                
                
                aWriteReviewButton.userInteractionEnabled = NO;
                
                
                UIImageView *allRatingView = [[UIImageView alloc] initWithFrame:CGRectZero];
                
                allRatingView.backgroundColor = [UIColor clearColor];
                
                [headView addSubview:allRatingView];
                
                //        if([[ICDataManager sharedInstance] isReviewWritten:_incubee.incubeeId]==NO)
                {
                    
                    allRatingView.frame =   CGRectMake(200.0f,15,tableView.frame.size.width-210.0f , 20);
                    
                    
                    aWriteReviewButton.userInteractionEnabled = YES;
                    
                    UILabel *writeReviewLabl = [[UILabel alloc] initWithFrame:CGRectMake(5,50.0f, tableView.frame.size.width - 10.f, 40.0f)];
                    
                    writeReviewLabl.text = [NSString stringWithFormat:@"Write you're review on %@",_incubee.companyName];
                    
                    writeReviewLabl.font = [UIFont fontWithName:@"Lato-bold" size:10.0f];
                    
                    writeReviewLabl.textAlignment = NSTextAlignmentCenter;
                    
                    writeReviewLabl.numberOfLines = 0;
                    
                    writeReviewLabl.textColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#6D6D6D"];
                    
                    [headView addSubview:writeReviewLabl];
                    
                }
                //        else
                //        {
                //
                //            aWriteReviewButton.userInteractionEnabled = NO;
                //
                //            allRatingView.frame =   CGRectMake(200.0f,15,tableView.frame.size.width-210.0f , 30);
                //        }
                
                
                CGRect r = allRatingView.frame;
                
                float he = r.size.height/5;
                
                uint rating = 5;
                
                for(uint i = 0;i<5;i++)
                {
                    
                    ICRatingProgressView *progreeView = [[ICRatingProgressView alloc] initWithFrame:CGRectMake(5, i*he+8, r.size.width-10,he)];
                    
                    
                    UILabel *ratingNumberLab = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, progreeView.frame.size.width, progreeView.frame.size.height)];
                    
                    ratingNumberLab.font = [UIFont fontWithName:@"Lato" size:4.0f];
                    
                    ratingNumberLab.textAlignment = NSTextAlignmentLeft;
                    
                    [progreeView addSubview:ratingNumberLab];
                    
                    
                    NSArray *ratingArray = [reviewDataDic objectForKey:@"noOfStars"];
                    
                    int currentRating = [[ratingArray objectAtIndex:(rating-1)] intValue];
                    
                    
                    int percent = currentRating * 100/[[reviewDataDic valueForKey:@"noOfRatings"] intValue];
                    
                    
                    progreeView.backgroundColor = [UIColor clearColor];
                    
                    progreeView.progress = percent/100.0f;
                    
                    [allRatingView addSubview:progreeView];
                    
                    progreeView.layer.borderWidth = 0.0f;
                    
                    
                    switch (rating--) {
                        case 5:
                            progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#9FC160"];
                            
                            progreeView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#9FC160"].CGColor;
                            
                            ratingNumberLab.text =[NSString stringWithFormat:@"\u2606\u2606\u2606\u2606\u2606"];
                            
                            
                            break;
                        case 4:
                            progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#AED653"];
                            ratingNumberLab.text = @"\u2606\u2606\u2606\u2606";
                            progreeView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#AED653"].CGColor;
                            
                            break;
                        case 3:
                            progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#FDD854"];
                            ratingNumberLab.text = @"\u2606\u2606\u2606";
                            progreeView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#FDD854"].CGColor;
                            
                            break;
                        case 2:
                            progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#FCB34E"];
                            ratingNumberLab.text = @"\u2606\u2606";
                            progreeView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#FCB34E"].CGColor;
                            
                            break;
                        case 1:
                            progreeView.progressColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#F88C5D"];
                            ratingNumberLab.text = @"\u2606";
                            
                            progreeView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#F88C5D"].CGColor;
                            
                            break;
                        default:
                            break;
                    }
                    
                }
                
                return headView;
                
            }
            
        }
            break;
        default:
        case 0:{
            return nil;
        }
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 1:{
            return reviewArray.count == 0 ? 1 : reviewArray.count;
        }
            break;
        default:
        case 0:{
            return 1;
        }
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    switch (indexPath.section) {
        case 1:{

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
            break;
        default:
        case 0:{
            ICIncubeeLikeTbCell *likeCell = [tableView dequeueReusableCellWithIdentifier:@"LikeCellID"];
            if(!likeCell){
                likeCell = [[ICIncubeeLikeTbCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LikeCellID"];
                likeCell.selectionStyle = UITableViewCellEditingStyleNone;
            }            
            [likeCell configureCell:likeValue selected:isUserAlreadyLiked];
            
            return likeCell;
        }
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 1:{
            
            if (reviewArray.count == 0){
                return;
            }
            
            Review *review = [reviewArray objectAtIndex:indexPath.row];
            
            if ([review.user_id isEqualToString:[[ICDataManager sharedInstance] getUserId]]){
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    
                    // Cancel button tappped do nothing.
                    
                }]];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    NSLog(@"Show review editor");
                    
                    [self editReview:review];
                    
                }]];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    
                    [self deleteReview:review];
                    
                }]];
                
                [self presentViewController:actionSheet animated:YES completion:nil];
                
            }
        }
            break;
        default:
        case 0:{
            [tableView deselectRowAtIndexPath:indexPath animated:false];

            if (isUserAlreadyLiked == false && likeValue != -1){
            
                [[ICAppManager sharedInstance] likeProject:nil withIncubeeId:_incubee.incubeeId notifyTo:self forSelector:@selector(reloadLike:)];
            }
        }
        break;
    }
}



#pragma mark - ActionSheet Delegates -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    
    
}


#pragma mark - Private -

-(void)showMovie{
    
    if(_moviePlayer)
    {
        [_moviePlayer stop];
        
        [_moviePlayer.view removeFromSuperview];
        
        _moviePlayer = nil;
    }
    
    if(_incubee.video!=nil)
    {
        
        _detailsTextContainerView.backgroundColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#6D6D6D"];
        
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


-(void)customerDetailRetrived:(ICRequest*)inRequest{

    if(inRequest.error == nil)
    {
        [_reviewTableView reloadData];
    }
}

-(void)reviewSubmitted:(ICRequest*)inRequest{

    reviewEditorId = nil;
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
    
    NSDictionary *aReviewData = [inRequest.parsedResponse objectForKey:@"reviewData"];
    
    if (aReviewData && ![aReviewData isKindOfClass:[NSNull class]]){
    
        reviewDataDic = aReviewData;
    }
    
    [self showLoadingReview:NO];
    
    
    _starRatingView.rating = 4;

    likeValue = -1;

    [_reviewTableView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[ICAppManager sharedInstance] getAllLikedIncubee:nil notifyTo:self forSelector:@selector(didFetchAllLikes:)];
    });
    
    
    if(inRequest.error == nil)
    {
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
        
    }

}

- (void)didFetchAllLikes:(ICRequest*)inRequest{
    
    NSArray *array = [inRequest.parsedResponse objectForKey:@"incubeeList"];
    
    NSLog(@"incubeeLikedList : %@",array);
    
    if (array != nil && array.count > 0){
        likeValue = array.count;
        
        isUserAlreadyLiked = [array containsObject:self.incubee.incubeeId];
        
        [_reviewTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
    }
}

- (void)reloadLike:(ICRequest*)inRequest{
    
    likeValue = -1;
    
    [_reviewTableView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[ICAppManager sharedInstance] getAllLikedIncubee:nil notifyTo:self forSelector:@selector(didFetchAllLikes:)];
    });
    
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
        
    }];

}


-(void)deleteReview:(Review*)aReview{
    
    NSMutableDictionary *reviewDic = [[NSMutableDictionary alloc] init];
    
    [reviewDic setObject:aReview.review_id forKey:REVIEW_ID];
    
    [[ICAppManager sharedInstance] deleteReview:reviewDic withRequest:nil notifyTo:self forSelector:@selector(reviewSubmitted:)];    
    
}
-(void)editReview:(Review*)aReview{

    [self writeReviewHeaderTapped];
    
    reviewEditorId = aReview.review_id;
    
    _meetSegment.selectedSegmentIndex = -1;
    if ([aReview.meeting isEqualToString: @"PER" ]){
        _meetSegment.selectedSegmentIndex = 0;
        
    }
    else if ([aReview.meeting isEqualToString: @"PHO"]){
        _meetSegment.selectedSegmentIndex = 1;
    }
    
    if (_meetSegment.selectedSegmentIndex != -1){
        meetSelected = aReview.meeting;
    }
    
    _statusSegment.selectedSegmentIndex = -1;

    if ([aReview.status isEqualToString:@"INT"]){
        _statusSegment.selectedSegmentIndex = 0;
    }
    else if ([aReview.status isEqualToString:@"INV"]){
        _statusSegment.selectedSegmentIndex = 1;
    }else if ([aReview.status isEqualToString:@"PAS"]){
        _statusSegment.selectedSegmentIndex = 2;
    }

    if (_statusSegment.selectedSegmentIndex != -1){
        statusSelected = aReview.status;
    }

    
     _reviewTitle.text = aReview.reviewTitle;

    _commentsTextView.text = aReview.reviewDescription;

    _starRatingView.rating = aReview.rating.integerValue;
    
}


- (IBAction)cancelReviewTapped:(id)sender {
    
    reviewEditorId = nil;
    
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
    
    if (reviewEditorId != nil){
        
        [reviewDic setObject:reviewEditorId forKey:REVIEW_ID];
        
        [[ICAppManager sharedInstance] editReview:reviewDic withRequest:nil notifyTo:self forSelector:@selector(reviewSubmitted:)];
        
    }
    else {
        [[ICAppManager sharedInstance] submitReview:reviewDic withRequest:nil notifyTo:self forSelector:@selector(reviewSubmitted:)];
    }
    
    [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        
        _writeReviewView.transform = CGAffineTransformMakeTranslation(0, 800);

        
    } completion:^(BOOL finished) {
        
        _writeReviewView.transform = CGAffineTransformIdentity;

        _writeReviewView.hidden = YES;

    }];

    
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

#pragma mark - TextView -

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
    _commentsDoneButton.hidden = YES;
    
    _investorsProfileImageView.hidden = NO;
    
        _topItemContainer.hidden = NO;
    {
        _reviewContainerBottomConstraints.constant =  5.0f;
        
        _topConstrainOfContainer.constant = -40.0f;
        
        _reviewSectionTopConstrinat.constant = 190.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [_writeReviewView layoutIfNeeded];
            
        }];
    }
}

-(void)keyboardDidShow:(NSNotification*) notification
{
    _investorsProfileImageView.hidden = YES;
    
    _commentsDoneButton.hidden = NO;
    
    _topItemContainer.hidden = YES;
    
    NSInteger keyboardHeight = [self getKeyBoardHeight:notification];
    
    if(keyboardHeight!=0)
    {
        _topConstrainOfContainer.constant = -80.0f;
        
        _reviewContainerBottomConstraints.constant = keyboardHeight+5;
        
        _reviewSectionTopConstrinat.constant = 0.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [_writeReviewView layoutIfNeeded];
            
        }];
        
        
    }
    
}

#pragma mark - IBAction -
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

#pragma mark - ICImageManagerDelegate -
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

- (IBAction)commetnsDoneTapped:(id)sender {
    
    [self resignTextFirstResponders];
}
@end
