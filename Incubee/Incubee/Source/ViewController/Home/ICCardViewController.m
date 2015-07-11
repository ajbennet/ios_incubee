//
//  ICCardViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 23/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICCardViewController.h"
#import "ICUtilityManager.h"


#define SWIPE_MOVE 100.0f

@implementation ICImageView


@end

@interface ICCardViewController ()

@end

@implementation ICCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPanGestureRecognizer *gestureRecognizerA = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragging:)];
    
    [_cardView addGestureRecognizer:gestureRecognizerA];

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

#pragma mark - Social Media Stuff -

- (IBAction)twitterTapped:(id)sender {
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [self shareToTapped:nil];
}

- (IBAction)shareToTapped:(id)sender {
    
    NSArray * activityItems = @[[NSString stringWithFormat:@"This is Awesome Project."], [NSURL URLWithString:_project.companyUrl],[NSURL URLWithString:[_project valueForKey:@"twitter_url"]]];
    NSArray * applicationActivities =nil;
    NSArray * excludeActivities = @[UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage,
                                    UIActivityTypeMail,
                                    UIActivityTypePrint,
                                    UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact,
                                    UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,
                                    UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeAirDrop
                                    ];
    
    UIActivityViewController * activityController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    activityController.excludedActivityTypes = excludeActivities;
    
    [self presentViewController:activityController animated:YES completion:nil];
    
}

- (IBAction)facebookTapped:(id)sender{

    [self shareToTapped:nil];
    
}

#pragma mark - Dragging Animation -

-(void)dragging:(UIPanGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        _panCoord = [gesture locationInView:self.view];
        
        _originalFrame = _cardView.frame;
        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint newCoord = [gesture locationInView:self.view];
        
        float dX = newCoord.x-_panCoord.x;
        
        if(dX > SWIPE_MOVE)
        {
            [_delegate followCurrentProject:dX];
        }
        else if( dX < (-(SWIPE_MOVE)))
        {
            [_delegate dontFollowCurrentProject:dX];
        }
        else
        {
            _cardView.transform = CGAffineTransformIdentity;
            
            _cardSelectStatusImage.alpha = 0.0f;
            
            _cardView.layer.borderColor = [UIColor clearColor].CGColor;
            
            _cardView.layer.borderWidth = 0.0f;

        }
    }
    else if(gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint newCoord = [gesture locationInView:self.view];
        
        float dX = newCoord.x-_panCoord.x;
        
        float dY = newCoord.y-_panCoord.y;
        
        if(dX > 0)
        {
            _cardSelectStatusImage.image = [UIImage imageNamed:@"LikeButton"];
            
            _cardView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#07947A"].CGColor;
            
            _cardView.layer.borderWidth = 4.0f;

        }
        else if( dX < 0)
        {
            _cardSelectStatusImage.image = [UIImage imageNamed:@"DislikeButton"];
            
            _cardView.layer.borderColor = [[ICUtilityManager sharedInstance] getColorFromRGB:@"#FB7575"].CGColor;
            
            _cardView.layer.borderWidth = 4.0f;

        }
        else if(dX == 0)
        {
            _cardView.layer.borderColor = [UIColor clearColor].CGColor;
            
            _cardView.layer.borderWidth = 0.0f;

        }
        
        
        CGAffineTransform t = CGAffineTransformMakeTranslation(dX, dY);
        
        [UIView animateKeyframesWithDuration:0.05 delay:0.05 options:UIViewKeyframeAnimationOptionAllowUserInteraction
                                  animations:^{
                                      
                                      _cardView.transform = t;
                                      
                                      _cardSelectStatusImage.alpha = (fabs(dX)/SWIPE_MOVE);
                                      
                                  } completion:^(BOOL finished) {
                                      
                                  }];
    }
}


#pragma mark - Project Utility methods -

-(void)showProject{
    
    [_delegate updateCurrentProjDescLable];
    
    [self showMovie];

}


-(void)showMovie{
    
    if(_moviePlayer)
    {
        [_moviePlayer stop];
        
        [_moviePlayer.view removeFromSuperview];
        
        _moviePlayer = nil;
    }
    
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_project.video]];
    
    _moviePlayer.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_moviePlayerView addSubview:_moviePlayer.view];

    
    NSLayoutConstraint *width =[NSLayoutConstraint
                                constraintWithItem:_moviePlayer.view
                                attribute:NSLayoutAttributeWidth
                                relatedBy:0
                                toItem:_moviePlayerView
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0];
    
    NSLayoutConstraint *height =[NSLayoutConstraint
                                 constraintWithItem:_moviePlayer.view
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:0
                                 toItem:_moviePlayerView
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:1.0
                                 constant:0];
    
    [_moviePlayerView addConstraint:width];
    
    [_moviePlayerView addConstraint:height];
    
    _moviePlayer.controlStyle =  MPMovieControlStyleEmbedded;
    
    _moviePlayer.shouldAutoplay = NO;
    
    _moviePlayer.repeatMode = NO;
    
    _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    
    [_moviePlayer setFullscreen:NO animated:NO];
    
    [_moviePlayer prepareToPlay];
    
    [_moviePlayer.view setBackgroundColor:[UIColor clearColor]];
    
    [_moviePlayerView bringSubviewToFront:_moviePlayer.view];
    
    [_moviePlayer pause];

}

-(void)dismissShowing{

    [_moviePlayer stop];
    
    [_moviePlayer.view removeFromSuperview];
    
    _moviePlayer = nil;

}

- (void)setProject:(Project *)project{

    _project = project;
    
    _projectTitleLable.text = _project.companyName;
    
    _projectOwnerLable.text = _project.founder;
    
    NSArray *imArray = [[ICDataManager sharedInstance] getImageURLs:_project.projectId];
    
    NSString *urlString1 = ((ProjectImage*)[imArray objectAtIndex:0]).imageUrl;
    
    NSString *urlString2 = ((ProjectImage*)[imArray objectAtIndex:1]).imageUrl;
    
    NSString *urlString3 = ((ProjectImage*)[imArray objectAtIndex:2]).imageUrl;
    
    NSString *urlString4 = ((ProjectImage*)[imArray objectAtIndex:3]).imageUrl;
    
    
    ICImageManager *im1 = [[ICImageManager alloc] init];
    
    [_topLeftImageView setImageUrl:urlString1];

    [im1 getImage:urlString1 withDelegate:self];
    
    
    ICImageManager *im2 = [[ICImageManager alloc] init];
    
    [_topRightImageView setImageUrl:urlString2];

    [im2 getImage:urlString2 withDelegate:self];

    
    ICImageManager *im3 = [[ICImageManager alloc] init];
    
    [_bottomLeftImageView setImageUrl:urlString3];
    
    [im3 getImage:urlString3 withDelegate:self];


    ICImageManager *im4 = [[ICImageManager alloc] init];
    
    [_bottomRightImageView setImageUrl:urlString4];
    
    [im4 getImage:urlString4 withDelegate:self];
    
}


-(void)imageDataRecived:(NSData*)inImageData ofURL:(NSString *)inUrl{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([_topLeftImageView.imageUrl isEqualToString:inUrl])
        {
            _topLeftImageView.image = [UIImage imageWithData:inImageData];
            
        }
        
        if([_topRightImageView.imageUrl isEqualToString:inUrl])
        {
            _topRightImageView.image = [UIImage imageWithData:inImageData];
            
        }
        
        if([_bottomRightImageView.imageUrl isEqualToString:inUrl])
        {
            _bottomRightImageView.image = [UIImage imageWithData:inImageData];
            
        }
        
        
        if([_bottomLeftImageView.imageUrl isEqualToString:inUrl])
        {
            _bottomLeftImageView.image = [UIImage imageWithData:inImageData];
            
        }
        
    });
    
}
@end
