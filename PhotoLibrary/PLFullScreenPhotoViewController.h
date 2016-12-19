//
//  PLFullScreenPhotoViewController.h
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface PLFullScreenPhotoViewController : UIViewController
@property (nonatomic, copy) NSArray *assetsArray;
@property (nonatomic, strong) NSIndexPath * indexPath;
@end
