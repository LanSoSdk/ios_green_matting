//
//  LSOLiveBroadController.m
//  LanSongEditor_UI_ALL
//
//  Created by 我要变好看 on 2021/1/22.
//  Copyright © 2021 STK. All rights reserved.
//

#import "LSOLiveBroadController.h"
#import <LanSongEditorFramework/LanSongEditor.h>// 包含LanSongSDK所有的库头文件
 
 

@interface LSOLiveBroadController ()
 
{
    LSOCameraView *lansongView;
 
    NSURL *backGroundUrl;
      BOOL mainViewClickable;
}

 

@property  (nonatomic, strong)LSOCameraLive *lsoCamera;
 
 

@end

@implementation LSOLiveBroadController


-(BOOL)prefersStatusBarHidden{
    return  YES;
}


- (void)initLSOcameraView{
    
    lansongView = [[LSOCameraView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:lansongView];
    
    NSString *name = @"liveBroad_1080.jpg";
    backGroundUrl= LSOBundleURL(name);

}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    mainViewClickable = YES;
    [LSOCameraLive setCameraCaptureAsRGBA:YES];
    [self initLSOcameraView];
  
    [self addObserver];
    [self customUI];

}


#pragma mark --- UI ---
- (void)customUI{
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, 60, 60)];
    [backButton setTintColor:UIColor.whiteColor];
    [backButton setImage:[UIImage imageNamed:@"main_close"] forState:(UIControlStateNormal)];
    [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backButton];
    
    
 
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 80, 60, 60)];
    [btn setImage:[UIImage imageNamed:@"live_open"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"live_open_sele"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    btn.selected = YES;

 
    
    float y = self.view.frame.size.height - 130;
    NSArray *array = @[@"抠图强度",@"色彩保护"];
    for (int i = 0; i<2; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, y+(i*40), 60, 40)];
        label.backgroundColor = UIColor.clearColor;
        label.text = array[i];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColor.whiteColor;
        [self.view addSubview:label];
        
        
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(70, y+(i*40),self.view.frame.size.width-100 , 40)];
        slider.minimumTrackTintColor = [UIColor purpleColor];
        slider.maximumTrackTintColor = [UIColor whiteColor];
        slider.tag = i;
        [slider addTarget:self action:@selector(sliderChageValue:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
        
        if (i == 0) {
            slider.minimumValue = 0.0;
            slider.maximumValue = 1.0;
            slider.value = [self.lsoCamera getCameraLayer].greenMattingLevel;

        }else{
            slider.minimumValue = 1.0;
            slider.maximumValue = 100.0;
            slider.value = [self.lsoCamera getCameraLayer].greenMattingColorHoldLevel;
        }
        
        NSLog(@"%f,%f",[self.lsoCamera getCameraLayer].greenMattingLevel,[self.lsoCamera getCameraLayer].greenMattingColorHoldLevel);
        
    }
 
    
    
}

-(void)clickBackButton{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)sliderChageValue:(UISlider *)slider{
    NSLog(@"value = %f",slider.value);
    
    LSOCamLayer *layer= [self.lsoCamera getCameraLayer];
    int tag = (int)slider.tag;
    if (tag == 0) {
        layer.greenMattingLevel = slider.value;
     }else{
        layer.greenMattingColorHoldLevel = slider.value;

    }
}

-(void)clickBtn:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.lsoCamera.isGreenMatting = btn.selected;
}

 
#pragma mark --- 底层处理 ----

- (void)addObserver {
    [self removeObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startPreview];
}

#pragma mark -- 加载摄像头画面 --
- (void)startPreview
{
    if(_lsoCamera==nil){
        _lsoCamera=[[LSOCameraLive alloc] initFullScreen2:lansongView isFrontCamera:NO];
    }
    
    _lsoCamera.disableTouchEvent = YES;
    
    [_lsoCamera startPreview];
    _lsoCamera.isGreenMatting=YES;
    
    //可能是home键返回的, 则恢复之前的图片或视频;
    if (backGroundUrl) {
        [_lsoCamera setBackGroundUrl:backGroundUrl audioVolume:1.0 handler:^(LSOCamLayer * _Nonnull layer) {
            
        }];
    }
    
 
  
 
}

 
 
- (void)stopPreview
{
    if (_lsoCamera!=nil) {
        [_lsoCamera stopPreview];
        _lsoCamera=nil;
    }
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self stopPreview];
}

- (void)applicationDidEnterBackground:(NSNotification *)info {
    [self stopPreview];
    
 
}

- (void)applicationDidBecomeActive:(NSNotification *)info {
    [self startPreview];
}

 



-(void)dealloc{
    [self stopPreview];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end

