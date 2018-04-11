//
//  EZAnimationMaker.m
//  EZAnimation
//
//  Created by clOudbb on 2018/4/4.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import "EZAnimationMaker.h"
#import "EZAnimationProperty.h"
@import QuartzCore;

FOUNDATION_STATIC_INLINE NSString * getFillMode(kEZFillMode mode)
{
    switch (mode) {
        case kEZFillModeForwards:
            return kCAFillModeForwards;
        case kEZFillModeBackwards:
            return kCAFillModeBackwards;
        case kEZFillModeBoth:
            return kCAFillModeBoth;
        case kEZFillModeRemoved:
            return kCAFillModeRemoved;
        default:
            return kCAFillModeForwards;
    }
}

@interface EZAnimationMaker()
@end

@implementation EZAnimationMaker
{
    NSString *_key;
    NSString *_keyP;    //这里要声明一个原始的NSString，因为typeof的类名iOS不会识别为实现了NSCoding协议
}



//思路  用manager管理
//要有管理当前所有动画的功能
//注意协议处理

//缺少propertAnimation的属性

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSMutableArray<EZAnimationProperty *> *)animationPropertys
{
    if (!_animationPropertys) {
        _animationPropertys = [@[] mutableCopy];
    }
    return _animationPropertys;
}

#pragma mark - property getter

- (EZAnimationMaker *)with { return self; }

- (EZAnimationMaker *(^)(NSString *))forKey
{
    return ^id (NSString *key) {
        if (!ez_validString(key)) {
#if DEBUG
            NSLog(@"animation key is null");
#endif
        }
        self->_key = key;
        return self;
    };
}

- (EZAnimationMaker *(^)(EZAnimationKeyPath *))animKeyPath
{
    return ^id(EZAnimationKeyPath *keyPath) {
        self->_keyP = keyPath;
        return self;
    };
}

- (EZAnimationMaker *(^)(bool))autoreverses
{
    return ^id (bool autoreverses) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(autoreverses);
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(bool))removeOnCompletion
{
    return ^id (bool remove) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(remove);
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(float))speed
{
    return ^id (float speed) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(speed);
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(kEZFillMode))fillMode
{
    return ^id (kEZFillMode mode) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = getFillMode(mode);
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(float))repeatCount
{
    return ^id (float repeatCount) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(repeatCount);
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(CFTimeInterval))repeatDuration
{
    return ^id (CFTimeInterval rDuration) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(rDuration);
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(CFTimeInterval))timeOffset
{
    return ^id (CFTimeInterval offset) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(offset);
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(CFTimeInterval))beginTime
{
    return ^id (CFTimeInterval beginTime) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(beginTime);
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(CAMediaTimingFunction *))timingFunction
{
    return ^id (CAMediaTimingFunction *func) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = func;
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(float))duration
{
    return ^id(float duration) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(duration);
        p.propertyName = NSStringFromSelector(_cmd);
        [self.animationPropertys addObject:p];
        return self;
    };
}

#pragma mark -- key frame

- (EZAnimationMaker *(^)(NSArray *))values
{
    return ^id(NSArray *values) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = values;
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeKey;
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(NSArray *))keyTimes
{
    return ^id(NSArray *values) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = values;
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeKey;
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(NSArray<CAMediaTimingFunction *> *))timingFunctions
{
    return ^id(NSArray *values) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = values;
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeKey;
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(CGPathRef))path
{
    return ^id(CGPathRef path) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = (__bridge id _Nullable)(path);
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeKey;
        [self.animationPropertys addObject:p];
        return self;
    };
}

#pragma mark -- base

- (EZAnimationMaker *(^)(id))fromValue
{
    return ^id(id fromValue) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = fromValue;
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeBasic;
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(id))toValue
{
    return ^id(id toValue) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = toValue;
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeBasic;
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(id))byValue
{
    return ^id(id byValue) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = byValue;
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeBasic;
        [self.animationPropertys addObject:p];
        return self;
    };
}

#pragma mark -- spring

- (EZAnimationMaker *(^)(float))mass
{
    return ^id(float mass) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(mass);
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeSpring;
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(float))stiffness
{
    return ^id(float stif) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(stif);
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeSpring;
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(float))damping
{
    return ^id(float damping) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(damping);
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeSpring;
        [self.animationPropertys addObject:p];
        return self;
    };
}

- (EZAnimationMaker *(^)(float))initialVelocity
{
    return ^id(float initial) {
        EZAnimationProperty *p = [EZAnimationProperty new];
        p.value = @(initial);
        p.propertyName = NSStringFromSelector(_cmd);
        p.type = EZAnimationTypeSpring;
        [self.animationPropertys addObject:p];
        return self;
    };
}

#pragma mark --

- (EZAnimationMaker *(^)(bool))normalCoordinate
{
    return ^id(bool nomral) {
        self->_isNormalCoordinate = nomral;
        return self;
    };
}

@end
