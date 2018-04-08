//
//  CALayer+Animation.h
//  EZAnimation
//
//  Created by qmtv on 2018/4/8.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "EZAnimationHeader.h"
#import "EZAnimationManager.h"
#import "EZAnimationMaker.h"
@interface CALayer (Animation)

- (void)ez_animationWithType:(EZAnimationType)type makerAnimation:(EZMaker)maker;
 
- (EZAnimationManager *)groupAinmation:(EZMaker)maker;

@end
