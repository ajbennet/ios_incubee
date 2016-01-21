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
    
    self.title = _incubee.companyName;
    
    _titleLable.text = _incubee.companyName;
    
    _highConceptLbl.text = _incubee.highConcept;
    
    _compnayLable.text = _incubee.founder;
    
    [_reviewTableView reloadData];
    
    
    _investorsProfileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _investorsProfileImageView.layer.borderWidth = 2.0f;
    
    _investorsProfileImageView.layer.cornerRadius = 50.0f;
    
    NSArray *imArray = [[ICDataManager sharedInstance] getImageURLs:_incubee.incubeeId];

    if(imArray.count>=1)
    {
        NSString *urlString1 = ((IncubeeImage*)[imArray objectAtIndex:0]).imageUrl;
        
        ICImageManager *im1 = [[ICImageManager alloc] init];
        
        [_bannerImageView setImageUrl:urlString1];
        
        [im1 getImage:urlString1 withDelegate:self];
    }
    else
    {
        
        _bannerImageView.image = nil;
    }

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
-(void)imageDataRecived:(NSData*)inImageData ofURL:(NSString *)inUrl{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([_bannerImageView.imageUrl isEqualToString:inUrl])
        {
            _bannerImageView.image = [UIImage imageWithData:inImageData];
        }
    });
    
}


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
            
            lab.text = @"Be the first person review it";
            
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

#pragma mark - Review -

-(void)writeReviewHeaderTapped{

    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    _writeReviewView.hidden = NO;

}




- (IBAction)cancelReviewTapped:(id)sender {
    
    _writeReviewView.hidden = YES;
}

- (IBAction)submitReviewTapped:(id)sender {
    
        _writeReviewView.hidden = YES;
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
    {
        _reviewContainerBottomConstraints.constant =  5.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [_writeReviewView layoutIfNeeded];
            
        }];
    }
}

-(void)keyboardDidShow:(NSNotification*) notification
{
    NSInteger keyboardHeight = [self getKeyBoardHeight:notification];
    
    if(keyboardHeight!=0)
    {
        _reviewContainerBottomConstraints.constant = keyboardHeight;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [_writeReviewView layoutIfNeeded];
            
        }];
        
        
    }
    
}
@end
