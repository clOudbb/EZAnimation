//
//  EZAnimationManager.m
//  EZAnimation
//
//  Created by clOudbb on 2018/4/4.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import "EZAnimationManager.h"
#import "EZAnimationMaker.h"
#import "EZAnimationProperty.h"
EZAnimationKeyPath * const EZAnimationKeyPathPosition = @"position";
EZAnimationKeyPath * const EZAnimationKeyPathPositionX = @"position.x";
EZAnimationKeyPath * const EZAnimationKeyPathPositionY = @"position.y";

EZAnimationKeyPath * const EZAnimationKeyPathTransformScale = @"transform.scale";
EZAnimationKeyPath * const EZAnimationKeyPathTransformScaleX = @"transform.scale.x";
EZAnimationKeyPath * const EZAnimationKeyPathTransformScaleY = @"transform.scale.y";
EZAnimationKeyPath * const EZAnimationKeyPathTransformScaleZ = @"transform.scale.z";

EZAnimationKeyPath * const EZAnimationKeyPathTransformRotationX = @"transform.rotation.x";
EZAnimationKeyPath * const EZAnimationKeyPathTransformRotationY = @"transform.rotation.y";
EZAnimationKeyPath * const EZAnimationKeyPathTransformRotationZ = @"transform.rotation.z";

EZAnimationKeyPath * const EZAnimationKeyPathTransformTranslation = @"transform.translation";
EZAnimationKeyPath * const EZAnimationKeyPathTransformTranslationX = @"transform.translation.x";
EZAnimationKeyPath * const EZAnimationKeyPathTransformTranslationY = @"transform.translation.y";
EZAnimationKeyPath * const EZAnimationKeyPathTransformTranslationZ = @"transform.translation.z";

EZAnimationKeyPath * const EZAnimationKeyPathBounds = @"bounds";

EZAnimationKeyPath * const EZAnimationKeyPathAnchorPoint = @"anchorPoint";

EZAnimationKeyPath * const EZAnimationKeyPathCornerRadius = @"cornerRadius";

EZAnimationKeyPath * const EZAnimationKeyPathZPosition = @"zPosition";

EZAnimationKeyPath * const EZAnimationKeyPathBackgroundColor = @"backgroundColor";
EZAnimationKeyPath * const EZAnimationKeyPathBorderColor = @"borderColor";
EZAnimationKeyPath * const EZAnimationKeyPathBorderWidth = @"borderWidth";

EZAnimationKeyPath * const EZAnimationKeyPathOpacity = @"opacity";

static NSString * const ez_keyPath = @"_keyP";

@implementation EZAnimationManager
{
    EZAnimationType _type;
    EZAnimationMaker *_maker;
    CAAnimationGroup *_group;
}

- (instancetype)initWithType:(EZAnimationType)type maker:(EZAnimationMaker *)maker
{
    self = [super init];
    if (self) {
        _type = type;
        _maker = maker;
    }
    return self;
}

static inline bool propertyFilter(CAAnimation *ani, EZAnimationProperty *pro)
{
    if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(duration))]) {
        ani.duration = [pro.value doubleValue];
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(fillMode))]) {
        ani.fillMode = [pro.value stringValue];
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(removeOnCompletion))]) {
        ani.removedOnCompletion = [pro.value boolValue];
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(autoreverses))]) {
        ani.autoreverses = [pro.value boolValue];
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(repeatCount))]) {
        ani.repeatCount = [pro.value floatValue];
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(repeatDuration))]) {
        ani.repeatDuration = [pro.value doubleValue];
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(speed))]) {
        ani.speed = [pro.value floatValue];
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(beginTime))]) {
        ani.beginTime = [pro.value doubleValue];
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(timingFunction))]) {
        ani.timingFunction = pro.value;
        return true;
    }
    return false;
}

static inline void propertyBaseFilter(CABasicAnimation* ani, EZAnimationProperty *pro)
{
    if (propertyFilter(ani, pro)) return;
    if (pro.type != EZAnimationTypeBasic) return;
    if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(toValue))]) {
        ani.toValue = pro.value;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(fromValue))]) {
        ani.fromValue = pro.value;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(byValue))]) {
        ani.byValue = pro.value;
    }
}

#pragma mark -

- (CAAnimation *)install
{
    CAAnimation *ani = nil;
    switch (_type) {
        case EZAnimationTypeBasic:
        {
            if (!ez_validString([_maker valueForKeyPath:ez_keyPath])) {
                if (DEBUG) {
                    @throw [NSException exceptionWithName:NSStringFromClass([self class]) reason:@"Must be nonnull" userInfo:nil];
                }
            }
            ani = [CABasicAnimation animationWithKeyPath:[_maker valueForKeyPath:ez_keyPath]];
            CABasicAnimation *base = (CABasicAnimation *)ani;
            @autoreleasepool {
                for (EZAnimationProperty *pro in _maker.animationPropertys) {
                    propertyBaseFilter(base, pro);
                }
            }
            return base;
        }
            break;
        case EZAnimationTypeKey:
        {
            
        }
            break;
        case EZAnimationTypeSpring:
        {
            
        }
            break;
            
        default:
            break;
    }
    return ani;
}

- (CAAnimationGroup *)group
{
    CAAnimationGroup *g = [CAAnimationGroup animation];
    self->_group = g;
    @autoreleasepool {
        for (EZAnimationProperty *pro in _maker.animationPropertys) {
            propertyFilter(g, pro);
        }
    }
    return g;
}

- (CAAnimation *)childAnimation
{
    return [self install];
}

@end
