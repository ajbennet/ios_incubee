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
}


@end

@implementation ICInvestorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.navigationController.navigationBarHidden = YES;
    [self reloadDataRefreshUI];
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.title = @"#DEV_Investors_Title";

}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.title = @"";

    
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

-(void)reloadDataRefreshUI{

    incubeeList = [[ICDataManager sharedInstance] getAllIncubees];
    
    
}

#pragma mark - UITableView -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return incubeeList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ICInvestorTbCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvestorCellId"];
    
    if(!cell)
    {
        cell = [[ICInvestorTbCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InvestorCellId"];
        
    }
    
    Incubee *aIncubee = [incubeeList objectAtIndex:indexPath.row];
    
    [cell setIncubee:aIncubee];

    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    UIStoryboard *st = [UIStoryboard storyboardWithName:@"ICInvestorStoryboard" bundle:nil];
    
    ICIncubeeViewController *incubeeViewController = [st instantiateViewControllerWithIdentifier:@"ICIncubeeVCStoryboard"];
    
    incubeeViewController.incubee = [incubeeList objectAtIndex:indexPath.row];

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

@end
