//
//  EZAnimationHeader.h
//  EZAnimation
//
//  Created by clOudbb on 2018/4/4.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#ifndef EZAnimationHeader_h
#define EZAnimationHeader_h

#ifdef DEBUG
# define EZLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define EZLog(...);
#endif
@class EZAnimationMaker;


typedef enum {
    kEZFillModeForwards = 0,
    kEZFillModeBackwards,
    kEZFillModeBoth,
    kEZFillModeRemoved
} kEZFillMode;

typedef enum {
    EZAnimationTypeOther = 0,
    EZAnimationTypeBasic,
    EZAnimationTypeKey,
    EZAnimationTypeSpring,
} EZAnimationType;

typedef void(^EZMaker)(EZAnimationMaker *maker);
typedef NSString EZAnimationKeyPath;

FOUNDATION_STATIC_INLINE bool ez_validString(NSString *str)
{
    return (str && ![str isEqualToString:@""] && str.length > 0);
}

#endif /* EZAnimationHeader_h */
