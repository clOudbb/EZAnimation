//
//  EZAnimationProtocol.h
//  EZAnimation
//
//  Created by qmtv on 2018/4/20.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#ifndef EZAnimationProtocol_h
#define EZAnimationProtocol_h

#import "EZAnimationHeader.h"
@class CAMediaTimingFunction;
@class CAValueFunction;
@import CoreGraphics;

@protocol EZBaseAnimationProtocol <NSObject>
@property (nonatomic, copy, readonly) EZAnimationMaker *(^toValue)(id toValue);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^fromValue)(id fromValue);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^byValue)(id byValue);
@end

@protocol EZPropertyAnimationProtocol <NSObject>
@property (nonatomic, copy, readonly) EZAnimationMaker *(^keyPath)(EZAnimationKeyPath *keyPath);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^additive)(bool additive);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^cumulative)(bool cumulative);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^valueFunction)(CAValueFunction *valueFunction);
@end

@protocol EZKeyAnimationProtocol <NSObject>
@property (nonatomic, copy, readonly) EZAnimationMaker *(^values)(NSArray *values);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^keyTimes)(NSArray *keyTimes);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^timingFunctions)(NSArray<CAMediaTimingFunction *> * timingFunctions);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^path)(CGPathRef path);
@end

@protocol EZSpringAnimationProtocol <NSObject>
@property (nonatomic, copy, readonly) EZAnimationMaker *(^mass)(float mass) API_AVAILABLE(ios(9.0));
@property (nonatomic, copy, readonly) EZAnimationMaker *(^stiffness)(float stiffness) API_AVAILABLE(ios(9.0));
@property (nonatomic, copy, readonly) EZAnimationMaker *(^damping)(float damping) API_AVAILABLE(ios(9.0));
@property (nonatomic, copy, readonly) EZAnimationMaker *(^initialVelocity)(float initialVelocity) API_AVAILABLE(ios(9.0));
@end


#endif /* EZAnimationProtocol_h */
