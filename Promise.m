//
//  Promise.m
//  ddcxComponent
//
//  Created by 邹启晨 on 15/02/2017.
//  Copyright © 2017 xiaoka. All rights reserved.
//

#import "Promise.h"
#import "objc/runtime.h"


@interface PromiseSingleton : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) NSMutableDictionary *excuteArrayDic;

@end

@implementation PromiseSingleton

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[PromiseSingleton alloc] init];
    });
    return sharedInstance;
}

//- (NSMutableArray *)excuteArray {
//    if (!_excuteArray) {
//        _excuteArray = [[NSMutableArray alloc] init];
//    }
//    return _excuteArray;
//}

- (NSMutableDictionary *)excuteArrayDic {
    if (!_excuteArrayDic) {
        _excuteArrayDic = [[NSMutableDictionary alloc] init];
    }
    return _excuteArrayDic;
}

@end


@interface Promise ()

@property (nonatomic, copy)Excute resolve;
@property (nonatomic, copy)Excute reject;
@property (nonatomic, copy)ErrorBlock error;


@end

@implementation Promise

- (instancetype)init {
    self = [self initWithResolve:nil Reject:nil];
    return self;
}

- (instancetype)initWithResolve:(Excute)resolve Reject:(Excute)reject {
    self = [super init];
    if (self) {
        _status = Pending;
        __weak Promise *weakSelf = self;
        
        Excute excute = ^id (id r){
            __strong Promise *strongSelf = weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
//                [[PromiseSingleton sharedInstance].excuteArray removeObject:strongSelf];
                [strongSelf excute:r];
            });
            return nil;
        };
        
        self.resolve = resolve ? : excute;
        self.reject = reject ? : excute;
        
//        [[PromiseSingleton sharedInstance].excuteArray addObject:self];
    }
    return self;
}

+ (Promise *)Promise:(PromiseBlock)promise {
    Promise *p = [[Promise alloc] init];
    promise(p.resolve, p.reject);
    return p;
}

- (Promise *)then:(Excute)resolve {
    return [self then:resolve :nil];
}

- (Promise *)then:(Excute)resolve :(Excute)reject {
    
    Promise *p = [[Promise alloc] initWithResolve:resolve Reject:reject];
    
    return p;
}

- (void)error:(ErrorBlock)errorB {
    self.error = errorB;
}

- (void)excute:(id)arg {
    id parg = arg;
//    [PromiseSingleton sharedInstance].excuteArray;
    NSMutableArray *excuteArray = nil;
    for (int i=0; i<excuteArray.count; i++) {
        Promise *p = excuteArray[i];
        parg = p.resolve(parg);
        if ([parg isKindOfClass:[NSError class]]) {
            p.status = Rejected;
            p.reject(parg);
        } else {
            p.status = Resolved;
        }
    }
    [excuteArray removeAllObjects];
}

- (void)dealloc {
    NSLog(@"Promise dealloc!");
}

@end
