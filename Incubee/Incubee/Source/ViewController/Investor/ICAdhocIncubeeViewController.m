//
//  ICAdhocIncubeeViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 09/02/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import "ICAdhocIncubeeViewController.h"

#import "ICReviewTableViewCell.h"
#import "ICRatingProgressView.h"

#define REVIEWCELLID @"ReviewCellId"

@interface ICAdhocIncubeeViewController ()
{

    NSArray *reviewArray;

    NSDictionary *reviewDataDic;
    
    NSString *meetSelected;
    
    NSString *statusSelected;


}
@end

@implementation ICAdhocIncubeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _adhocIncubee.adhocIncubeeName;
    
    _emailIdLable.text = _adhocIncubee.emailId;
    
    [self showLoadingReview:YES];

    [[ICAppManager sharedInstance] getReview:_adhocIncubee.adhocIncubeeId withRequest:nil notifyTo:self forSelector:@selector(reviewLoaded:)];

    _investorsProfileImageView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#6D6D6D"].CGColor;
    
    _investorsProfileImageView.layer.borderWidth = 2.0f;
    
    _investorsProfileImageView.layer.cornerRadius = 40.0f;
    
    
    ICImageManager *im1 = [[ICImageManager alloc] init];
    
    [_investorsProfileImageView setImageUrl:[[ICDataManager sharedInstance] getUserProfilePic]];
    
    [im1 getImage:[[ICDataManager sharedInstance] getUserProfilePic] withDelegate:self];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
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

#pragma mark - Private -
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



-(void)resetWriteReview{
    
    meetSelected = nil;
    
    statusSelected = nil;
    
    _reviewTitle.text = nil;
    
    _commentsTextView.text = nil;
    
    _starRatingView.rating = -1;
    
    _meetSegment.selectedSegmentIndex = -1;
    
    _statusSegment.selectedSegmentIndex = -1;
    
}

-(void)writeAdhocReviewHeaderTapped{
    
        [self resetWriteReview];
        
        NSLog(@"%@",NSStringFromSelector(_cmd));
        
        _writeReviewView.transform = CGAffineTransformMakeTranslation(0, 800);
        
        _writeReviewView.hidden = NO;
        
        
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            
            _writeReviewView.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
}

- (void)reviewLoaded:(ICRequest*)inRequest{
    
    [self showLoadingReview:NO];

    if(inRequest.error == nil)
    {
        reviewArray = [[ICDataManager sharedInstance] getReviewArray:_adhocIncubee.adhocIncubeeId];
        
        reviewDataDic = [inRequest.parsedResponse objectForKey:@"reviewData"];
        
        [_adhocTableView reloadData];

    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
        
    }
    
    
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

#pragma mark - UITableView -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 80.0f;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if(tableView == _adhocTableView)
    {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _adhocTableView.frame.size.width, 100.0f)];
        
        headView.backgroundColor = [UIColor whiteColor];;
        
        UIButton *aWriteReviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [aWriteReviewButton addTarget:self action:@selector(writeAdhocReviewHeaderTapped) forControlEvents:UIControlEventTouchUpInside];
        
        aWriteReviewButton.frame = CGRectMake(0, 0, _adhocTableView.frame.size.width, 80.0f);
        
        [headView addSubview:aWriteReviewButton];
        
        if(reviewArray.count==0)
        {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _adhocTableView.frame.size.width, 80.0f)];
            
            lab.textAlignment = NSTextAlignmentCenter;
            
            lab.text = [NSString stringWithFormat:@"Be the first person to review\n %@",_adhocIncubee.adhocIncubeeName];
            
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
            
            if([[ICDataManager sharedInstance] isReviewWritten:_adhocIncubee.adhocIncubeeId]==NO)
            {
                
                allRatingView.frame =   CGRectMake(200.0f,15,tableView.frame.size.width-210.0f , 20);
                
                
                aWriteReviewButton.userInteractionEnabled = YES;
                
                UILabel *writeReviewLabl = [[UILabel alloc] initWithFrame:CGRectMake(5,50.0f, tableView.frame.size.width - 10.f, 40.0f)];
                
                writeReviewLabl.text = [NSString stringWithFormat:@"Write you're review on %@",_adhocIncubee.adhocIncubeeName];
                
                writeReviewLabl.font = [UIFont fontWithName:@"Lato-bold" size:10.0f];
                
                writeReviewLabl.textAlignment = NSTextAlignmentCenter;
                
                writeReviewLabl.numberOfLines = 0;
                
                writeReviewLabl.textColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#6D6D6D"];
                
                [headView addSubview:writeReviewLabl];
                
            }
            else
            {
                
                aWriteReviewButton.userInteractionEnabled = NO;
                
                allRatingView.frame =   CGRectMake(200.0f,15,tableView.frame.size.width-210.0f , 30);
            }
            
            
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyReviewCell"];
        
        if(!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmptyReviewCell"];
            
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
//            [[ICAppManager sharedInstance] getCustomerDetails:review.user_id withRequest:nil notifyTo:self forSelector:@selector(customerDetailRetrived:)];
            
        }
    
        
        return cell;
    
    }
    
    
    
}

#pragma mark - IBAction -

- (IBAction)cancelReviewTapped:(id)sender{

    {
        
        
        [self resignTextFirstResponders];
        
        [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
            
            _writeReviewView.transform = CGAffineTransformMakeTranslation(0, 800);
            
            
        } completion:^(BOOL finished) {
            
            _writeReviewView.transform = CGAffineTransformIdentity;
            
            _writeReviewView.hidden = YES;
            
        }];
    }
}

- (IBAction)submitReviewTapped:(id)sender{
    
    [self resignTextFirstResponders];
    
    if([self validateReviewSection]==NO)
    {
        return;
    }
    
    NSMutableDictionary *reviewDic = [[NSMutableDictionary alloc] init];
    
    [reviewDic setObject:_reviewTitle.text forKey:REVIEW_TITLE];
    [reviewDic setObject:_commentsTextView.text forKey:REVIEW_DESC];
    [reviewDic setObject:_adhocIncubee.adhocIncubeeId forKey:REVIEW_INCUBEE_ID];
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

-(void)reviewSubmitted:(ICRequest*)inRequest{
    
    if(inRequest.error == nil)
    {
        
        [[ICAppManager sharedInstance] getReview:_adhocIncubee.adhocIncubeeId withRequest:nil notifyTo:self forSelector:@selector(reviewLoaded:)];
        
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }
    
}



#pragma mark - TextView -

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}



#pragma mark - ICImageManagerDelegate -

-(void)imageDataRecived:(NSData*)inImageData ofURL:(NSString *)inUrl{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
         if([_investorsProfileImageView.imageUrl isEqualToString:inUrl]){
            
            _investorsProfileImageView.image = [UIImage imageWithData:inImageData];
            
        }
        
    });
    
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
    {
        _investorsProfileImageView.hidden = NO;
        
        _commetsDoneButton.hidden = YES;
    }
    
    _topItemContainer.hidden = NO;
    {
        _reviewContainerBottomConstraints.constant =  0.0f;
        
        _reviewSectionTopConstraint.constant = 185.0f;
        
        _containerTopSpace.constant = -40.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [_containerView layoutIfNeeded];
            
            [_writeReviewView layoutIfNeeded];
            
        }];
    }
}

-(void)keyboardDidShow:(NSNotification*) notification
{
   
    _commetsDoneButton.hidden = NO;
    
    _topItemContainer.hidden = YES;
    
    _investorsProfileImageView.hidden = YES;
    
    NSInteger keyboardHeight = [self getKeyBoardHeight:notification];
    
    if(keyboardHeight!=0)
    {
        _reviewContainerBottomConstraints.constant = keyboardHeight;
        
        _reviewSectionTopConstraint.constant = 0;
        
        _containerTopSpace.constant = -80.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [_containerView layoutIfNeeded];
            
            [_writeReviewView layoutIfNeeded];
            
        }];
        
        
    }
    
}


- (IBAction)commetsDoneTaped:(id)sender {
    
    [self resignTextFirstResponders];
}
@end
