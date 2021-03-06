//
//  PLPhotoCollectionViewCell.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "PLPhotoCollectionViewCell.h"

@interface PLPhotoCollectionViewCell ()
@property (nonatomic, strong) UIImageView *photo;
@end

@implementation PLPhotoCollectionViewCell
- (void)commonInit
{
    [super commonInit];
    self.photo = [[UIImageView alloc]init];
    self.photo.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.photo];
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
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
