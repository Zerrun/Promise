//
//  Promise.h
//  ddcxComponent
//
//  Created by 邹启晨 on 15/02/2017.
//  Copyright © 2017 xiaoka. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Promise;

typedef id (^Excute)(id x);

typedef void(^ErrorBlock)(NSError *e);

typedef void (^PromiseBlock)(Excute resolve, Excute reject);

typedef NS_ENUM(NSInteger, PromiseStatus)  {
    Pending = 0,
    Resolved ,
    Rejected
};

@interface Promise : NSObject

@property (nonatomic, assign) PromiseStatus status;

+ (Promise *)Promise:(PromiseBlock)promise;

- (Promise *)then:(Excute)resolve;

- (Promise *)then:(Excute)resolve :(Excute)reject;

- (void)error:(ErrorBlock)errorB;


@end
