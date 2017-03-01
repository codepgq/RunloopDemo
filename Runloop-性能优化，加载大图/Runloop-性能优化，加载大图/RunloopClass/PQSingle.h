//
//  PQSingle.h
//  SingleClassDemo
//
//  Created by Mac on 16/12/21.
//  Copyright © 2016年 Mac. All rights reserved.
//

#ifndef PQSingle_h
#define PQSingle_h

#define PQSINGLE_H(name) +(instancetype)share##name;

#if __has_feature(objc_arc)

#define PQSINGLE_M(name) static id _singleManager = nil;\
+ (instancetype)share##name{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _singleManager = [[self alloc] init];\
    });\
    return _singleManager;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _singleManager = [super allocWithZone:zone];\
    });\
    return _singleManager;\
}\
\
- (id)mutableCopy{\
    return _singleManager;\
}\
\
- (id)copy{\
    return _singleManager;\
}

#else

#define PQSINGLE_M(name) static id _singleManager = nil;\
+ (instancetype)share##name{\
return [[self alloc]init];\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_singleManager = [super allocWithZone:zone];\
});\
return _singleManager;\
}\
\
- (id)mutableCopy{\
return _singleManager;\
}\
\
- (id)copy{\
return _singleManager;\
}\
- (oneway void)release{\
}\
\
- (instancetype)retain{\
    return _singleManager;\
}\
\
- (NSUInteger)retainCount{\
    return 9999;\
}\

#endif

#endif /* PQSingle_h */
