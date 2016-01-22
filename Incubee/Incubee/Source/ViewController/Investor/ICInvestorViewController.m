//
//  ICInvestorViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 12/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#include "ICIncubeeViewController.h"

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
    
    _incubeeDesc.text = _incubee.highConcept;
    
    NSArray *imArray = [[ICDataManager sharedInstance] getImageURLs:_incubee.incubeeId];
    
    if(imArray.count>=1)
    {
        NSString *urlString1 = ((IncubeeImage*)[imArray objectAtIndex:0]).imageUrl;
        
        ICImageManager *im1 = [[ICImageManager alloc] init];
        
        [_incubeeImage setImageUrl:urlString1];
        
        [im1 getImage:urlString1 withDelegate:self];
    }
    else
    {
    
        _incubeeImage.image = nil;
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
    
    NSArray *searchIncubeeList;
    
    BOOL searchModeOn;
}


@end

@implementation ICInvestorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    
    [self reloadDataRefreshUI];
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
    {
        _tableViewBottonConstraint.constant =  50.0f;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            [self.view layoutIfNeeded];
            
        }];
    }
}

-(void)keyboardDidShow:(NSNotification*) notification
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Private -

-(void)reloadDataRefreshUI{

    incubeeList = [[ICDataManager sharedInstance] getAllIncubees];
    
    
}
#pragma mark - UIScrollView -

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    [_searchBar resignFirstResponder];
//}

#pragma mark - UITableView -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(searchModeOn)
    {
        return searchIncubeeList.count;
    }
    else
    {
        return incubeeList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ICInvestorTbCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvestorCellId"];
    
    if(!cell)
    {
        cell = [[ICInvestorTbCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InvestorCellId"];
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

#pragma mark - IBActions -

- (IBAction)inviteButtonTapped:(id)sender {
    
    UIAlertView *linkMediaAlert = [[UIAlertView alloc] initWithTitle:@"Invite a founder" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:INVITE,nil];
    
    linkMediaAlert.tag = ALERTTAG_INVITE_EMAIL;
    
    linkMediaAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    ((UITextField*)([linkMediaAlert textFieldAtIndex:0])).placeholder = @"Email address";
    
    ((UITextField*)([linkMediaAlert textFieldAtIndex:0])).delegate = self;
    
    [linkMediaAlert show];

}

#pragma mark - UIAlertView Delegates -
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == ALERTTAG_INVITE_EMAIL && buttonIndex == 1)
    {
        [[alertView textFieldAtIndex:0] resignFirstResponder];
        
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


-(void)searchAndReload{

    if(searchModeOn){
    NSString *searchText = _searchBar.text;
    
    if(searchText.length>0)
    {
        NSPredicate *searchPred = [NSPredicate predicateWithFormat:@"companyName CONTAINS [c]%@ OR founder CONTAINS [c]%@ OR highConcept CONTAINS [c]%@",searchText,searchText,searchText];
        
        searchIncubeeList = [incubeeList filteredArrayUsingPredicate:searchPred];
        
        NSLog(@"%@ & count %d",searchText,(int)searchIncubeeList.count);
        
    }
    else
    {
        searchIncubeeList = incubeeList;
        
    }
    
    [_investorTableView reloadData];
    }
    else
    {
        [_investorTableView reloadData];
    }
    
}

@end
