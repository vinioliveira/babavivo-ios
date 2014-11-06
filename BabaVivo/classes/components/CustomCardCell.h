//
//  FFVCardPostTableViewCell.h
//  Denucie
//
//  Created by Vinicius Oliveira on 6/11/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picturePosted;
@property (weak, nonatomic) IBOutlet UIImageView *avatarUser;
@property (weak, nonatomic) IBOutlet UILabel *userName;

@end
