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
        if ([ani isKindOfClass:[CASpringAnimation class]] && [pro.value doubleValue] == 0) {
            CASpringAnimation *spring = (CASpringAnimation *)ani;
            ani.duration = spring.settlingDuration;
            return true;
        }
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

static inline bool propertyBaseFilter(CABasicAnimation* ani, EZAnimationProperty *pro)
{
    if (propertyFilter(ani, pro)) return true;
    if (pro.type != EZAnimationTypeBasic && pro.type != EZAnimationTypeSpring) return true;
    if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(toValue))]) {
        ani.toValue = pro.value;
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(fromValue))]) {
        ani.fromValue = pro.value;
        return true;
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(byValue))]) {
        ani.byValue = pro.value;
        return true;
    }
    return false;
}

static inline void propertySpringFilter(CASpringAnimation *spring, EZAnimationProperty *pro)
{
    if (propertyBaseFilter(spring, pro)) return;
    if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(mass))]) {
        spring.mass = [pro.value floatValue];
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(stiffness))]) {
        spring.stiffness = [pro.value floatValue];
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(damping))]) {
        spring.damping = [pro.value floatValue];
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(initialVelocity))]) {
        spring.initialVelocity = [pro.value floatValue];
    }
}

static inline void propertyKeyframeFilter(CAKeyframeAnimation *keyAnimation, EZAnimationProperty *pro)
{
    if (propertyFilter(keyAnimation, pro)) return;
    if (pro.type != EZAnimationTypeKey) return;
    if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(values))]) {
        if ([pro.value isKindOfClass:[NSArray class]]) {
            keyAnimation.values = pro.value;
        }
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(keyTimes))]) {
        if ([pro.value isKindOfClass:[NSArray class]]) {
            keyAnimation.keyTimes = pro.value;
        }
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(path))]) {
        keyAnimation.path = (__bridge CGPathRef _Nullable)(pro.value);
    } else if ([pro.propertyName isEqualToString:NSStringFromSelector(@selector(timingFunctions))]) {
        if ([pro.value isKindOfClass:[NSArray class]]) {
            keyAnimation.timingFunctions = pro.value;
        }
    }
}

#pragma mark -

- (CAAnimation *)install
{
    CAAnimation *ani = nil;
    if (!ez_validString([_maker valueForKeyPath:ez_keyPath])) {
        if (DEBUG) {
            @throw [NSException exceptionWithName:NSStringFromClass([self class]) reason:@"Must be nonnull" userInfo:nil];
        }
    }
    switch (_type) {
        case EZAnimationTypeBasic:
        {
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
            ani = [CAKeyframeAnimation animationWithKeyPath:[_maker valueForKeyPath:ez_keyPath]];
            CAKeyframeAnimation *key = (CAKeyframeAnimation *)ani;
            @autoreleasepool {
                for (EZAnimationProperty *pro  in _maker.animationPropertys) {
                    propertyKeyframeFilter(key, pro);
                }
            }
            return key;
        }
            break;
        case EZAnimationTypeSpring:
        {
            ani = [CASpringAnimation animationWithKeyPath:[_maker valueForKeyPath:ez_keyPath]];
            CASpringAnimation *spring = (CASpringAnimation *)ani;
            @autoreleasepool {
                for (EZAnimationProperty *pro in _maker.animationPropertys) {
                    propertySpringFilter(spring, pro);
                }
            }
            return spring;
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
