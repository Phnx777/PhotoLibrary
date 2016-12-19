//
//  Album.h
//  PhotoLibrary
//
//  Created by Имал Фарук on 17.12.16.
//  Copyright © 2016 Имал Фарук. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *assets;
@property (nonatomic, strong) NSData *lastImageData;
@end
