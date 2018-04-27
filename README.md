# EZAnimation
[![Build Status](https://travis-ci.org/clOudbb/EZAnimation.svg?branch=master)](https://travis-ci.org/clOudbb/EZAnimation)
![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=103)
![CocoaPods](https://img.shields.io/cocoapods/v/EZAnimationObjc.svg)
![CocoaPods](https://img.shields.io/cocoapods/p/EZAnimationObjc.svg)
### desciption
A easy use iOS CoreAnimation Kit

### Feature
+ simple
+ chain
+ support most property for core animation kit

### Example
```javascript
[layer ez_animationWithType:EZAnimationTypeBasic makerAnimation:^(EZAnimationMaker *maker) {
   maker.fromValue(@0).toValue(@375).duration(10)
   .animKeyPath(EZAnimationKeyPathPositionX)
   .normalCoordinate(true);
}];
```

### CocoaPods

```javascript
# Your Podfile
platform :ios, '8.0'
pod 'EZAnimationObjc', '~> 0.0.5'
```

### Contact

+ [twitter](https://twitter.com/Zeng_a_niu)
