//
//  EZAnimationProperty.h
//  EZAnimation
//
//  Created by qmtv on 2018/4/8.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZAnimationHeader.h"
@interface EZAnimationProperty : NSObject

@property (nonatomic, strong, nullable) id value;
@property (nonatomic, copy, nullable) NSString *propertyName;

@property (nonatomic, assign) EZAnimationType type;
@end
