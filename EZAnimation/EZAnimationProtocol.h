//
//  EZAnimationProtocol.h
//  EZAnimation
//
//  Created by clOudbb on 2018/4/8.
//  Copyright © 2018年 qmtv. All rights reserved.
//

#ifndef EZAnimationProtocol_h
#define EZAnimationProtocol_h

@class EZAnimationMaker;
@protocol EZAnimationBaseProtocol <NSObject>
@required

@property (nonatomic, copy, readonly) EZAnimationMaker *(^toValue)(id toValue);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^fromValue)(id fromValue);
@property (nonatomic, copy, readonly) EZAnimationMaker *(^byValue)(id byValue);

@end
#endif /* EZAnimationProtocol_h */
