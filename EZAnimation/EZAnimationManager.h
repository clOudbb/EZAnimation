//
//  EZAnimationManager.h
//  EZAnimation
//
//  Created by qmtv on 2018/4/4.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZAnimationHeader.h"
@import QuartzCore;
@class EZAnimationMaker;


@interface EZAnimationManager : NSObject

- (instancetype)initWithType:(EZAnimationType)type maker:(EZAnimationMaker *)maker;

- (EZAnimationManager *)childAniamtion:(EZMaker)maker;

- (CAAnimation *)install;
@end
