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

typedef void(^AnimationDelegateStart)(void);
typedef void(^AnimationDelegateCompletion)(bool flag);

@interface CALayer (Animation)
/**
 *  base keyframe spring 动画使用该api
 */
- (void)ez_animationWithType:(EZAnimationType)type makerAnimation:(EZMaker)maker;
- (void)ez_animationWithType:(EZAnimationType)type makerAnimation:(EZMaker)maker start:(AnimationDelegateStart)start completion:(AnimationDelegateCompletion)completion;
/**
 * group动画子动画用该api组成
 */
- (CALayer *)ez_childWithType:(EZAnimationType)type makeAnimation:(EZMaker)maker;
/**
 * group动画最后通过该api拼装
 */
- (void)ez_groupAinmation:(EZMaker)maker;
- (void)ez_groupAnimationWithMaker:(EZMaker)maker start:(AnimationDelegateStart)start completion:(AnimationDelegateCompletion)completion;
/**
 * 动画立即暂停
 */
- (void)pause;
/**
 * 动画重新执行
 */
- (void)resume;


@property (nonatomic, assign, readonly, getter=isPause) bool isPausing;

@end
