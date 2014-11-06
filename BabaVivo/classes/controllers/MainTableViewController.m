//
//  MainTableViewController.m
//  IOS-App
//
//  Created by Vinicius Oliveira on 10/7/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import "MainTableViewController.h"
#import "TableContentController.h"
#import <RestKit/RestKit.h>
#import "Post.h"
#import "SWRevealViewController.h"

@interface MainTableViewController () <SWRevealViewControllerDelegate>


@property (nonatomic, strong) UIButton* floatingButton;
@property (nonatomic, strong) UIImage* imageSaved;
@property BOOL newMedia;
@property (strong, nonatomic) UIPageViewController *pageController;
@property (nonatomic, strong) UIView *selectionIndicator;
@property (nonatomic, strong) UIToolbar *uitoolbar;

@end


@implementation MainTableViewController

@synthesize floatingButton, imageSaved, selectionIndicator, uitoolbar;

#pragma ViewController Delegates

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildTabBar];
//    [self revealInit];
    [self layout];
//    [self buildPageControl];
   
}

- (void)viewWillAppear:(BOOL)animated{
    [self revealInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Style Configurations

-(void) revealInit
{
    
    SWRevealViewController *revealController = [self revealViewController];
    
    revealController.delegate = self;
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

-(void) layout
{
    [self navigationControllerConstumizations];
//    [self buildSubMenuPages];
//    [self makeCameraButton];
}

-(void) buildTabBar
{

    TableContentController *view1 = [self viewControllerAtIndex:0];
    TableContentController *view2 = [self viewControllerAtIndex:0];
    TableContentController *view3 = [self viewControllerAtIndex:0];
    TableContentController *view4 = [self viewControllerAtIndex:0];
    
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
    [tabViewControllers addObject:view1];
    [tabViewControllers addObject:view2];
    [tabViewControllers addObject:view3];
    [tabViewControllers addObject:view4];
    
    [self setViewControllers:tabViewControllers];
    //can't set this until after its added to the tab bar
    view1.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"Rank"
                                  image:[UIImage imageNamed:@"trophy"]
                                    tag:1];
    view2.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"Artilharia"
                                  image:[UIImage imageNamed:@"medal"]
                                    tag:2];
    view3.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"Dodo"
                                  image:[UIImage imageNamed:@"player"]
                                    tag:3];
    
    view4.tabBarItem =
    [[UITabBarItem alloc] initWithTitle:@"Gol"
                                  image:[UIImage imageNamed:@"star"]
                                    tag:3];
}

-(void) buildPageControl
{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.delegate = self;
    
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    TableContentController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.view addSubview:[self.pageController view]];
    [self.view insertSubview:[self.pageController view] belowSubview:uitoolbar];
    [self.pageController didMoveToParentViewController:self];
    
    
    
    NSArray *subviews = self.pageController.view.subviews;
    UIPageControl *thisControl = nil;
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i] isKindOfClass:[UIPageControl class]]) {
            thisControl = (UIPageControl *)[subviews objectAtIndex:i];
        }
    }
    
    thisControl.hidden = true;
    self.pageController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+40);
}

- (TableContentController *)viewControllerAtIndex:(NSUInteger)index {
    
    TableContentController *childViewController = [[TableContentController alloc] initWithNibName:@"TableContentController" bundle:nil];
    
    childViewController.index = index;
    
    return childViewController;
    
}

-(void) navigationControllerConstumizations
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    NSUInteger r = 63, g = 181, b = 199;

//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]];
//    [self.tabBarController.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]];

    [[UINavigationBar appearance]  setBarTintColor:[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]];
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus"] style:UIBarButtonItemStyleBordered target:nil action:nil];
    [rightButton setTintColor:[UIColor whiteColor]];

    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.title = @"Footbalify";
    
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"OpenSans-Bold" size:14.f], NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textTitleOptions];

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//-(void) revealInit
//{
//    
//    SWRevealViewController *revealController = [self revealViewController];
//    
//    revealController.delegate = self;
//  
//    [revealController panGestureRecognizer];
//    [revealController tapGestureRecognizer];
//    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
//    [leftButton setTintColor:[UIColor whiteColor]];
//    
//    self.navigationItem.leftBarButtonItem = leftButton;
//
//}

-(void) buildSubMenuPages
{
    uitoolbar = [[UIToolbar alloc] init];
    
    [uitoolbar setFrame:CGRectMake(0, 60, 320, 40)];

//    uitoolbar.translucent = NO;

    [uitoolbar setBarTintColor:[UIColor colorWithRed:38 green:88 blue:208 alpha:0]];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [uitoolbar setAlpha:0.5];
    }
    
    [self.view addSubview:uitoolbar];
    
}

-(void) makeCameraButton
{
    floatingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [floatingButton addTarget:self
                       action:@selector(takePicture:)
     
             forControlEvents:UIControlEventTouchDown];
    [floatingButton setBackgroundImage:[UIImage imageNamed:@"cam"] forState:UIControlStateNormal];
    floatingButton.frame = CGRectMake(245.0, 70.0, 60.0, 42.0);
    [self.view addSubview:floatingButton];

}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        [self savePost:info[UIImagePickerControllerOriginalImage]];
        
        //        UserPost *novoPost =  [[UserPost alloc] init];
        //        novoPost.user = @"Vinicius Olivira";
        //        novoPost.avatar = [UIImage imageNamed:@"ui.jpg"];
        //        novoPost.postPicture = image;
        //
        //        [self.posts insertObject:novoPost atIndex:0];
        //
        //        [self.tableView beginUpdates];
        //        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        //        [self.tableView endUpdates];
        
        //        if (self.newPostImage)
        //            UIImageWriteToSavedPhotosAlbum(image,
        //                                           self,
        //                                           @selector(image:finishedSavingWithError:contextInfo:),
        //                                           nil);
        //    }
        //    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
        //    {
        //        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Controllers Methods

-( void ) takePicture:(id) button
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker
                           animated:YES completion:nil];
        _newMedia = YES;
    }
}

- (void)savePost:(UIImage *) image {
    RKManagedObjectStore *objectStore = [[RKObjectManager sharedManager] managedObjectStore];
    
    Post *post = [NSEntityDescription insertNewObjectForEntityForName:@"Post" inManagedObjectContext:objectStore.mainQueueManagedObjectContext];
    
    [post setLegend:@"Awesome Description"];
    [post setUser:[[self todosCarros] firstObject]];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.1f);
    
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] multipartFormRequestWithObject:post method:RKRequestMethodPOST path:@"/posts" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:imageData
                                    name:@"published_image"
                                fileName:[NSString stringWithFormat:@"%f.png",[[NSDate date] timeIntervalSince1970] * 1000]
                                mimeType:@"image/png"];
    }];
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:request success:nil failure:nil];
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation]; // NOTE: Must be enqueued rather than started
    
}


- (NSArray *) todosCarros
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    return [[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    
}

#pragma mark -  PageControlDelegate


- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    
}


- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSLog(@"Pagina Começou a ser arrastada");
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    
    NSUInteger index = [(TableContentController *)viewController index];
    
    [self moveSelectionIndicatorForIndex:index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [(TableContentController *)viewController index];
    
    [self moveSelectionIndicatorForIndex:index];
    index++;
    
    if (index == 3) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

-(void) moveSelectionIndicatorForIndex:(NSUInteger) index
{
//    [UIView animateWithDuration:0.1 animations:^(void){
//        selectionIndicator.frame = [self selectionIndicatorPositionForIndex:index];
//    }];
}

-(CGRect) selectionIndicatorPositionForIndex:(NSUInteger) index{
    
//    CGRect frame = ((UIView *)[menus objectAtIndex:index]).frame;
    
//    CGFloat ySelectionPostion = frame.origin.y + frame.size.height;
    
//    return CGRectMake(frame.origin.x, ySelectionPostion, frame.size.width, 3);
    return CGRectMake(0, 60, 320, 30);
}
@end
