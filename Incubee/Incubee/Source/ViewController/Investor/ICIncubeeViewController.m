//
//  ICIncubeeViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 19/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import "ICIncubeeViewController.h"

#define EMPTYREVIEWCELL @"EmptyReviewCell"

#define TEXT_INPUT_CELL_ID @"TextInputCellIdentifier"


@interface ICIncubeeViewController ()
{

    NSArray *reviewArray;
    
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
    
    
    _investorsProfileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _investorsProfileImageView.layer.borderWidth = 2.0f;
    
    _investorsProfileImageView.layer.cornerRadius = 50.0f;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.navigationController.navigationBarHidden = NO;
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
        
        headView.backgroundColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"];
        
        
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

            lab.textColor = [UIColor whiteColor];
            
            [headView addSubview:lab];
            
            return headView;
            
        }
        else
        {
            
            UILabel *ratingLab = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 70.0f, 70.0f)];
            
            ratingLab.text = @"4.7";
            
            ratingLab.textAlignment = NSTextAlignmentCenter;
            
            ratingLab.font = [UIFont fontWithName:@"Lato-bold" size:35.0f];
            
            [headView addSubview:ratingLab];
            
            UIImageView *rattingImView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 5.0f, tableView.frame.size.width - 120.f, 40.0f)];
            
            rattingImView.backgroundColor = [UIColor grayColor];
            
            [headView addSubview:rattingImView];
            
            UILabel *writeReviewLabl = [[UILabel alloc] initWithFrame:CGRectMake(100, 45.0f, tableView.frame.size.width - 120.f, 30.0f)];
            
            writeReviewLabl.text = @"Write you're review";
            
            writeReviewLabl.textAlignment = NSTextAlignmentCenter;
            
            writeReviewLabl.textColor = [UIColor whiteColor];
            
            [headView addSubview:writeReviewLabl];
            
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
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EMPTYREVIEWCELL];
        
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EMPTYREVIEWCELL];
            
        }
        
        [cell.textLabel setText:@"No reviews yet"];
    
    
    
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    return cell;
    
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

-(void)resetWriteReview{

    _reviewTitle.text = nil;
    
    _meetSegment.selectedSegmentIndex = 0;
    
    _statusSegment.selectedSegmentIndex = 0;
    
    
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




- (IBAction)cancelReviewTapped:(id)sender {
    
    
    [self resignTextFirstResponders];
    
    [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        
        _writeReviewView.transform = CGAffineTransformMakeTranslation(0, 800);
        
        
    } completion:^(BOOL finished) {
        
        _writeReviewView.transform = CGAffineTransformIdentity;
        
        _writeReviewView.hidden = YES;
        
    }];
}

- (IBAction)submitReviewTapped:(id)sender {

    [self resignTextFirstResponders];
    
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
    
    [self resignTextFirstResponders];
}

- (IBAction)statusSegValueChanged:(id)sender {
    
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
        
        
    });
    
}
@end
