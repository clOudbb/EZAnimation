//
//  EZAnimationMaker.h
//  EZAnimation
//
//  Created by clOudbb on 2018/4/4.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZAnimationHeader.h"

@class EZAnimationProperty;
@class CAMediaTimingFunction;
@import CoreGraphics;
@interface EZAnimationMaker : NSObject

#pragma mark -- common
@property (nonatomic, copy, readonly) EZAnimationMaker *(^duration)(float duration);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^fillMode)(kEZFillMode filleMode);
@property (nonatomic, copy ,readonly) EZAnimationMaker *(^autoreverses)(bool autoreverses);
@property (nonatomic, copy ,readonly) EZAnimationMaker *(^repeatCount)(float repeatCount);
@property (nonatomic, copy ,readonly) EZAnimationMaker *(^repeatDuration)(CFTimeInterval repeatDuration);
@property (nonatomic, copy ,readonly) EZAnimationMaker *(^speed)(float speed);
@property (nonatomic, copy ,readonly) EZAnimationMaker *(^timeOffset)(CFTimeInterval timeOffset);
@property (nonatomic, copy ,readonly) EZAnimationMaker *(^beginTime)(CFTimeInterval beginTime);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^removeOnCompletion)(bool removeOnCompletion);
@property (nonatomic, copy ,readonly) EZAnimationMaker *(^timingFunction)(CAMediaTimingFunction *timingFunction);

#pragma mark -- base
@property (nonatomic, copy, readonly) EZAnimationMaker *(^toValue)(id toValue);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^fromValue)(id fromValue);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^byValue)(id byValue);

#pragma mark -- keyframe
@property (nonatomic, copy, readonly) EZAnimationMaker *(^values)(NSArray *values);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^keyTimes)(NSArray *keyTimes);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^timingFunctions)(NSArray<CAMediaTimingFunction *> * timingFunctions);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^path)(CGPathRef path);

#pragma mark -- spring

@property (nonatomic, copy, readonly) EZAnimationMaker *(^mass)(float mass);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^stiffness)(float stiffness);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^damping)(float damping);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^initialVelocity)(float initialVelocity);

#pragma mark --
@property (nonatomic, copy, readonly) EZAnimationMaker *(^forKey)(NSString *key);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^animKeyPath)(EZAnimationKeyPath *animKeyPath);

#pragma mark -- custom features
@property (nonatomic, copy, readonly) EZAnimationMaker *with;
@property (nonatomic, copy, readonly) EZAnimationMaker *(^normalCoordinate)(bool normal);  /**<UIView坐标系*/
@property (nonatomic, assign, readonly) bool isNormalCoordinate;
@property (nonatomic, strong) NSMutableArray <EZAnimationProperty *>*animationPropertys;

@end
