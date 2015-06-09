//
//  FirstViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 23/05/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "HomeViewController.h"
#import "ICImageManager.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"intialData" ofType:@"plist"];
    
    _projectList = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    NSLog(@"%@",_projectList);
    
    [self showCardA:[_projectList objectAtIndex:0]];
    
    
    _cardA.layer.borderColor = [UIColor grayColor].CGColor;
    _cardA.layer.borderWidth = 2.0f;
    _cardA.layer.cornerRadius = 5.0f;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showCardA:(NSDictionary*)inCard{

    _caedAtitleLable.text = [inCard valueForKey:@"ProjectName"];
    
    _cardADesc.text = [inCard valueForKey:@"ProjectTeam"];
    
    [self setupMediaFor:inCard];
    
}

-(void)setupMediaFor:(NSDictionary*)inCard{
    
    if([[inCard valueForKey:@"MediaType"] isEqualToString:@"Image"])
    {
        _mediaImageView.hidden = NO;
        _mediaMoviePlayerView.hidden = YES;
        {
            
            NSData *imageData =[[ICImageManager sharedInstance] getImage:[inCard valueForKey:@"MediaURL"]];
            
            if (imageData)
            {
                _mediaImageView.image = [UIImage imageWithData:imageData];
                
                _cardAactivityIndicator.hidden = YES;
                
                [_cardAactivityIndicator stopAnimating];

            }
            else
            {
                _mediaImageView.image = nil;
                
                _cardAactivityIndicator.hidden = NO;
                
                [_cardAactivityIndicator startAnimating];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    
                    NSString *urlString = [inCard valueForKey:@"MediaURL"];
                    
//                    NSData *downloadedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
                    
                    NSError *error = nil;
                    
                    NSData* downloadedData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString] options:NSDataReadingUncached error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                    
                        _cardAactivityIndicator.hidden = YES;
                        
                        [_cardAactivityIndicator stopAnimating];

                    if (error)
                    {
                        NSLog(@"%@", [error localizedDescription]);
                    }
                    else
                    {
                        if (downloadedData) {
                            
                            [[ICImageManager sharedInstance] setData:downloadedData withKey:urlString];
                            
                                _mediaImageView.image = [UIImage imageWithData:downloadedData];
    
                        }
                    }
                    
                    });
                });
            }
        }
        
        
        
    }
    else if([[inCard valueForKey:@"MediaType"] isEqualToString:@"Video"])
    {
        _mediaImageView.hidden = YES;
        _mediaMoviePlayerView.hidden = NO;
    }
    
}

- (IBAction)nextCardTapped:(id)sender {
    
    int r = arc4random_uniform((int)(_projectList.count));

    [self showCardA:[_projectList objectAtIndex:r]];
    
}
@end
