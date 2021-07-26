//
//  LSOCameraView.h
//  LanSongEditorFramework
//
//  Created by sno on 2020/9/8.
//  Copyright © 2020 sno. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LanSongContext.h"
#import "LanSongFilter.h"

@class LSOCamLayer;

NS_ASSUME_NONNULL_BEGIN


@interface LSOCameraView : UIView











/**
 设置的输出数据的大小, 仅可设置一次, 并且宽高等于16的倍数, 建议是720x1280;或1080x1920
 */
@property (nonatomic, assign) CGSize outDataSize;


/**
 LSNEW
 设置outDataSize后, 每一帧都会通过这个block输出,工作在其他线程;
 输出的格式是: kCVPixelFormatType_32BGRA ; 宽高是设置的outDataSize
 len: 等于outDataSize.width * outDataSize.height *4;
 bgraPtr 是内部使用, 外部不要释放;
 */
@property(nonatomic, copy) void(^frameDataOutBlock)(int len , void *bgraPtr);












@end

NS_ASSUME_NONNULL_END

