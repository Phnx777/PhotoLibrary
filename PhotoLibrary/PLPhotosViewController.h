//
//  PLPhotosViewController.h
//  PhotoLibrary
//
//  Created by Имал Фарук on 18.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
#import <Photos/Photos.h>
@interface PLPhotosViewController : UIViewController
@property (nonatomic, strong) Album *album;
-(void)getImageFromAsset:(PHAsset *)asset andSuccessBlock:(void (^)(UIImage * photo))success;
@end
