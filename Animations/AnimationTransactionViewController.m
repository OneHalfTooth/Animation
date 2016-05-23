//
//  AnimationTransactionViewController.m
//  Animations
//
//  Created by 马少洋 on 16/5/20.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import "AnimationTransactionViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>







@interface AnimationTransactionViewController ()

@property (nonatomic,strong)CATextLayer *textLayer;

@end

@implementation AnimationTransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.textLayer = [[CATextLayer alloc]init];
    self.textLayer.bounds = CGRectMake(0, 0, 100, 21);
    self.textLayer.backgroundColor = [UIColor purpleColor].CGColor;
    self.textLayer.string = @"我是textLayer";
    self.textLayer.fontSize = 17;
    self.textLayer.foregroundColor = [UIColor blackColor].CGColor;
    self.textLayer.shadowColor = [UIColor redColor].CGColor;//shadowColor阴影颜色
    self.textLayer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
     self.textLayer.shadowOpacity = 1;//阴影透明度，默认0
     self.textLayer.shadowRadius = 3;//阴影半径，默认3
    [self.view.layer addSublayer:self.textLayer];
    /** 设定layer的位置 */
    self.textLayer.position = CGPointMake(150, 210.5);/** 这个点不好算，想要学习上谷歌 */
    /** 设定动画开始执行时候要参照的点 */
    self.textLayer.anchorPoint = CGPointMake(0.5, 0.5);/** 这个点不好算，想要学习上谷歌 */


    NSArray * array1 = @[@[@"变化圆角",@"旋转Z",@"阴影颜色",@"旋转X",@"旋转Y"],@[@"放大",@"缩小",@"走线",@"旋转X",@"旋转Y"]];
    NSArray * selArray1 = @[@[@"changeCornerRadius",@"changeRotation:",@"changeShaeColor",@"changeRotationX:",@"changeRotationY:"],@[@"scaleBig:",@"scaleSmoller:",@"lineRun:",@"changeRotationX:",@"changeRotationY:"]];
    CGFloat width = self.view.frame.size.width / 5 - 12;
    for (NSInteger j = 0; j < 2; j++) {
        NSArray * array = array1[j];
        NSArray * selArray = selArray1[j];
        for (NSInteger i = 0; i < 5; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(i * (10 + width) + 10, self.view.frame.size.height - 100 + (j * 50), width, 30);
            button.layer.cornerRadius = 5.f;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            button.layer.borderWidth = 0.5f;
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            button.backgroundColor = [UIColor blueColor];
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button addTarget:self action:NSSelectorFromString(selArray[i]) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:button];
        }
    }





}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self animationGroup];
}
#pragma mark -- 走个路径
/** 走个路径 */
- (void)lineRun:(UIButton *)button {

    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        UIBezierPath * bezier = [UIBezierPath bezierPath];
        [bezier moveToPoint:CGPointMake(0, 0)];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier addLineToPoint:CGPointMake(arc4random_uniform(375), arc4random_uniform(677))];
        [bezier closePath];
        CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.path = bezier.CGPath;
        animation.duration = 10;
        animation.rotationMode = kCAAnimationRotateAuto;
        //    animation.beginTime = 10;
        if (button) {
            [self.textLayer addAnimation:animation forKey:nil];
        }

        if (0) {
            dispatch_source_cancel(timer);
        }

    });
    dispatch_resume(timer);
}
#pragma mark -- 放大
/** 放大 */
- (CABasicAnimation *)scaleBig:(UIButton *)button {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = [NSNumber numberWithDouble:1.0];
    animation.toValue = [NSNumber numberWithDouble:8];
    animation.removedOnCompletion = NO;
    animation.duration = 5;
    animation.fillMode = kCAFillModeForwards;
    if(button){
        [self.textLayer addAnimation:animation forKey:nil];
    }
    return animation;
}
#pragma mark -- 缩小
/** 缩小 */
- (CABasicAnimation *)scaleSmoller:(UIButton *)button {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation.fromValue = [NSNumber numberWithDouble:1.5];
    animation.toValue = [NSNumber numberWithDouble:1.0];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    if(button){
        [self.textLayer addAnimation:animation forKey:nil];
    }
    return animation;
}
#pragma mark -- 动画组
/** 动画组 */
- (void)animationGroup {
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC,  0);
        dispatch_source_set_event_handler(timer, ^{
    
    
            if (0) {
                dispatch_source_cancel(timer);
            }
            NSArray * array = @[@"scaleBig:",@"scaleSmoller:",@"changeRotation:",@"changeRotationX:",@"changeRotationY:"];
            NSMutableArray * arr = [[NSMutableArray alloc]init];
            for (NSInteger i = 0; i < array.count; i++) {
                CABasicAnimation * animation = objc_msgSend(self, NSSelectorFromString(array[i]),nil);
                [arr addObject:animation];
            }
            /** 动画组 使所有的动画同时执行 */
            CAAnimationGroup * group = [CAAnimationGroup animation];
            group.duration = 3.f;
            [group setAnimations:arr];
            [self.textLayer addAnimation:group forKey:nil];
    
        });
    
        dispatch_resume(timer);
}
#pragma mark -- 旋转动画X
/** 旋转动画X */
- (CABasicAnimation *)changeRotationX:(UIButton *)button {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.toValue = [NSNumber numberWithFloat:3*M_PI];
    animation.duration = 3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    if (button) {
         [self.textLayer addAnimation:animation forKey:nil];
    }
//
    return  animation;
}
#pragma mark -- 旋转动画Y
/** 旋转动画Y */
- (CABasicAnimation *)changeRotationY:(UIButton *)button {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = [NSNumber numberWithFloat:3*M_PI];
    animation.duration = 3;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    if (button) {
         [self.textLayer addAnimation:animation forKey:nil];
    }
//
    return animation;

}
#pragma mark -- 旋转动画
/** 旋转动画 */
- (CABasicAnimation *)changeRotation:(UIButton *)button {
    CABasicAnimation * basic = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];/** 动画要改变的东西 transform.rotation.z*/

    basic.duration = 3;
    basic.delegate = self;
    basic.fromValue = [NSNumber numberWithFloat:0.0];/** 动画开始是的位置 */
    basic.toValue = [NSNumber numberWithDouble:1 * M_PI];/** 动画结束时的位置 *//** 相对位置 */
    basic.removedOnCompletion = NO;/** 动画做完之后是否回到原位 */
    basic.fillMode = kCAFillModeForwards;
    basic.repeatCount = 1;/** 动画循环次数 */ /** HUGE_VALF表示无限循环 */
    if (button) {
         [self.textLayer addAnimation:basic forKey:@"transform.rotation.z"];/** 开始动画 */
    }
//
    return  basic;
}
#pragma mark -- 改变阴影颜色
/** 改变阴影颜色 */
- (void)changeShaeColor {
        CABasicAnimation * basic = [CABasicAnimation animationWithKeyPath:@"shadowColor"];
    [CATransaction setAnimationDuration:3];
//        basic.delegate = self;
        basic.fromValue = (id)[UIColor redColor].CGColor;/** 设置开始颜色为红色 */
        basic.toValue = (id)[UIColor blueColor].CGColor;/** 结束颜色为蓝色 */

        basic.removedOnCompletion = NO;/** 动画结束之后不恢复原样 */
    basic.fillMode = kCAFillModeForwards;
        [self.textLayer addAnimation:basic forKey:@"shadowColor"];/** 设置动画的关键字为color */
}
#pragma mark -- 变化圆角
/** 变化圆角 */
- (void)changeCornerRadius {
    [CATransaction setAnimationDuration:3];/** 设置动画时间 */
    //        self.textLayer.frame = CGRectMake(100, 200, 200, 50);
    self.textLayer.anchorPointZ = 18;/** 设置layer的层级关系 */
    self.textLayer.opacity = (self.textLayer.opacity == 0.3f)? 1.0f :  0.3f ;/** 设置layer的透明 */
    self.textLayer.cornerRadius = (self.textLayer.cornerRadius == 5)? 0 : 5;/** 裁剪圆角了 */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
