//
//  PLAlbumCollectionViewCell.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 15.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "PLAlbumCollectionViewCell.h"

@implementation PLAlbumCollectionViewCell {
    UIImageView *_icon;
    UILabel *_nameAlbumLabel;
    UILabel *_photoNumber;
}

- (void)commonInit {
    [super commonInit];
    self.contentView.layer.masksToBounds = YES;
    
    _icon = [[UIImageView alloc]init];
    _icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_icon];
    
    _nameAlbumLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_nameAlbumLabel];
    
    _photoNumber = [[UILabel alloc]init];
    [self.contentView addSubview:_photoNumber];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _icon.image = nil;
    [_nameAlbumLabel setText:nil];
    [_photoNumber setText:nil];
}

- (void)configureIcon:(NSData*)icon
{
    UIImage *lastImage = [UIImage imageWithData:icon];
    [_icon setImage:lastImage];
}

- (void)configureAlbumName:(NSString*)name
{
    [_nameAlbumLabel setText:name];
}

- (void)configureAssetsNumber:(long)number
{
    [_photoNumber setText:[NSString stringWithFormat:@"%ld", number]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.contentView.bounds.size;
    CGFloat imageOffset = 0.1*size.width;
    CGFloat leftOffset = self.isSecondInRow ? imageOffset : imageOffset*2;
    CGFloat imageSide = imageOffset*7;
    _icon.frame = CGRectMake(leftOffset, 0,
                             imageSide, imageSide);
    _nameAlbumLabel.frame = CGRectMake(leftOffset, CGRectGetMaxY(_icon.frame),
                                       size.width, imageOffset);
    _photoNumber.frame = CGRectMake(leftOffset, CGRectGetMaxY(_nameAlbumLabel.frame),
                                       size.width, imageOffset);
    
}


@end
