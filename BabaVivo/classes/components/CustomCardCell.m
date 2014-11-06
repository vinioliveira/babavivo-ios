//
//  FFVCardPostTableViewCell.m
//  Denucie
//
//  Created by Vinicius Oliveira on 6/11/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import "CustomCardCell.h"
#import <Foundation/Foundation.h>


@interface CustomCardCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UILabel *position;

@property (nonatomic) float requiredCellHeight;
@end

@implementation CustomCardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    [self doLayoutPostImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma Layout

- (void) doLayoutPostImage
{
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width /2;
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.avatar.layer.borderWidth = 1.0f;;
    
    self.position.clipsToBounds = YES;
    [self.position.layer setCornerRadius:10];
}

@end
