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
@interface PLPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *photosCollectionView;
@end

@implementation PLPhotosViewController {
    NSMutableArray *_photoAssetsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
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
    self.photosCollectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.photosCollectionView];
}

- (void)setAlbum:(Album *)album
{
    _photoAssetsArray = album.assets;
    self.title = album.name;
}

-(void)getImageFromAsset:(PHAsset *)asset andSuccessBlock:(void (^)(UIImage * photo))success {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PHImageRequestOptions *requestOptions;
        requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.resizeMode   = PHImageRequestOptionsResizeModeFast;
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        requestOptions.synchronous = YES;
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestImageForAsset:asset
                           targetSize:self.view.bounds.size
                          contentMode:PHImageContentModeDefault
                              options:requestOptions
                        resultHandler:^void(UIImage *image, NSDictionary *info) {
                                if(image){
                                    success(image);
                                }
                        }];
    });
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    PLFullScreenPhotoViewController *vc = [PLFullScreenPhotoViewController new];
    vc.indexPath = indexPath;
    vc.assetsArray = _photoAssetsArray;
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
    [cell commonInit];
    PHAsset *asset = _photoAssetsArray[indexPath.row];
    [self getImageFromAsset:asset andSuccessBlock:^(UIImage *photo) {
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
    CGFloat cellSide = size.width/3;
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
