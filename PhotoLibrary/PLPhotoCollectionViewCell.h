//
//  PLPhotoCollectionViewCell.h
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *photo;

+ (NSString *)cellIdentifier;
- (void)commonInit;
@end
