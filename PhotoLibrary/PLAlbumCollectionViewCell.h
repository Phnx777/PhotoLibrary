//
//  PLAlbumCollectionViewCell.h
//  PhotoLibrary
//
//  Created by Имал Фарук on 15.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "PLCollectionViewCell.h"
#import "Album.h"
@class PLAlbumCollectionViewCell;

@interface PLAlbumCollectionViewCell : PLCollectionViewCell

@property (nonatomic, assign) BOOL isSecondInRow;

- (void)configureIcon:(NSData*)icon;
- (void)configureAlbumName:(NSString*)name;
- (void)configureAssetsNumber:(long)number;

@end
