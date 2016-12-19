//
//  ViewController.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 15.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import "PLAlbumCollectionViewCell.h"
#import "PLPhotosViewController.h"
#import "ImageAssetsManager.h"
#import "Album.h"
@interface ViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *albumCollectionView;
@property (nonatomic, strong) ImageAssetsManager *assetManager;
@end

@implementation ViewController {
    NSArray *_albumsArray;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.assetManager = [[ImageAssetsManager alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    self.albumCollectionView = [[UICollectionView alloc]
                                  initWithFrame:self.view.bounds
                                  collectionViewLayout:layout];
    [self.albumCollectionView registerClass:[PLAlbumCollectionViewCell class]
                   forCellWithReuseIdentifier:[PLAlbumCollectionViewCell cellIdentifier]];
    self.albumCollectionView.backgroundColor = [UIColor whiteColor];;
    self.albumCollectionView.dataSource = self;
    self.albumCollectionView.delegate = self;
    [self.view addSubview:self.albumCollectionView];
    
    [self loadLibraryOrAskAccess];
}

- (void)loadLibraryOrAskAccess
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusAuthorized) {
        [self loadLibrary];
    } else {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                [self loadLibrary];
            } else if (status == PHAuthorizationStatusDenied) {
                [self warnAboutAccessToLibrary];
            }
        }];
    }
}

- (void)warnAboutAccessToLibrary
{
    NSString *title = @"Доступ к галерее запрещен!";
    NSString *message = @"Разрешите доступ для работы с приложением!";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ок" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"В Настройки" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        });
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:settingsAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)loadLibrary
{
    
    dispatch_async(dispatch_get_global_queue(NSQualityOfServiceUserInteractive, 0), ^{
        _albumsArray = [self.assetManager fetchAssetCollections];
        if (_albumsArray.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.albumCollectionView reloadData];
            });
        }
    });
}

- (void)openAlbum:(Album*)album
{
    PLPhotosViewController *vc = [[PLPhotosViewController alloc]initWithAlbum:album
                                                            imageAssetManager:self.assetManager];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma CollectionView Delegates

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _albumsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                       [PLAlbumCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    Album *album = _albumsArray[indexPath.row];
    [cell configureIcon:album.lastImageData];
    [cell configureAlbumName:album.name];
    [cell configureAssetsNumber:album.assets.count];
    cell.isSecondInRow = indexPath.row%2;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Album *album = _albumsArray[indexPath.row];
    [self openAlbum:album];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
                sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = self.view.bounds.size;
    CGFloat cellSide = size.width/2;
    return CGSizeMake(cellSide, cellSide);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(25, 0, 0, 0);
}

#pragma Layouts

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.albumCollectionView.frame = self.view.bounds;
}


@end
