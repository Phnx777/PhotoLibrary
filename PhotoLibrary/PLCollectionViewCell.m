//
//  PLCollectionViewCell.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 19.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "PLCollectionViewCell.h"

@implementation PLCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit
{
    
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass(self);
}

@end
