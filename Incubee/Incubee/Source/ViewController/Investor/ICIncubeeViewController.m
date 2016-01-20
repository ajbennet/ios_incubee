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
        [cell.textLabel setText:@"Write a review"];
    }
    else
    {
        [cell.textLabel setText:[reviewArray objectAtIndex:indexPath.row]];
    }
    
    
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView == _reviewTableView)
    {
        _writeReviewView.hidden = NO;
    }
    
}

- (IBAction)cancelReviewTapped:(id)sender {
    
    _writeReviewView.hidden = YES;
}

- (IBAction)submitReviewTapped:(id)sender {
    
        _writeReviewView.hidden = YES;
}
@end
