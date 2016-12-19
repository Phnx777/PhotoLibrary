//
//  PLFullScreenPhotoViewController.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "PLFullScreenPhotoViewController.h"
#import "PLPhotosViewController.h"
#import "PLPhotoCollectionViewCell.h"
#import "ImageAssetsManager.h"
@interface PLFullScreenPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *photosCollectionView;
@property (nonatomic, strong) ImageAssetsManager *assetManager;
@end

@implementation PLFullScreenPhotoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.photosCollectionView = [[UICollectionView alloc]
                                 initWithFrame:self.view.bounds
                                 collectionViewLayout:layout];
    [self.photosCollectionView registerClass:[PLPhotoCollectionViewCell class]
                  forCellWithReuseIdentifier:[PLPhotoCollectionViewCell cellIdentifier]];
    self.photosCollectionView.backgroundColor = [UIColor whiteColor];
    self.photosCollectionView.dataSource = self;
    self.photosCollectionView.delegate = self;
    self.photosCollectionView.showsVerticalScrollIndicator = YES;
    self.photosCollectionView.alwaysBounceVertical = NO;
    [self.photosCollectionView setPagingEnabled:YES];
    [self.view addSubview:self.photosCollectionView];
    
    self.assetManager = [[ImageAssetsManager alloc]init];
    [self.photosCollectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                       [PLPhotoCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    [cell commonInit];
    PHAsset *asset = self.assetsArray[indexPath.row];
    [self.assetManager getImageFromAsset:asset andSuccessBlock:^(UIImage *photo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.photo.image = photo;
        });
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = self.view.bounds.size;
    return CGSizeMake(size.width, size.height);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.photosCollectionView.frame = self.view.bounds;
}

@end
