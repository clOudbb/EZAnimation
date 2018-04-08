//
//  EZAnimationMaker.m
//  EZAnimation
//
//  Created by qmtv on 2018/4/4.
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

@implementation EZAnimationMaker
{
    NSString *_key;
    bool _normalCoord;
}

//思路  用manager管理
//要有管理当前所有动画的功能
//注意协议处理
//要有代理方法的回调
//要有暂停功能
//增加一个将锚点更换为uiview坐标系的功能

- (instancetype)init
{
    self = [super init];
    if (self) {
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"bounds"];
        ani.toValue = @1;
        ani.fromValue = @0;
        ani.byValue = @0;
        ani.duration = 0.5;
        ani.fillMode = kCAFillModeForwards;
        ani.repeatCount = 1;
        ani.autoreverses = false;
        ani.removedOnCompletion = true;   //完成后是否销毁动画 forwards
        ani.speed = 0;
        ani.additive = false;   //该属性指定该属性动画是否以当前动画效果为基础。
        
        CAKeyframeAnimation *kAni = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        kAni.values = @[];
        kAni.keyTimes = @[];
        CGPathRef ref = NULL;
        kAni.path = ref;
        kAni.timingFunctions = @[];
        kAni.timeOffset = 0;   //时间偏移量  用来暂停动画
        
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
        self->_key = key;
        return self;
    };
}

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
//        p.type = EZAnimationTypeBasic;
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


@end
