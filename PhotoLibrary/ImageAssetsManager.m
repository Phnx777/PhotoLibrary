//
//  ImageAssetsManager.m
//  PhotoLibrary
//
//  Created by Имал Фарук on 19.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import "ImageAssetsManager.h"
#import "Album.h"
@implementation ImageAssetsManager
-(void)getImageFromAsset:(PHAsset *)asset andSuccessBlock:(void (^)(UIImage * photo))success {
    dispatch_async(dispatch_get_global_queue(NSQualityOfServiceUserInteractive, 0), ^{
        PHImageRequestOptions *requestOptions;
        requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.resizeMode   = PHImageRequestOptionsResizeModeFast;
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        requestOptions.synchronous = YES;
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestImageForAsset:asset
                           targetSize:[[UIScreen mainScreen] bounds].size
                          contentMode:PHImageContentModeDefault
                              options:requestOptions
                        resultHandler:^void(UIImage *image, NSDictionary *info) {
                            if(image){
                                success(image);
                            }
                        }];
    });
}

- (NSArray*)fetchAssetCollections
{
    NSMutableArray *albums = [[NSMutableArray alloc]init];
    
    PHFetchResult *assetCollection = [PHAssetCollection
                                      fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                      subtype:PHAssetCollectionSubtypeAny
                                      options:nil];
    
    [assetCollection enumerateObjectsUsingBlock:^(PHAssetCollection *collection,
                                                  NSUInteger idx, BOOL * _Nonnull stop) {
        PHFetchOptions *options = [PHFetchOptions new];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate"
                                                                  ascending:YES]];
        options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
        PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:collection options:options];
        NSMutableArray * assets = [NSMutableArray new];
        [assetResult enumerateObjectsUsingBlock:^(PHAsset * asset, NSUInteger idx, BOOL *stop) {
            [assets addObject:asset];
        }];
        if (assets.count) {
            Album *album = [Album new];
            album.assets = assets;
            album.name = collection.localizedTitle;
            album.lastImageData = [self getDataFromAsset:[album.assets lastObject]];
            [albums addObject:album];
        }
    }];
    NSArray *albumsArray = [NSArray arrayWithArray:albums];
    return albumsArray;
}

- (NSData*)getDataFromAsset:(PHAsset *)asset {
    
    __block NSData *dataImage;
    PHImageRequestOptions *requestOptions;
    requestOptions = [[PHImageRequestOptions alloc] init];
    requestOptions.resizeMode   = PHImageRequestOptionsResizeModeFast;
    requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    requestOptions.synchronous = YES;
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestImageDataForAsset:asset
                              options:requestOptions
                        resultHandler:^(NSData * imageData,
                                        NSString * _Nullable dataUTI,
                                        UIImageOrientation orientation,
                                        NSDictionary * _Nullable info) {
                            if (imageData) {
                                dataImage = imageData;
                            }
                            
                        }];
    
    return dataImage;
}

@end
