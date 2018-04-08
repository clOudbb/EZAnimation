//
//  CALayer+Animation.h
//  EZAnimation
//
//  Created by clOudbb on 2018/4/8.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EZAnimationHeader.h"
#import "EZAnimationManager.h"
#import "EZAnimationMaker.h"
@interface CALayer (Animation)

@property (nonatomic, strong) NSMutableArray <CAAnimation *>*groupAnimations;

- (void)ez_animationWithType:(EZAnimationType)type makerAnimation:(EZMaker)maker;

- (EZAnimationManager *)groupAinmation:(EZMaker)maker;

- (CALayer *)childWithType:(EZAnimationType)type makeAnimation:(EZMaker)maker;


@end
