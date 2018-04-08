//
//  ViewController.m
//  EZAnimation
//
//  Created by qmtv on 2018/4/4.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import "ViewController.h"
#import "EZAnimation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    CALayer *layer;
//    [[layer groupAinmation:^(EZAnimationMaker *maker) {
//
//    }] childAniamtion:^(EZAnimationMaker *maker) {
//
//    }];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.frame = (CGRect){100, 100, 100 , 100};
    [self.view.layer addSublayer:layer];
    [layer ez_animationWithType:EZAnimationTypeBasic makerAnimation:^(EZAnimationMaker *maker) {
        maker.duration(1).fromValue(@0).toValue(@1).repeatCount(MAXFLOAT).autoreverses(true).animKeyPath(EZAnimationKeyPathOpacity);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
