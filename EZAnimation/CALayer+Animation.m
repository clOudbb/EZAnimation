//
//  CALayer+Animation.m
//  EZAnimation
//
//  Created by qmtv on 2018/4/8.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import "CALayer+Animation.h"
#import "EZAnimationMaker.h"

@implementation CALayer (Animation)

- (EZAnimationManager *)groupAinmation:(EZMaker)maker
{
    EZAnimationMaker *make = [[EZAnimationMaker alloc] init];
    maker(make);
    return [EZAnimationManager new];
}

- (void)ez_animationWithType:(EZAnimationType)type makerAnimation:(EZMaker)maker
{
    EZAnimationMaker *m = [EZAnimationMaker new];
    maker(m);
    EZAnimationManager *manager = [[EZAnimationManager alloc] initWithType:type maker:m];
    CAAnimation *result = [manager install];
    [self addAnimation:result forKey:[m valueForKey:@"_key"]];
}

@end
