//
//  PLFullScreenCollectionViewCell.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 19.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "PLFullScreenCollectionViewCell.h"

@interface PLFullScreenCollectionViewCell ()
@property (nonatomic, strong) UIImageView *photo;
@end

@implementation PLFullScreenCollectionViewCell

- (void)commonInit
{
    [super commonInit];
    self.photo = [[UIImageView alloc]init];
    self.photo.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.photo];
}

- (void)configureImage:(UIImage*)image
{
    self.photo.image = image;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.photo.image = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photo.frame = self.contentView.bounds;
}

@end
