//
//  PLPhotosViewController.h
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
#import "ImageAssetsManager.h"
@interface PLPhotosViewController : UIViewController
- (instancetype)initWithAlbum:(Album *)album
            imageAssetManager:(ImageAssetsManager*)assetManager;
@end
