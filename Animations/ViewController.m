//
//  ViewController.m
//  Animations
//
//  Created by 马少洋 on 16/5/20.
//  Copyright © 2016年 马少洋. All rights reserved.
//

#import "ViewController.h"
#import "AnimationTransactionViewController.h"
#import "PushViewController.h"





@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;
/** <#注释#> */
@property (nonatomic,retain)PushViewController * push;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
}
- (IBAction)buttonDidCliked:(id)sender {
    PushViewController * push = [[PushViewController alloc]init];
    self.push = push;
    [UIView transitionFromView:self.view toView:push.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished) {

    }];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureDidCliked)];
    [self.push.view addGestureRecognizer:tap];
}
- (void)tapGestureDidCliked{
    [UIView transitionFromView:self.push.view toView:self.view duration:0.5 options:UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished) {

    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
