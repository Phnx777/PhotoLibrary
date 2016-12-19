//
//  ImageAssetsManager.h
//  PhotoLibrary
//
//  Created by Имал Фарук on 19.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface ImageAssetsManager : NSObject
-(void)getImageFromAsset:(PHAsset *)asset andSuccessBlock:(void (^)(UIImage * photo))success;
- (NSArray*)fetchAssetCollections;
@end
