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

/**
 *  base keyframe spring 动画使用该api
 */
- (void)ez_animationWithType:(EZAnimationType)type makerAnimation:(EZMaker)maker;
/**
 * group动画子动画用该api组成
 */
- (CALayer *)childWithType:(EZAnimationType)type makeAnimation:(EZMaker)maker;
/**
 * group动画最后通过该api拼装
 */
- (EZAnimationManager *)groupAinmation:(EZMaker)maker;

/**
 * 动画立即暂停
 */
- (void)pause;
/**
 * 动画重新执行
 */
- (void)resume;
@end
