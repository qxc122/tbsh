//
//  SuPhotoManager.m
//  LazyWeather
//
//  Created by KevinSu on 15/12/6.
//  Copyright (c) 2015年 SuXiaoMing. All rights reserved.
//

#import "SuPhotoManager.h"


#define SCREEN_W    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_H    ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_B    [[UIScreen mainScreen] bounds]

//#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define AblumsListLineColor RGBColor(192, 192, 192)
#define BGCOLOR  RGBColor(237, 238, 242)
#define BTNCOLOR RGBColor(38, 184, 243)
#define CLEARCOLOR [UIColor clearColor]
#define WHITECOLOR [UIColor whiteColor]
#define BLACKCOLOR [UIColor blackColor]

#define Space 5

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

#define ShowMsg(_msg) [[[SuMessageTool alloc]init]ToastMessage:_msg]

#define PhotoLibraryChangeNotification @"PhotoLibraryChangeNotification"

#define OriginalRatio 0.9

@interface SuPhotoManager ()

@property (nonatomic ,strong) NSMutableArray<SuAblumInfo *> * ablumsList;

@end

@implementation SuPhotoManager


+ (instancetype)manager {
    
    static SuPhotoManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SuPhotoManager alloc]init];
        manager.ablumsList = [NSMutableArray array];
    });
    return manager;
}

/*
 * 获取所有相册
 */
- (NSArray<SuAblumInfo *> *)getAllAblums {
    
    //先清空数组
    [_ablumsList removeAllObjects];
    
    //列出并加入所有智能相册
    PHFetchResult * smartAblums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    [self fetchCollection:smartAblums];
    
    //列出列出并加入所有用户创建的相册
    PHFetchResult * topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    [self fetchCollection:topLevelUserCollections];
    
    return _ablumsList;
}

/*
 * 获取相册资源
 */
- (void)fetchCollection:(PHFetchResult *)obj {
    
    //如果obj是所有相册的合集
    [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[PHAssetCollection class]]) {
            
            //返回此相册的资源集合
            PHFetchResult * result = [self fetchResultInCollection:obj asending:NO];
            
            //如果有资源
            if (result.count) {
                
                //创建此相册的信息集
                SuAblumInfo * info = [SuAblumInfo infoFromResult:result collection:obj];
                
                //加入到数组中
                [_ablumsList addObject:info];
            }
        }
    }];
}


/*
 * 获取（指定相册）或者（所有相册）资源的合集，并按资源的创建时间进行排序 YES  倒序 NO
 */
- (PHFetchResult *)fetchResultInCollection:(PHAssetCollection *)collection asending:(BOOL)asending {
    
    PHFetchOptions * option = [[PHFetchOptions alloc]init];
    option.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:asending]];
    option.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
    PHFetchResult * result;
    //获取指定相册资源合集
    if (collection) {
        
        result = [PHAsset fetchAssetsInAssetCollection:collection options:option];
        
    }
    //获取所有相册资源合集
    else {
        
        result = [PHAsset fetchAssetsWithOptions:option];
    }
    return result;
}

/*
 * 获取所有相册图片资源
 */
- (NSArray<PHAsset *> *)fetchAllAssets {
    
    return [self fetchAssetsInCollection:nil asending:NO];
}

/*
 * 获取（指定相册）或者（所有相册 collection为nil）资源
 */
- (NSArray<PHAsset *> *)fetchAssetsInCollection:(PHAssetCollection *)collection asending:(BOOL)asending{
    
    NSMutableArray<PHAsset *> * list = [NSMutableArray array];
    
    PHFetchResult * result;
    
    //获取指定相册资源
    if (collection) {
        
        result = [self fetchResultInCollection:collection asending:asending];
    }
    //获取所有相册资源
    else {
        
        result = [self fetchResultInCollection:nil asending:asending];
        
    }
    
    //枚举添加到数组
    [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [list addObject:obj];
    }];
    
    return list;
}

/*
 * 获取资源对应的图片
 */
- (void)fetchImageInAsset:(PHAsset *)asset size:(CGSize)size isResize:(BOOL)isResize completeBlock:(void(^)(UIImage * image, NSDictionary * info))completeBlock {

    PHImageRequestOptions * option = [[PHImageRequestOptions alloc]init];
    //resizeMode：None，不缩放；Fast，尽快地提供接近或稍微大于要求的尺寸；Exact，精准提供要求的尺寸。
    option.resizeMode = isResize ? PHImageRequestOptionsResizeModeFast : PHImageRequestOptionsResizeModeNone;
    option.networkAccessAllowed = YES;
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (completeBlock) completeBlock(result, info);
    }];
}

/*
 * 获取资源对应的原图大小
 */
- (void)getImageDataLength:(PHAsset *)asset completeBlock:(void(^)(CGFloat length))completeBlock{
    
    PHImageRequestOptions * option = [[PHImageRequestOptions alloc]init];
    option.resizeMode = PHImageRequestOptionsResizeModeNone;

    [[PHImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
        
        if (completeBlock) completeBlock(imageData.length / 1000.0);
    }];
}



- (void)fetchImagesWithAssetsArray:(NSMutableArray<PHAsset *> *)assetsArray isOriginal:(BOOL)isOriginal completeBlock:(void(^)(NSArray * images))completeBlock {
    
    NSMutableArray * images = [NSMutableArray array];

    for (int i = 0; i < assetsArray.count; i ++) {
        
        PHAsset * asset = assetsArray[i];
        CGSize size;
        
        if (isOriginal) {
            
            //源图 -> 不压缩
            size = CGSizeMake((CGFloat)asset.pixelWidth, (CGFloat)asset.pixelHeight);
            
        }else {
            
            //压缩的图 －> 以最长边为屏幕分辨率压缩
            CGFloat scale = (CGFloat)asset.pixelWidth / (CGFloat)asset.pixelHeight;
            if (scale > 1.0) {
                
                if (asset.pixelWidth < SCREEN_W) {
                    //最长边小于屏幕宽度时，采用原图
                    size = CGSizeMake((CGFloat)asset.pixelWidth, (CGFloat)asset.pixelHeight);
                }else {
                    //压缩
                    size = CGSizeMake(SCREEN_W, SCREEN_W / scale);
                }
                
            }else {
                
                if (asset.pixelHeight < SCREEN_H) {
                    //最长边小于屏幕高度时，采用原图
                    size = CGSizeMake((CGFloat)asset.pixelWidth, (CGFloat)asset.pixelHeight);
                }else {
                    //压缩
                    size = CGSizeMake(SCREEN_H * scale, SCREEN_H);
                }
                
            }
        }
        
        [self fetchImageInAsset:asset size:size isResize:YES completeBlock:^(UIImage *image, NSDictionary *info) {
            
            //当图片读取到指定尺寸时
            if (image.size.width >= size.width * OriginalRatio || image.size.height >= size.height * OriginalRatio) {

                [images addObject:image];
                
                //全部图片读取完毕
                if (images.count == assetsArray.count) {
                
                    //执行block
                    if (completeBlock) {
                        completeBlock(images);
                    }
//                    if (completeBlock) completeBlock(images);
                }
            }
        }];
    }
    
}



#pragma mark - <  根据PHAsset获取图片信息  >
- (void)accessToImageAccordingToTheAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void(^)(UIImage *image,NSDictionary *info))completion
{
    if (size.width == PHImageManagerMaximumSize.width && size.height == PHImageManagerMaximumSize.height) {
        size = CGSizeMake(1000, 1000);
    }
    
    static PHImageRequestID assetRequestID = -2;
    PHImageManager *imageManager = [PHImageManager defaultManager];
    
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.synchronous = false;
    options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
//        NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                              [NSNumber numberWithDouble: progress], @"progress",
//                              self, @"photo", nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:MWPHOTO_PROGRESS_NOTIFICATION object:dict];
    };
    
    assetRequestID = [imageManager requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {
        if (result) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *tmp = (UIImage *)result;
                //在这里 压缩
                NSData *imageData = UIImageJPEGRepresentation(tmp,1.0);//进行图片压缩
                
                CGFloat yasou=1.0;
                NSLog(@"原来的大小 imageData.leng=%ld k",imageData.length/1024);
                while (imageData.length > 1024*1024) {
                    NSLog(@"太大了 分享  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
                    imageData = UIImageJPEGRepresentation(tmp, yasou);
                    if (imageData.length > 10*1024*1024) {
                        yasou *=0.1;
                    } else if (imageData.length > 5*1024*1024){
                        yasou *=0.2;
                    } else if (imageData.length > 4*1024*1024){
                        yasou *=0.6;
                    } else if (imageData.length > 3*1024*1024){
                        yasou *=0.7;
                    } else if (imageData.length > 2*1024*1024){
                        yasou *=0.8;
                    } else if (imageData.length > 1*1024*1024){
                        yasou *=0.9;
                    } else{
                        yasou *=0.95;
                    }
                    if (yasou<0.01 && imageData.length > 1024*1024) {
                        break;
                    }
//                    if (yasou<0.01 && imageData.length > 1024*1024) {
//                        CGFloat yasouTwo= 0.8;
//                        UIImage *imageTwoTmp = [UIImage imageWithData:imageData];
//                        while (imageData.length > 1024*1024) {
//                            UIImage *tmpTwo = [[tourHelper sharedInstance]image:imageTwoTmp withBlurLevel:yasouTwo];
//                            imageData = UIImageJPEGRepresentation(tmpTwo, 1.0);
//                            if (yasouTwo > 0.1) {
//                                yasouTwo =  yasouTwo - 0.1;
//                            }
//                            if (yasouTwo < 0.1) {
//                                break;
//                            }
//                        }
//                    }
                    NSLog(@"压小后 分享  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(result,info);
                });
            });
        }else{
            NSLog(@"照片下载失败");
        }
    }];
    
    
//    if (size.width == PHImageManagerMaximumSize.width && size.height == PHImageManagerMaximumSize.height) {
//        size = CGSizeMake(800, 800);
//    }
    /*
    static PHImageRequestID requestID = -2;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = MIN([UIScreen mainScreen].bounds.size.width, 500);
    if (requestID >= 1 && size.width / width == scale) {
        [[PHCachingImageManager defaultManager] cancelImageRequest:requestID];
    }
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
    option.resizeMode = resizeMode;
    option.networkAccessAllowed = YES;
//    option.synchronous = YES;
    requestID = [[PHCachingImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        NSLog(@"%@",[NSThread currentThread]);
//        dispatch_async(dispatch_get_main_queue(), ^{
        //        });
        if (result) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *tmp = (UIImage *)result;
                //在这里 压缩
                NSData *imageData = UIImageJPEGRepresentation(tmp,1.0);//进行图片压缩
                
                CGFloat yasou=1.0;
                NSLog(@"原来的大小 imageData.leng=%ld k",imageData.length/1024);
                while (imageData.length > 1024*1024) {
                    NSLog(@"太大了 分享  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
                    imageData = UIImageJPEGRepresentation(tmp, yasou);
                    if (imageData.length > 10*1024*1024) {
                        yasou *=0.1;
                    } else if (imageData.length > 5*1024*1024){
                        yasou *=0.2;
                    } else if (imageData.length > 4*1024*1024){
                        yasou *=0.6;
                    } else if (imageData.length > 3*1024*1024){
                        yasou *=0.7;
                    } else if (imageData.length > 2*1024*1024){
                        yasou *=0.8;
                    } else if (imageData.length > 1*1024*1024){
                        yasou *=0.9;
                    }
                    if (yasou<0.01) {
                        break;
                    }
                    NSLog(@"压小后 分享  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(result,info);
                });
            });
        }
    }];
     */
}

@end
