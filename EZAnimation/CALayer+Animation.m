//
//  CALayer+Animation.m
//  EZAnimation
//
//  Created by clOudbb on 2018/4/8.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import "CALayer+Animation.h"
#import "EZAnimationMaker.h"
#import <objc/runtime.h>

@implementation CALayer (Animation)

- (void)changeAnchorPoint:(bool)isNormal
{
    if (isNormal) {
        self.anchorPoint = CGPointMake(0, 0);
    }
}

#pragma mark - public

- (EZAnimationManager *)groupAinmation:(EZMaker)maker
{
    EZAnimationMaker *m = [[EZAnimationMaker alloc] init];
    maker(m);
    [self changeAnchorPoint:m.isNormalCoordinate];
    
    EZAnimationManager *manager = [[EZAnimationManager alloc] initWithType:EZAnimationTypeOther maker:m];
    CAAnimationGroup *group = [manager group];
    group.animations = self.groupAnimations;
    [self addAnimation:group forKey:[m valueForKey:@"_key"]];
    return manager;
}

- (CALayer *)childWithType:(EZAnimationType)type makeAnimation:(EZMaker)maker
{
    EZAnimationMaker *m = [EZAnimationMaker new];
    maker(m);
    [self changeAnchorPoint:m.isNormalCoordinate];

    EZAnimationManager *manager = [[EZAnimationManager alloc] initWithType:type maker:m];
    if (!self.groupAnimations) {
        self.groupAnimations = [@[] mutableCopy];
    }
    CAAnimation *ani = [manager childAnimation];
    [self.groupAnimations addObject:ani];
    return self;
}

- (void)ez_animationWithType:(EZAnimationType)type makerAnimation:(EZMaker)maker
{
    EZAnimationMaker *m = [EZAnimationMaker new];
    maker(m);
    [self changeAnchorPoint:m.isNormalCoordinate];

    EZAnimationManager *manager = [[EZAnimationManager alloc] initWithType:type maker:m];
    CAAnimation *result = [manager install];
    NSString *key = [m valueForKey:@"_key"];
    if (!ez_validString(key)) {
        EZLog(@"animation key is null");
    }
    [self addAnimation:result forKey:key];
}

- (void)pause
{
    CFTimeInterval pausetime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0;
    self.timeOffset = pausetime;
}

- (void)resume
{
    CFTimeInterval pausetime = self.timeOffset;
    self.timeOffset = 0.f;
    self.beginTime = 0.f;
    self.speed = 1.f;
    CFTimeInterval resumetime = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausetime;
    self.beginTime = resumetime;
}

#pragma mark - setter getter

- (void)setGroupAnimations:(NSMutableArray<CAAnimation *> *)groupAnimations
{
    objc_setAssociatedObject(self, @selector(groupAnimations), groupAnimations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray<CAAnimation *> *)groupAnimations
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
