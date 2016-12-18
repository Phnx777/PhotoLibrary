//
//  PLPhotoCollectionViewCell.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "PLPhotoCollectionViewCell.h"

@implementation PLPhotoCollectionViewCell
- (void)commonInit
{
    self.photo = [UIImageView new];
    self.photo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.photo];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.photo.image = nil;
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass(self);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.photo.frame = self.bounds;
}
@end
