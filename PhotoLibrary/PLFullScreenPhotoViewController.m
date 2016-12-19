//
//  PLFullScreenPhotoViewController.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "PLFullScreenPhotoViewController.h"
#import "PLPhotosViewController.h"
#import "PLFullScreenCollectionViewCell.h"

@interface PLFullScreenPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *photosCollectionView;
@property (nonatomic, strong) ImageAssetsManager *assetManager;
@property (nonatomic, copy) NSArray *assetsArray;
@end

@implementation PLFullScreenPhotoViewController

- (instancetype)initWithAssets:(NSArray *)assets imageAssetManager:(ImageAssetsManager*)assetManager
{
    if ((self = [super init])) {
        self.assetManager = assetManager;
        self.assetsArray = assets;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.photosCollectionView = [[UICollectionView alloc]
                                 initWithFrame:self.view.bounds
                                 collectionViewLayout:layout];
    [self.photosCollectionView registerClass:[PLFullScreenCollectionViewCell class]
                  forCellWithReuseIdentifier:[PLFullScreenCollectionViewCell cellIdentifier]];
    self.photosCollectionView.dataSource = self;
    self.photosCollectionView.delegate = self;
    self.photosCollectionView.alwaysBounceVertical = NO;
    [self.photosCollectionView setPagingEnabled:YES];
    [self.view addSubview:self.photosCollectionView];
    
    self.assetManager = [[ImageAssetsManager alloc]init];
    [self.photosCollectionView scrollToItemAtIndexPath:self.indexPath
                                      atScrollPosition:UICollectionViewScrollPositionNone
                                              animated:NO];
}

#pragma CollectionView delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLFullScreenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                       [PLFullScreenCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    PHAsset *asset = self.assetsArray[indexPath.row];
    [self.assetManager getImageFromAsset:asset andSuccessBlock:^(UIImage *photo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell configureImage:photo];
        });
    }];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath
{
    PHAsset *asset = self.assetsArray[indexPath.row];
    [self.assetManager cancelGettingImageFromAsset:asset];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = self.view.bounds.size;
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(25, 0, 0, 0);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.photosCollectionView.frame = self.view.bounds;
}

@end
