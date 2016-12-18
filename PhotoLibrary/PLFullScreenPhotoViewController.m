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
@interface PLFullScreenPhotoViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *photosCollectionView;
@property (nonatomic, strong) PLPhotosViewController *photosViewController;
@end

@implementation PLFullScreenPhotoViewController {
    int _currentPage;
}

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
    [self.view addSubview:self.photosCollectionView];
    
    self.photosViewController = [PLPhotosViewController new];
    [self.photosCollectionView scrollToItemAtIndexPath:self.indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    _currentPage = (int)self.indexPath.row;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = self.photosCollectionView.frame.size.width;
    
    _currentPage = floor((self.photosCollectionView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
}

- (void)scrollViewWillEndDragging:(UIScrollView*)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint*)targetContentOffset {
    
    CGFloat pageWidth = self.photosCollectionView.frame.size.width;
    
    int newPage = _currentPage;
    
    if (velocity.x == 0) {
        newPage = (targetContentOffset->x - pageWidth/2)/pageWidth;
    } else {
        newPage = velocity.x > 0 ? _currentPage + 1 : _currentPage - 1;
        
        if (newPage < 0)
            newPage = 0;
        if (newPage > self.photosCollectionView.contentSize.width / pageWidth)
            newPage = ceil(self.photosCollectionView.contentSize.width / pageWidth) - 1.0;
    }
    *targetContentOffset = CGPointMake(newPage * pageWidth, targetContentOffset->y);
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
    [self.photosViewController getImageFromAsset:asset andSuccessBlock:^(UIImage *photo) {
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
