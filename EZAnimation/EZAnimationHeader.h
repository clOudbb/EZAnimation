//
//  EZAnimationHeader.h
//  EZAnimation
//
//  Created by clOudbb on 2018/4/4.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#ifndef EZAnimationHeader_h
#define EZAnimationHeader_h
@class EZAnimationMaker;


typedef enum {
    kEZFillModeForwards = 0,
    kEZFillModeBackwards,
    kEZFillModeBoth,
    kEZFillModeRemoved
} kEZFillMode;

typedef enum {
    EZAnimationTypeBasic = 0,
    EZAnimationTypeKey,
    EZAnimationTypeSpring,
    EZAnimationTypeGroup,
} EZAnimationType;

typedef void(^EZMaker)(EZAnimationMaker *maker);
typedef NSString EZAnimationKeyPath;

FOUNDATION_STATIC_INLINE bool ez_validString(NSString *str)
{
    return (str && ![str isEqualToString:@""] && str.length > 0);
}

#endif /* EZAnimationHeader_h */
