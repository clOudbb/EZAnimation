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

static NSString * const ez_animation_delegate_key_for_start = @"ez_animation_delegate_key_for_start";
static NSString * const ez_animation_delegate_key_for_completion = @"ez_animation_delegate_key_for_completion";

@interface CALayer(_Animation)<CAAnimationDelegate>
@property (nonatomic, strong, readwrite, nullable) NSMutableArray <CAAnimation *>*groupAnimations;
@end

@implementation CALayer (_Animation)
#pragma mark - setter getter

- (void)setGroupAnimations:(NSMutableArray<CAAnimation *> *)groupAnimations
{
    objc_setAssociatedObject(self, @selector(groupAnimations), groupAnimations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray<CAAnimation *> *)groupAnimations
{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - delegate
- (void)animationDidStart:(CAAnimation *)anim
{
    if ([anim valueForKeyPath:ez_animation_delegate_key_for_start]) {
        AnimationDelegateStart block = [anim valueForKeyPath:ez_animation_delegate_key_for_start];
        block();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim valueForKeyPath:ez_animation_delegate_key_for_completion]) {
        AnimationDelegateCompletion block = [anim valueForKeyPath:ez_animation_delegate_key_for_completion];
        block(flag);
    }
}

@end

@implementation CALayer (Animation)

- (void)changeAnchorPoint:(bool)isNormal
{
    if (isNormal) {
        self.anchorPoint = CGPointMake(0, 0);
    }
}

#pragma mark - public

- (void)ez_groupAinmation:(EZMaker)maker
{
    EZAnimationMaker *m = [[EZAnimationMaker alloc] init];
    maker(m);
    [self changeAnchorPoint:m.isNormalCoordinate];
    
    EZAnimationManager *manager = [[EZAnimationManager alloc] initWithType:EZAnimationTypeOther maker:m];
    CAAnimationGroup *group = [manager group];
    group.animations = self.groupAnimations;
    [self addAnimation:group forKey:[m valueForKey:@"_key"]];
}

- (void)ez_groupAnimationWithMaker:(EZMaker)maker start:(AnimationDelegateStart)start completion:(AnimationDelegateCompletion)completion
{
    EZAnimationMaker *m = [[EZAnimationMaker alloc] init];
    maker(m);
    [self changeAnchorPoint:m.isNormalCoordinate];
    
    EZAnimationManager *manager = [[EZAnimationManager alloc] initWithType:EZAnimationTypeOther maker:m];
    CAAnimationGroup *group = [manager group];
    [group setValue:start forKey:@"ez_animation_delegate_key_for_start"];
    [group setValue:completion forKey:@"ez_animation_delegate_key_for_completion"];
    group.animations = self.groupAnimations;
    [self addAnimation:group forKey:[m valueForKey:@"_key"]];
}

- (CALayer *)ez_childWithType:(EZAnimationType)type makeAnimation:(EZMaker)maker
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

- (void)ez_animationWithType:(EZAnimationType)type makerAnimation:(EZMaker)maker start:(AnimationDelegateStart)start completion:(AnimationDelegateCompletion)completion
{
    EZAnimationMaker *m = [EZAnimationMaker new];
    maker(m);
    [self changeAnchorPoint:m.isNormalCoordinate];
    
    EZAnimationManager *manager = [[EZAnimationManager alloc] initWithType:type maker:m];
    CAAnimation *result = [manager install];
    result.delegate = self;
    [result setValue:start forKey:@"ez_animation_delegate_key_for_start"];
    [result setValue:completion forKey:@"ez_animation_delegate_key_for_completion"];
    
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

@end
