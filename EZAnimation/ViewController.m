//
//  ViewController.m
//  EZAnimation
//
//  Created by qmtv on 2018/4/4.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import "ViewController.h"
#import "EZAnimation.h"

typedef void (^ButtonBlock)(void);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupButton];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor orangeColor].CGColor;
    layer.frame = (CGRect){100, 100, 100 , 100};
    [self.view.layer addSublayer:layer];
    _layer = layer;
    
    //-- group animation
//    [[[layer ez_childWithType:EZAnimationTypeBasic makeAnimation:^(EZAnimationMaker *maker) {
//        maker.duration(5).animKeyPath(EZAnimationKeyPathOpacity).fromValue(@0).toValue(@1);
//    }] ez_childWithType:EZAnimationTypeBasic makeAnimation:^(EZAnimationMaker *maker) {
//        maker.duration(5).animKeyPath(EZAnimationKeyPathPositionY).fromValue(@100).toValue(@500);
//    }] groupAinmation:^(EZAnimationMaker *maker) {
//        maker.duration(5).autoreverses(true).repeatCount(MAXFLOAT);
//    }];

    //-- key animation
//    [layer ez_animationWithType:EZAnimationTypeKey makerAnimation:^(EZAnimationMaker *maker) {
//        maker.values(@[@50, @100, @300, @500]).keyTimes(@[@0, @0.5, @0.6, @1]).duration(5).animKeyPath(EZAnimationKeyPathPositionY);
//    }];
    
    //-- base
//    [layer ez_animationWithType:EZAnimationTypeBasic makerAnimation:^(EZAnimationMaker *maker) {
//        maker.fromValue(@0).toValue(@375).duration(10).animKeyPath(EZAnimationKeyPathPositionX).normalCoordinate(true);
//    }];
    
    [layer ez_animationWithType:EZAnimationTypeBasic makerAnimation:^(EZAnimationMaker *maker) {
        maker.fromValue(@0)
        .toValue(@375)
        .duration(10).normalCoordinate(true).fillMode(kEZFillModeForwards).removeOnCompletion(false).keyPath(EZAnimationKeyPathPositionX);
    } start:^{
        NSLog(@"start");
    } completion:^(bool flag) {
        if (flag) {
            NSLog(@"completion");
        }
        NSLog(@"%@", NSStringFromCGRect(_layer.presentationLayer.frame));
    }];
    
}

static CALayer *_layer;
- (void)setupButton
{
    UIButton *b1 = [self createButton:[UIColor orangeColor] frame:(CGRect){50, 500, 70, 30} title:@"pause"];
    [b1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *b2 = [self createButton:[UIColor grayColor] frame:(CGRect){255, 500, 70, 30} title:@"resume"];
    [b2 addTarget:self action:@selector(buttonActionSeco:) forControlEvents:UIControlEventTouchUpInside];

}

- (UIButton *)createButton:(UIColor *)color frame:(CGRect)frame title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:button];
    return button;
}

- (void)buttonAction:(UIButton *)button
{
    [_layer pause];
}

- (void)buttonActionSeco:(UIButton *)button
{
    [_layer resume];
}
     
     

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
