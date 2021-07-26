//
//  ViewController.m
//  LanSongEditor_DEMO
//
//  Created by liuqin on 2021/7/26.
//

#import "ViewController.h"
#import "LSOLiveBroadController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30,self.view.frame.size.height/2 , self.view.frame.size.width-60, 40)];
    [btn setTitle:@"绿幕抠图" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.purpleColor;
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}


-(void)clickBtn{
    LSOLiveBroadController *vc = [[LSOLiveBroadController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}

@end
