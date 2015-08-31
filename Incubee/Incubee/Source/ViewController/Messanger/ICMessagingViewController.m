//
//  MessagingTableViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 23/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICMessagingViewController.h"
#import "ICDataManager.h"
#import "ICImageManager.h"
#import "ICImageManager.h"
#import "ICUtilityManager.h"
#import "ICChatViewController.h"

#define PROJECT_TABLEVIEW_CELL @"ProjectTableViewCellIdentifier"

@interface ProjectTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *projectDescLable;

@property (strong, nonatomic) IBOutlet UILabel *projectTitleLable;

@property (strong, nonatomic) IBOutlet ICImageView *projectImageView;

@property(nonatomic,strong)Project *project;

@end

@implementation ProjectTableViewCell

-(id)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
    
        return self;
    }
    
    return nil;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        return self;
    }
    
    return nil;
}

-(void)setProject:(Project *)project{

    _project = project;
    
    _projectTitleLable.text = _project.companyName;

    _projectDescLable.text = _project.high_concept;
    
    NSArray *imArray = [[ICDataManager sharedInstance] getImageURLs:_project.projectId];
    
    if(imArray.count>=1)
    {
        NSString *urlString1 = ((ProjectImage*)[imArray objectAtIndex:0]).imageUrl;
        
        ICImageManager *im1 = [[ICImageManager alloc] init];
        
        [_projectImageView setImageUrl:urlString1];
        
        [im1 getImage:urlString1 withDelegate:self];
    }
    
}

-(void)imageDataRecived:(NSData*)inImageData ofURL:(NSString *)inUrl{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([_projectImageView.imageUrl isEqualToString:inUrl])
        {
            _projectImageView.image = [UIImage imageWithData:inImageData];

            _projectImageView.layer.cornerRadius = _projectImageView.bounds.size.width/2;
            
            _projectImageView.layer.masksToBounds = YES;

            
        }
    });
                   
}
@end



@interface ICMessagingViewController ()

@end

@implementation ICMessagingViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self loadAndRefreshUI];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [self setupSegment];
    
    [self loadAndRefreshUI];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _projectArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PROJECT_TABLEVIEW_CELL forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PROJECT_TABLEVIEW_CELL];
    }
    
    [cell setProject:[_projectArray objectAtIndex:indexPath.row]];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Project *pr = [_projectArray objectAtIndex:indexPath.row];
    
    NSLog(@"%@",pr);
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ICChatViewController *aChatViewController = [sb instantiateViewControllerWithIdentifier:@"ChatViewControllerStoryBoard"];
    
    aChatViewController.project = pr;
    
    [self.navigationController pushViewController:aChatViewController animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Project Array -

-(void)setupSegment{

    if([[ICDataManager sharedInstance] isFounder])
    {

    }
    else
    {

    }
}
-(void)loadAndRefreshUI{
    
    switch (_segmentBar.selectedSegmentIndex) {
        case 0:
            _projectArray = [[NSMutableArray alloc] initWithArray:[[ICDataManager sharedInstance] getFollowedProjects]];

            break;
            
            case 1:
            _projectArray = nil;
            break;
            
        case 2:
            
            _projectArray = nil;
            break;
            
        default:
            break;
    }
    
    [_projectTableView reloadData];

}

- (IBAction)segmentBarValueChanged:(id)sender {
    
    [self loadAndRefreshUI];
}
@end
