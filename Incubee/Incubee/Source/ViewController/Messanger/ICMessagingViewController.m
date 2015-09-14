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
#import "ICConstants.h"

#define PROJECT_TABLEVIEW_CELL @"ProjectTableViewCellIdentifier"

@interface ProjectTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *projectDescLable;

@property (strong, nonatomic) IBOutlet UILabel *projectTitleLable;

@property (strong, nonatomic) IBOutlet ICImageView *projectImageView;

@property(nonatomic,strong)Incubee *incubee;

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

-(void)setIncubee:(Incubee *)incubee{

    _incubee = incubee;
    
    _projectTitleLable.text = _incubee.companyName;

    _projectDescLable.text = _incubee.highConcept;
    
    NSArray *imArray = [[ICDataManager sharedInstance] getImageURLs:_incubee.incubeeId];
    
    if(imArray.count>=1)
    {
        NSString *urlString1 = ((IncubeeImage*)[imArray objectAtIndex:0]).imageUrl;
        
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messgesSync) name:CHAT_VIEW_REFRESH object:nil];
    
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
    
    
    if([[ICDataManager sharedInstance] isFounder])
    {
        
        switch (_segmentController.selectedSegmentIndex) {
            case 0:
            {
            
                ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PROJECT_TABLEVIEW_CELL forIndexPath:indexPath];
                
                if(cell == nil)
                {
                    cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PROJECT_TABLEVIEW_CELL];
                }
                
                [cell setIncubee:[_projectArray objectAtIndex:indexPath.row]];
                
                // Configure the cell...
                
                return cell;

            }
                break;
                
            case 1:
            {
                Customer *aCust = [_projectArray objectAtIndex:indexPath.row];
                
                UITableViewCell *c = [tableView dequeueReusableCellWithIdentifier:@"CustomerCell"];
                
                if(c==nil)
                {
                    c = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomerCell"];
                    
                }
                
                c.textLabel.text = aCust.userId;
                
                return c;
            }
                break;
                
            default:
                break;
        }
        
    }
    else
    {
        {
            
            ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PROJECT_TABLEVIEW_CELL forIndexPath:indexPath];
            
            if(cell == nil)
            {
                cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PROJECT_TABLEVIEW_CELL];
            }
            
            [cell setIncubee:[_projectArray objectAtIndex:indexPath.row]];
            
            // Configure the cell...
            
            return cell;
            
        }
    }
    
    return nil;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Incubee *tIncubee = [_projectArray objectAtIndex:indexPath.row];
    
    NSLog(@"%@",tIncubee);
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ICChatViewController *aChatViewController = [sb instantiateViewControllerWithIdentifier:@"ChatViewControllerStoryBoard"];
    
    NSString *toChat;
    
    BOOL toCustomer;

    if([[ICDataManager sharedInstance] isFounder])
    {
        
        switch (_segmentController.selectedSegmentIndex) {
            case 0:
            {
                Incubee *prIncubee =  [_projectArray objectAtIndex:indexPath.row];
                
                toChat = prIncubee.incubeeId;
                
                toCustomer = YES;
                
                aChatViewController.chatMode = CHAT_VIEW_CUSTOMER_TO_FOUNDER ;
                
            }
                break;
                
            case 1:
            {
                Customer *aCust = [_projectArray objectAtIndex:indexPath.row];

                toChat = aCust.userId;

                toCustomer = NO;
                
                aChatViewController.chatMode = CHAT_VIEW_FOUNDER_TO_CUSTOMER ;
            }
                break;
                
            default:
                break;
        }
        
    }
    else
    {
        {
            
            Incubee *prIncubee =  [_projectArray objectAtIndex:indexPath.row];
            
            toChat = prIncubee.incubeeId;
            
            aChatViewController.chatMode = CHAT_VIEW_CUSTOMER_TO_FOUNDER;
            
            toCustomer = YES;
            
        }
    }
    
    aChatViewController.isCustomer = toCustomer;
    
    aChatViewController.to = toChat;
    
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
        _savedProjectLable.hidden = YES;
        
        _segmentController.hidden = NO;
        
        _segmentController.selectedSegmentIndex = 1;
        
    }
    else
    {
        
        _savedProjectLable.layer.borderWidth = 1.0f;
        
        _savedProjectLable.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"].CGColor;
        
        _savedProjectLable.layer.cornerRadius = 5.0f;

        
        _savedProjectLable.hidden = NO;
        
        _segmentController.hidden = YES;
    }
    
}
-(void)loadAndRefreshUI{
    
    if([[ICDataManager sharedInstance] isFounder])
    {
        
        switch (_segmentController.selectedSegmentIndex) {
            case 0:
                
                _projectArray = [[NSMutableArray alloc] initWithArray:[[ICDataManager sharedInstance] getFollowedProjects]];
                
                break;
                
            case 1:
                
                _projectArray = [[NSMutableArray alloc] initWithArray:[[ICDataManager sharedInstance] getAllCustomer]];
                
                break;
                
            default:
                break;
        }
        
    }
    else
    {
        _projectArray = [[NSMutableArray alloc] initWithArray:[[ICDataManager sharedInstance] getFollowedProjects]];
    }
    
    [_projectTableView reloadData];

}

- (IBAction)segmentBarValueChanged:(id)sender {
    
    [self loadAndRefreshUI];
}

-(void)messgesSync{
    
    [self loadAndRefreshUI];
    
}

@end
