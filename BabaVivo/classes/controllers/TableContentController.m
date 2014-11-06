//
//  TableContentController.m
//  IOS-App
//
//  Created by Vinicius Oliveira on 10/10/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import "TableContentController.h"
#import "CustomCardCell.h"
#import "UserPost.h"
#import "Post.h"
#import "User.h"
#import "CoreDataHelper.h"
#import "FFVSessionControl.h"
#import "SWRevealViewController.h"
#import "MainTableViewController.h"
#import <RestKit/RestKit.h>

@interface TableContentController ()<SWRevealViewControllerDelegate>
@property  (nonatomic,strong) NSMutableArray* posts;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property   (nonatomic, strong) UITableView *tableView;
@end

@implementation TableContentController

@synthesize fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildLayoutTable];
//    [self initRveal];
//    [self initRestKit];
}



- (MainTableViewController *) mainParentController
{
    UIViewController *parent = self;
    Class revealClass = [MainTableViewController class];
    while ( nil != (parent = [parent parentViewController]) && ![parent isKindOfClass:revealClass] ) {}
    return (id)parent;
}


#pragma mark - Configurations

-(void) initRveal
{
    MainTableViewController *mainParent = [self mainParentController];
    
    SWRevealViewController *revealController = [mainParent revealViewController];
    
    revealController.delegate = self;
    
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    [leftButton setTintColor:[UIColor whiteColor]];
    
    mainParent.navigationItem.leftBarButtonItem = leftButton;
    
}

#pragma mark - SWRevealViewControllerDelegate
- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position
{
    if(FrontViewPositionLeft == position)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else if(FrontViewPositionRight == position)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

#pragma mark - Layout

- (void) buildLayoutTable
{

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    self.tableView.rowHeight = 70;

    self.tableView.scrollEnabled = YES;
    self.tableView.bounces = YES;
    
    [self.tableView setContentInset:UIEdgeInsetsMake(30,0,0,0)];
    
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 320, 1) animated:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.userInteractionEnabled = YES;
    self.tableView.bounces = YES;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
}

#pragma mark - RestKit

-(void) initRestKit
{
    // Set debug logging level. Set to 'RKLogLevelTrace' to see JSON payload
    RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Post"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"legend" ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSError *error = nil;
    
    // Setup fetched results
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self.fetchedResultsController setDelegate:self];
    
    BOOL fetchSuccessful = [self.fetchedResultsController performFetch:&error];
    
    if (! fetchSuccessful) {
        RKLogError(@"Load failed with error: %@", error);

    }
    
    [self loadData];
    
}

- (void)loadData
{
    // Load the object model via RestKit
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/posts" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load complete: Table should refresh...");
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Load failed with error: %@", error);

    }
     ];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
//    return [sectionInfo numberOfObjects];
    return 10;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return MAX(200.0f, 88.0f);
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    CustomCardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (nil == cell) {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCardCell" owner:nil options:nil];
        for (id currentObject in nibObjects)
        {
            if ([currentObject isKindOfClass:[CustomCardCell class]])
            {
                cell = (CustomCardCell *)currentObject;
            }
        }
    }
    
//    Post *post = [self.fetchedResultsController objectAtIndexPath:indexPath];
  
//    cell.userName.text = post.user.firstName;
//
//    NSURL *imageURL = [NSURL URLWithString:post.urlImagePublished];
//    NSURL *avatarUrl  = [NSURL URLWithString:post.user.avatar];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//        NSData *avatarData = [NSData dataWithContentsOfURL:avatarUrl];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.picturePosted.image = [UIImage imageWithData:imageData];
//            cell.avatarUser.image = [UIImage imageWithData:avatarData];
//        });
//    });
    
    
    return cell;
    
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

@end
