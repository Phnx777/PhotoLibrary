//
//  PLFullScreenPhotoViewController.h
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "ImageAssetsManager.h"
@interface PLFullScreenPhotoViewController : UIViewController
@property (nonatomic, strong) NSIndexPath * indexPath;
- (instancetype)initWithAssets:(NSArray *)assets
             imageAssetManager:(ImageAssetsManager*)assetManager;
@end
