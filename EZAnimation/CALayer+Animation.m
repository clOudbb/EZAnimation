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

- (EZAnimationManager *)groupAinmation:(EZMaker)maker
{
    EZAnimationMaker *make = [[EZAnimationMaker alloc] init];
    maker(make);
    EZAnimationManager *manager = [[EZAnimationManager alloc] initWithType:EZAnimationTypeGroup maker:make];
    CAAnimationGroup *group = [manager group];
    group.animations = self.groupAnimations;
    [self addAnimation:group forKey:[make valueForKey:@"_key"]];
    return manager;
}

- (CALayer *)childWithType:(EZAnimationType)type makeAnimation:(EZMaker)maker
{
    EZAnimationMaker *m = [EZAnimationMaker new];
    maker(m);
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
    EZAnimationManager *manager = [[EZAnimationManager alloc] initWithType:type maker:m];
    CAAnimation *result = [manager install];
    [self addAnimation:result forKey:[m valueForKey:@"_key"]];
}

- (void)setGroupAnimations:(NSMutableArray<CAAnimation *> *)groupAnimations
{
    objc_setAssociatedObject(self, @selector(groupAnimations), groupAnimations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray<CAAnimation *> *)groupAnimations
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
