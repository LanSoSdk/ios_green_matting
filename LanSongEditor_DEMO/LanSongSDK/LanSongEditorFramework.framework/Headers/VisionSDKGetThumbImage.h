//
//  VisionSDKGetThumbImage.h
//  LanSongEditorFramework
//
//  Created by sno on 2021/7/16.
//  Copyright © 2021 sno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VisionSDKGetThumbImage : NSObject


- (id)initWithVideoUrl:(NSURL *)url;

/// 获取一个视频的
/// @param handler 异步返回的每一帧视频缩略图, 一秒钟返回一帧, 缩略图大小是192x192;
- (void)startGetThumbnailWithHandler:(void (^)(UIImage *image, BOOL finish, BOOL error))handler;
@end

NS_ASSUME_NONNULL_END
