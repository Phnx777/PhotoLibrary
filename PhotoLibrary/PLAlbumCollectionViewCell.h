//
//  PLAlbumCollectionViewCell.h
//  PhotoLibrary
//
//  Created by Имал Фарук on 15.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
@class PLAlbumCollectionViewCell;

@protocol PLAlbumCollectionViewCellDelegate <NSObject>

- (void)didSelectAlbum:(Album*)album;

@end

@interface PLAlbumCollectionViewCell : UICollectionViewCell
@property (weak) id <PLAlbumCollectionViewCellDelegate> delegate;
@property (nonatomic, assign) BOOL isSecondInRow;
@property (nonatomic, strong) Album *album;
- (void)commonInit;

+ (NSString *)cellIdentifier;

@end
