//
//  PLPhotosViewController.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "PLPhotosViewController.h"
#import "PLPhotoCollectionViewCell.h"
#import "PLFullScreenPhotoViewController.h"
#import "ImageAssetsManager.h"
@interface PLPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *photosCollectionView;
@property (nonatomic, strong) ImageAssetsManager *assetManager;
@property (nonatomic, strong) Album *album;
@end

@implementation PLPhotosViewController {
    NSArray *_photoAssetsArray;
}

- (instancetype)initWithAlbum:(Album *)album imageAssetManager:(ImageAssetsManager*)assetManager
{
    if ((self = [super init])) {
        self.assetManager = assetManager;
        self.album = album;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    self.photosCollectionView = [[UICollectionView alloc]
                                initWithFrame:self.view.bounds
                                collectionViewLayout:layout];
    [self.photosCollectionView registerClass:[PLPhotoCollectionViewCell class]
                 forCellWithReuseIdentifier:[PLPhotoCollectionViewCell cellIdentifier]];
    self.photosCollectionView.backgroundColor = [UIColor whiteColor];;
    self.photosCollectionView.dataSource = self;
    self.photosCollectionView.delegate = self;
    [self.view addSubview:self.photosCollectionView];
    
    self.assetManager = [[ImageAssetsManager alloc]init];
}

- (void)setAlbum:(Album *)album
{
    _photoAssetsArray = album.assets;
    self.title = album.name;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLFullScreenPhotoViewController *vc = [[PLFullScreenPhotoViewController alloc]initWithAssets:_photoAssetsArray
                                                                               imageAssetManager:self.assetManager];
    vc.indexPath = indexPath;
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photoAssetsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                       [PLPhotoCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    PHAsset *asset = _photoAssetsArray[indexPath.row];
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
    PHAsset *asset = _photoAssetsArray[indexPath.row];
    [self.assetManager cancelGettingImageFromAsset:asset];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = self.view.bounds.size;
    CGFloat cellSide = size.width/3 - 1;
    return CGSizeMake(cellSide, cellSide);
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
