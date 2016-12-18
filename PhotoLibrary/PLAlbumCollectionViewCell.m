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
    self.backgroundColor = [UIColor whiteColor];
    
    _icon = [UIImageView new];
    _icon.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_icon];
    
    _nameAlbumLabel = [UILabel new];
    [self addSubview:_nameAlbumLabel];
    
    _photoNumber = [UILabel new];
    [self addSubview:_photoNumber];
    
    UITapGestureRecognizer *itemTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(handleItemTap)];
    [self addGestureRecognizer:itemTapGesture];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _icon.image = nil;
    [_nameAlbumLabel setText:nil];
    [_photoNumber setText:nil];
}

- (void)handleItemTap
{
    [self.delegate didSelectAlbum:self.album];
}

- (void)setAlbum:(Album *)album
{
    _album = album;
    UIImage *lastImage = [UIImage imageWithData:album.lastImageData];
    [_icon setImage:lastImage];
    [_nameAlbumLabel setText:album.name];
    [_photoNumber setText:[NSString stringWithFormat:@"%ld", (unsigned long)album.assets.count]];
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass(self);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = self.bounds.size;
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
