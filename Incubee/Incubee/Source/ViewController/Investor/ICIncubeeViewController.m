//
//  ICIncubeeViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 19/01/16.
//  Copyright © 2016 Incubee. All rights reserved.
//

#import "ICIncubeeViewController.h"

#define EMPTYREVIEWCELL @"EmptyReviewCell"

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
    
    
    reviewArray = [[NSArray alloc]initWithObjects:@"Title",@"Rating",@"Meet",@"Status",@"Comments",nil];
    
    
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
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _reviewTableView.frame.size.width, 80.0f)];
    
    lab.textAlignment = NSTextAlignmentCenter;
    
    lab.text = @"Be the first person review it";
    
    lab.textColor = [UIColor whiteColor];
    
    [headView addSubview:lab];
    
    
    UIButton *aWriteReviewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [aWriteReviewButton addTarget:self action:@selector(writeReviewHeaderTapped) forControlEvents:UIControlEventTouchUpInside];
    
    aWriteReviewButton.frame = CGRectMake(0, 0, _reviewTableView.frame.size.width, 80.0f);
    
    [headView addSubview:aWriteReviewButton];

    return headView;
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
    
    if(tableView == _reviewTableView)
    {
        return 1;
    }
    else
    {
        return reviewArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EMPTYREVIEWCELL];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EMPTYREVIEWCELL];
        
    }
    
    if(tableView == _reviewTableView)
    {
        [cell.textLabel setText:@"No reviews yet"];
    }
    else
    {
        [cell.textLabel setText:[reviewArray objectAtIndex:indexPath.row]];
    }
    
    
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
@end
