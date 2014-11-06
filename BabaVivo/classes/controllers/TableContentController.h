//
//  TableContentController.h
//  IOS-App
//
//  Created by Vinicius Oliveira on 10/10/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableContentController : UIViewController <UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate>
@property (assign, nonatomic) NSInteger index;
@end
