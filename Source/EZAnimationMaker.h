//
//  EZAnimationMaker.h
//  EZAnimation
//
//  Created by clOudbb on 2018/4/4.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZAnimationHeader.h"
#import "EZAnimationProtocol.h"

@class EZAnimationProperty;

@interface EZAnimationMaker : NSObject <EZBaseAnimationProtocol, EZKeyAnimationProtocol, EZSpringAnimationProtocol, EZPropertyAnimationProtocol>

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

#pragma mark --
@property (nonatomic, copy, readonly) EZAnimationMaker *(^forKey)(NSString *key);

#pragma mark -- custom features
@property (nonatomic, copy, readonly) EZAnimationMaker *with;

@property (nonatomic, copy, readonly) EZAnimationMaker *(^normalCoordinate)(bool normal);  /**< 使用UIView坐标系*/

@property (nonatomic, assign, readonly) bool isNormalCoordinate;   /**< 判断当前坐标系是UIView还是CALayer */

@property (nonatomic, strong, readonly) NSMutableArray <EZAnimationProperty *>*animationPropertys;

@end
