//
//  ICInvestorViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 12/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#include "ICIncubeeViewController.h"

#define ADHOC_INCUBEE_CELL_ID @"AdhocIncubeeCellId"

@interface ICAdhocIncubeeTbCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *adhocTitleLable;

@property (weak, nonatomic) IBOutlet UILabel *adhocEmailLable;

@property(nonatomic,strong)AdhocIncubee *adhocIncubee;

@end

@implementation ICAdhocIncubeeTbCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        return self;
    }
    
    return nil;
}

-(void)setAdhocIncubee:(AdhocIncubee *)adhocIncubee{

    _adhocIncubee = adhocIncubee;
    
    _adhocTitleLable.text = _adhocIncubee.adhocIncubeeName;
    
    _adhocEmailLable.text = _adhocIncubee.emailId;
    
}

@end


@interface ICInvestorTbCell : UITableViewCell

@property (strong, nonatomic) IBOutlet ICImageView *incubeeImage;
@property (strong, nonatomic) IBOutlet UILabel *incubeTitle;
@property (strong, nonatomic) IBOutlet UILabel *incubeeDesc;
@property(nonatomic,strong)Incubee *incubee;

@end

@implementation ICInvestorTbCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        return self;
    }
    
    return nil;
}

-(void)setIncubee:(Incubee *)incubee{

    _incubee = incubee;
    
    _incubeTitle.text = _incubee.companyName;
    
    [_incubeeDesc sizeToFit];
    
    _incubeeDesc.text = _incubee.highConcept;
    
    NSArray *imArray = [[ICDataManager sharedInstance] getImageURLs:_incubee.incubeeId];

    [_incubeeImage setImage:[UIImage imageNamed:@"LikeButton"]];
    
    if(imArray.count>=1)
    {
        NSString *urlString1 = ((IncubeeImage*)[imArray objectAtIndex:0]).imageUrl;
        
        ICImageManager *im1 = [[ICImageManager alloc] init];
        
        [_incubeeImage setImageUrl:urlString1];
        
        [im1 getImage:urlString1 withDelegate:self];
    }
}

-(void)imageDataRecived:(NSData*)inImageData ofURL:(NSString *)inUrl{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([_incubeeImage.imageUrl isEqualToString:inUrl])
        {
            _incubeeImage.image = [UIImage imageWithData:inImageData];
            
            _incubeeImage.layer.cornerRadius = _incubeeImage.bounds.size.width/2;
            
            _incubeeImage.layer.masksToBounds = YES;
            
        }
    });
    
}

@end

#import "ICInvestorViewController.h"

@interface ICInvestorViewController (){

    NSArray *incubeeList;
    
    NSArray *adhocIncubeeList;
    
    NSArray *searchIncubeeList;
    
    NSArray *searchAdhocIncubeeList;
    
    BOOL searchModeOn;
}


@end

@implementation ICInvestorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

//    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                             forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;

    
//    [self reloadDataRefreshUI];

    [[ICAppManager sharedInstance] getAllAdhocIncubees:nil notifyTo:self atSelector:@selector(getAllIncubeesRequest:)];
    
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.title = @"#DEV_Investors_Title";

    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.title = @"";

    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if([_adhocEmailTextFiled isFirstResponder] || [_adhocTitleTextField isFirstResponder] || [_adhocNameTextFiled isFirstResponder])
    {
        return;
    }
    else if([_commentReviewTextView isFirstResponder])
    {
    
        _adhocBottomConstraitns.constant =  0.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [self.view layoutIfNeeded];
            
        }];

    }
    else
    {
        _tableViewBottonConstraint.constant =  50.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [self.view layoutIfNeeded];
            
        }];
    }
}

-(void)keyboardDidShow:(NSNotification*) notification
{
    
    if([_adhocEmailTextFiled isFirstResponder] || [_adhocTitleTextField isFirstResponder] || [_adhocNameTextFiled isFirstResponder])
    {
        return;
    }
    else if([_commentReviewTextView isFirstResponder])
    {
    
        _adhocTopView.hidden = YES;
        
        NSInteger keyboardHeight = [self getKeyBoardHeight:notification];
        
        if(keyboardHeight!=0)
        {
            _adhocBottomConstraitns.constant = keyboardHeight-30.0f;
            
            [UIView animateWithDuration:0.25f animations:^{
                
                [self.view layoutIfNeeded];
                
            }];
            
            
        }
        
    }
    else
    {
    
    NSInteger keyboardHeight = [self getKeyBoardHeight:notification];
    
    if(keyboardHeight!=0)
    {
        _tableViewBottonConstraint.constant = keyboardHeight;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [self.view layoutIfNeeded];
            
        }];
        
        
    }
    }
    
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

-(BOOL)validateReviewSection{
    
    NSString *reviewError = nil;
    
    if(_commentReviewTextView.text.length<1)
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
    else if(_adhocTitleTextField.text.length<1){
    
        reviewError = @"Please input 'EmailId'";

    }
    else if([[ICUtilityManager sharedInstance] isValidEmail:_adhocEmailTextFiled.text]==NO)
    {
        reviewError = @"Email is not valid";
    }
    else if(_adhocTitleTextField.text.length<1)
    {
        reviewError = @"Please write 'Review Title'";
        
    }
    else if(_adhocNameTextFiled.text.length<1)
    {
        reviewError = @"Please write 'Name'";
        
    }
    
    if(reviewError == nil)
    {
        return  YES;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:reviewError delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    
    [alert show];
    
    return NO;
    
}

-(void)reloadDataRefreshUI{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        incubeeList = [[ICDataManager sharedInstance] getAllIncubees];
        
        adhocIncubeeList = [[ICDataManager sharedInstance] getAllAdhocIncubeeList];
        
        [_investorTableView reloadData];

});

}

-(void)searchAndReload{
    
    if(searchModeOn){
        NSString *searchText = _searchBar.text;
        
        if(searchText.length>0)
        {
            NSPredicate *searchPred = [NSPredicate predicateWithFormat:@"companyName CONTAINS [c]%@ OR founder CONTAINS [c]%@ OR highConcept CONTAINS [c]%@",searchText,searchText,searchText];
            
            searchIncubeeList = [incubeeList filteredArrayUsingPredicate:searchPred];
            
            NSLog(@"%@ & count %d",searchText,(int)searchIncubeeList.count);
            
            NSPredicate *searchAdhocPred = [NSPredicate predicateWithFormat:@"adhocIncubeeName CONTAINS [c]%@ OR emailId CONTAINS [c]%@",searchText,searchText];
            
            searchAdhocIncubeeList = [adhocIncubeeList filteredArrayUsingPredicate:searchAdhocPred];
    
        }
        else
        {
            searchIncubeeList = incubeeList;
            
            searchAdhocIncubeeList = adhocIncubeeList;
            
        }
        
        [_investorTableView reloadData];
    }
    else
    {
        [_investorTableView reloadData];
    }
    
}

-(void)resignAdHocResponders{
    
    _adhocTopView.hidden = NO;
    
    if([_adhocTitleTextField isFirstResponder])
    {
        [_adhocTitleTextField resignFirstResponder];
    }
    
    if([_adhocEmailTextFiled isFirstResponder])
    {
        [_adhocEmailTextFiled resignFirstResponder];
    }
    
    if([_commentReviewTextView isFirstResponder])
    {
        [_commentReviewTextView resignFirstResponder];
    }

}

-(void)resetAdhocInputView{

    _adhocTopView.hidden = NO;

    adhocTitle = nil;
    
    adhocEmail = nil;
    
    meetSelected = nil;
    
    statusSelected = nil;
    
    adhocComments = nil;
    
    _adhocTitleTextField.text = nil;
    
    _adhocNameTextFiled.text = nil;
    
    _adhocEmailTextFiled.text = nil;
    
    _commentReviewTextView.text = nil;
    
    _meetSegmentView.selectedSegmentIndex = -1;
    
    _statusSegmentView.selectedSegmentIndex = -1;
    
    
    _starRatingView.rating = -1;
    
    _adhocBottomConstraitns.constant =  0.0f;
    
    [UIView animateWithDuration:0.25f animations:^{
        
        [self.view layoutIfNeeded];
        
    }];


}


#pragma mark - UIScrollView -

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    [_searchBar resignFirstResponder];
//}

#pragma mark - UITableView -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(section==0){
        
        if(searchModeOn)
        {
            return searchIncubeeList.count;
        }
        else
        {
            return incubeeList.count;
        }
    }
    else
    {
        if(searchModeOn)
        {
            return searchAdhocIncubeeList.count;
        }
        else
        {
            return adhocIncubeeList.count;
        }
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        
        ICInvestorTbCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvestorCellId"];
        
        if(!cell)
        {
            cell = [[ICInvestorTbCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InvestorCellId"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        Incubee *aIncubee;
        
        if(searchModeOn)
        {
            aIncubee = [searchIncubeeList objectAtIndex:indexPath.row];
        }
        else
        {
            aIncubee = [incubeeList objectAtIndex:indexPath.row];
        }
        
        [cell setIncubee:aIncubee];
        
        return cell;
    }
    else
    {
        
        
        ICAdhocIncubeeTbCell *cell = [tableView dequeueReusableCellWithIdentifier:ADHOC_INCUBEE_CELL_ID];
        
        if(!cell)
        {
            cell = [[ICAdhocIncubeeTbCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ADHOC_INCUBEE_CELL_ID];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        AdhocIncubee *aAdhocIncubee;
        
        if(searchModeOn)
        {
            aAdhocIncubee = [searchAdhocIncubeeList objectAtIndex:indexPath.row];
        }
        else
        {
            aAdhocIncubee = [adhocIncubeeList objectAtIndex:indexPath.row];
        }
        
        [cell setAdhocIncubee:aAdhocIncubee];
        
        return cell;

        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
    Incubee *aIncubee;
    
    if(searchModeOn)
    {
        aIncubee = [searchIncubeeList objectAtIndex:indexPath.row];
    }
    else
    {
        aIncubee = [incubeeList objectAtIndex:indexPath.row];
    }
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"ICInvestorStoryboard" bundle:nil];
    
    ICIncubeeViewController *incubeeViewController = [st instantiateViewControllerWithIdentifier:@"ICIncubeeVCStoryboard"];
    
    incubeeViewController.incubee = aIncubee;

    [self.navigationController pushViewController:incubeeViewController animated:YES];
    }

}

#pragma mark - IBActions -

- (IBAction)statusValueChanged:(id)sender {
    
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
    
    [self resignAdHocResponders];
    
}

- (IBAction)meetValueChanged:(id)sender {
    
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
    
    [self resignAdHocResponders];
    
}


- (IBAction)inviteButtonTapped:(id)sender {
    
    UIAlertView *linkMediaAlert = [[UIAlertView alloc] initWithTitle:@"Invite a founder" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:INVITE,nil];
    
    linkMediaAlert.tag = ALERTTAG_INVITE_EMAIL;
    
    linkMediaAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    ((UITextField*)([linkMediaAlert textFieldAtIndex:0])).placeholder = @"Email address";
    
    ((UITextField*)([linkMediaAlert textFieldAtIndex:0])).delegate = self;
    
    [linkMediaAlert show];

}

- (IBAction)addButtonTapped:(id)sender {
    
    [self resetAdhocInputView];
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    _adhocView.transform = CGAffineTransformMakeTranslation(0, 800);
    
    _adhocView.hidden = NO;
    
    
    [UIView animateWithDuration:1.0f delay:0 usingSpringWithDamping:0.60 initialSpringVelocity:0.5 options:(UIViewAnimationOptionCurveEaseOut) animations:^{
        
        _adhocView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [_adhocNameTextFiled becomeFirstResponder];
    }];
    
    
}

#pragma mark - UIAlertView Delegates -
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == ALERTTAG_INVITE_EMAIL && buttonIndex == 1)
    {
        [[alertView textFieldAtIndex:0] resignFirstResponder];
        
        
        [[ICAppManager sharedInstance] inviteFounder:((UITextField*)[alertView textFieldAtIndex:0]).text withRequest:nil notifyTo:self forSelector:@selector(inviteFounderRequest:)];
        
    }
}


- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    if (alertView.alertViewStyle == UIAlertViewStylePlainTextInput)
    {
        if(alertView.tag == ALERTTAG_INVITE_EMAIL)
        {
            if([[[alertView textFieldAtIndex:0] text] length] > 0 && [[ICUtilityManager sharedInstance] isValidEmail:[[alertView textFieldAtIndex:0] text]] )
            {
                return YES;
            }
        }
    }
    
    return NO;
}

#pragma mark - UISearchBarDelegate -


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    searchModeOn = YES;
    
    searchBar.showsCancelButton = YES;
    
    [self searchAndReload];
    
    return YES;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{

    return YES;

}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{

    searchModeOn = NO;

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    [self searchAndReload];
}




- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    searchBar.showsCancelButton = YES;
    
    [_searchBar resignFirstResponder];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{

    searchBar.showsCancelButton = NO;

    _searchBar.text = nil;
    
    searchModeOn = NO;
    
    [_searchBar resignFirstResponder];
    
    [self searchAndReload];

}


#pragma mark - Network -
-(void)inviteFounderRequest:(ICRequest*)inRequest{

    if(inRequest.error == nil)
    {
        
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }
    
    

}

-(void)adhocIncubeeAddRequest:(ICRequest*)inRequest{

    if(inRequest.error == nil)
    {
        NSArray *resposeIncubeeList = [inRequest.parsedResponse objectForKey:@"incubeeList"];

        NSLog(@"resposeIncubeeList : %@",resposeIncubeeList);
        
        NSDictionary *adhocIncube = [resposeIncubeeList objectAtIndex:0];
        
        // On Success write Review
        
        NSMutableDictionary *reviewDic = [[NSMutableDictionary alloc] init];
        
        [reviewDic setObject:_adhocTitleTextField.text forKey:REVIEW_TITLE];
        [reviewDic setObject:_commentReviewTextView.text forKey:REVIEW_DESC];
        [reviewDic setObject:[adhocIncube valueForKey:@"id"] forKey:REVIEW_INCUBEE_ID];
        [reviewDic setObject:[NSNumber numberWithInt:(int)_starRatingView.rating] forKey:REVIEW_RATING];
        [reviewDic setObject:meetSelected forKey:REVIEW_MEETING];
        [reviewDic setObject:statusSelected forKey:REVIEW_STATUS];
        
        
        [[ICAppManager sharedInstance] submitReview:reviewDic withRequest:nil notifyTo:self forSelector:@selector(reviewSubmittedForCreatedAdhocIncubee:)];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }

}

-(void)getAllIncubeesRequest:(ICRequest*)inRequest{

    if(inRequest.error == nil)
    {
        
        [self reloadDataRefreshUI];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }


    
}


-(void)reviewSubmittedForCreatedAdhocIncubee:(ICRequest*)inRequest{

    if(inRequest.error == nil)
    {
        
        [[ICAppManager sharedInstance] getAllAdhocIncubees:nil notifyTo:self atSelector:@selector(getAllIncubeesRequest:)];

    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error : %ld",(long)inRequest.error.code] message:inRequest.error.localizedDescription delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alertView show];
    }
    
}

- (IBAction)adhocSubmitTapped:(id)sender {
    
    [self resignAdHocResponders];
    
    if(![self validateReviewSection])
    {
        return;
    }
    
    NSMutableDictionary *adhocIncubeeDic = [[NSMutableDictionary alloc] init];
    
    [adhocIncubeeDic setObject:_adhocNameTextFiled.text forKey:ADHOC_INCUBEE_NAME];
    [adhocIncubeeDic setObject:_adhocTitleTextField.text forKey:ADHOC_INCUBEE_TITLE];
    [adhocIncubeeDic setObject:_adhocEmailTextFiled.text forKey:ADHOC_INCUBEE_EMAIL];
    [adhocIncubeeDic setObject:meetSelected forKey:ADHOC_INCUBEE_MEETING];
    [adhocIncubeeDic setObject:statusSelected forKey:ADHOC_INCUBEE_STATUS];
    [adhocIncubeeDic setObject:[NSNumber numberWithInt:(int)_starRatingView.rating] forKey:ADHOC_INCUBEE_RATING];
    [adhocIncubeeDic setObject:_commentReviewTextView.text forKey:ADHOC_INCUBEE_DESC];
    
    
    [[ICAppManager sharedInstance] addAdhocInvubee:adhocIncubeeDic withRequest:nil notifyTo:self forSelector:@selector(adhocIncubeeAddRequest:)];
    
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    _adhocView.hidden = YES;
    
}

- (IBAction)adhocCancelTapped:(id)sender {
    
    
    if([_commentReviewTextView isFirstResponder])
    {
        
        _adhocBottomConstraitns.constant =  0.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [self.view layoutIfNeeded];
            
        }];
        
        [_commentReviewTextView resignFirstResponder];
        
    }

    _adhocView.hidden = YES;
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

#pragma mark - UITextField Delegate -


- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    if([_adhocTitleTextField isFirstResponder] || [_adhocEmailTextFiled isFirstResponder] || [_adhocNameTextFiled isFirstResponder])
    {
        [textField resignFirstResponder];
    
    }
    
    return YES;
}

@end
