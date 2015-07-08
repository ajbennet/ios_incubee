//
//  ICCardViewController.m
//  Incubee
//
//  Created by Rithesh Rao on 23/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICCardViewController.h"

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


-(void)dragging:(UIPanGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        _panCoord = [gesture locationInView:self.view];

        _originalFrame = _cardView.frame;
        
        _originalTransform = _cardView.transform;

        
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint newCoord = [gesture locationInView:self.view];
        
        float dX = newCoord.x-_panCoord.x;
        
        if(dX > SWIPE_MOVE)
        {
            [_delegate followCurrentProject];
        }
        else if( dX < (-(SWIPE_MOVE)))
        {
            [_delegate followCurrentProject];
        }
        _cardView.frame = _originalFrame;
        
    }
    else if(gesture.state == UIGestureRecognizerStateChanged)
    {
        CGPoint newCoord = [gesture locationInView:gesture.view];
//
        float dX = newCoord.x-_panCoord.x;
        
        float dY = newCoord.y-_panCoord.y;
//
        _cardView.frame = CGRectMake(_cardView.frame.origin.x+dX, _cardView.frame.origin.y+dY, _cardView.frame.size.width, _cardView.frame.size.height);

    
//        _cardView.transform = CGAffineTransformTranslate(_cardView.transform, dX, dY);
//
//        _updatedTransform = _cardView.transform;
//        
//        CGPoint translation = [gesture translationInView:self.view];
//        
//        gesture.view.center = CGPointMake(gesture.view.center.x + translation.x,
//                                             gesture.view.center.y + translation.y);
//
//        
//        


        
    
    }
    
}
//
//-(void)dragging:(UIPanGestureRecognizer *)gesture
//{
//    if(gesture.state == UIGestureRecognizerStateBegan)
//    {
//        _panCoord = [gesture locationInView:self.view];
//        
//        _originalFrame = _cardView.frame;
//    }
//    else if (gesture.state == UIGestureRecognizerStateEnded)
//    {
//        CGPoint newCoord = [gesture locationInView:self.view];
//        
//        float dX = newCoord.x-_panCoord.x;
//        
//        if(dX > SWIPE_MOVE)
//        {
//            [UIView animateWithDuration: 0.5
//                                  delay: 0
//                                options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
//                             animations:^{
//                                 
//                                 CGRect r = CGRectMake(_originalFrame.origin.x, _originalFrame.origin.y, _originalFrame.size.width+100, _originalFrame.size.height);
//                                 
//                                 _cardView.frame = r;
//                                 
//                             }
//                             completion:^(BOOL finished) {
//                                 
//                                 _cardView.frame = _originalFrame;
//
//                                 [_delegate followCurrentProject];
//                                 
//
//                             }];
//
//        }
//        else if( dX < (-(SWIPE_MOVE)))
//        {
//            [UIView animateWithDuration: 0.25
//                                  delay: 0
//                                options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
//                             animations:^{
//                                 
//                                 CGRect r = CGRectMake(_originalFrame.origin.x, _originalFrame.origin.y, _originalFrame.size.width-100, _originalFrame.size.height);
//                                 
//                                 _cardView.frame = r;
//
//                                 
//                             }
//                             completion:^(BOOL finished) {
//                                 
//                                 _cardView.frame = _originalFrame;
//
//                                 [_delegate followCurrentProject];
//                                 
//
//                             }];
//        }
//        else
//        {
//        
//            [UIView animateWithDuration: 0.25
//                                  delay: 0
//                                options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
//                             animations:^{
//                                 
//                                 CGRect r = CGRectMake(_originalFrame.origin.x, _originalFrame.origin.y, _originalFrame.size.width-100, _originalFrame.size.height);
//                                 
//                                 _cardView.frame = r;
//                                 
//                                 
//                             }
//                             completion:^(BOOL finished) {
//                                 
//                                 _cardView.frame = _originalFrame;
//                                 
//                                 [_delegate followCurrentProject];
//                                 
//                                 
//                             }];
//            
//        }
//    }
//    else
//    {
//        CGPoint newCoord = [gesture locationInView:gesture.view];
//        
//        float dX = newCoord.x-_panCoord.x;
//        
//        float dY = newCoord.y-_panCoord.y;
//        
//        [UIView animateWithDuration: 0.25
//                              delay: 0
//                            options: UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear
//                         animations:^{
//                             
//                             _cardView.frame = _originalFrame;
//                         }
//                         completion:nil];
//
//        
//        
//    }
//    
//}


-(void)showProject{
    
    [_moviePlayer play];
    
    [_delegate updateCurrentProjDescLable];

}


-(void)showMovie{
    
    _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:_project.video]];
    
    [_moviePlayer.view setFrame:CGRectMake(0, 0, _moviePlayerView.frame.size.width, _moviePlayerView.frame.size.height)];
    _moviePlayer.controlStyle =  MPMovieControlStyleEmbedded;
    
    _moviePlayer.shouldAutoplay = YES;
    
    _moviePlayer.repeatMode = NO;
    
    _moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    
    [_moviePlayer setFullscreen:NO animated:NO];
    
    [_moviePlayer prepareToPlay];
    
    [_moviePlayer.view setBackgroundColor:[UIColor clearColor]];
    
    [_moviePlayerView addSubview:_moviePlayer.view];
    
    [_moviePlayerView bringSubviewToFront:_moviePlayer.view];
    

}

-(void)dismissShowing{

    [_moviePlayer stop];
    
//    [_moviePlayer.view removeFromSuperview];
//    
//    _moviePlayer = nil;

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
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(showMovie) userInfo:nil repeats:NO];
    
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
