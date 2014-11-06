//
//  HeaderMenuSideCell.m
//  BabaVivo
//
//  Created by Vinicius Oliveira on 10/31/14.
//  Copyright (c) 2014 FFV. All rights reserved.
//

#import "HeaderMenuSideCell.h"

@implementation HeaderMenuSideCell

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
}
@end
