//
//  ViewController.m
//  Promise
//
//  Created by 邹启晨 on 19/02/2017.
//  Copyright © 2017 errun. All rights reserved.
//

#import "ViewController.h"
//#import "Promise.h"
#import "PromiseKit/Promise.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self test];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)test {
    
//    [[[[[self getJson:@""] then:^id(id x) {
//        NSLog(@"%@", x);
//        // 转变成 user
//        return @"get user";
//    }] then:^id(id x) {
//        NSLog(@"%@", x);
//        // 从 user 里的 friends 列表里取出 bestFriend
//        return @"get bestFriend";
//    }] then:^id(id x) {
//        NSLog(@"%@", x);
//        // return @"bestFriend.remove()";
//        return nil;
//    }] error:^(NSError *e) {
//        
//    }];
    
//    [[[[self getJson:@""] then:^id(id x) {
//        NSLog(@"%@", x);
//        return @"get user";
//    } :nil] then:^id(id x) {
//        NSLog(@"%@", x);
//        return @"get bestFriend";
//    } :nil] then:^id(id x) {
//        NSLog(@"%@", x);
//        return nil;
//    } :nil] ;
    
    [self getJson:@""].then(^(id x) {
        NSLog(@"%@", x);
        return @"get user";
    }).then(^(id x) {
        NSLog(@"%@", x);
        return @"get bestFriend";
    });
}

//- (Promise *)getJson:(NSString *)url {
////    Promise *p = [Promise Promise:^(Excute resolve, Excute reject) {
////        NSLog(@"Promise");
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
////                       dispatch_get_main_queue(), ^{
////                           BOOL success = YES;
////                           if (success) {
////                               resolve(@"resolve");
////                           } else {
////                               reject(@"reject");
////                           }
////        });
////    }];
////    return p;
//}

- (PMKPromise *)getJson:(NSString *)url {
    PMKPromise *p = [PMKPromise new:^(PMKFulfiller fulfill, PMKRejecter reject) {
        NSLog(@"Promise");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                       dispatch_get_main_queue(), ^{
                           BOOL success = YES;
                           if (success) {
                               fulfill(@"resolve");
                           } else {
                               NSError *error = [NSError errorWithDomain:@"" code:-1 userInfo:@{}];
                               reject(error);
                           }
                       });
    }];
    return p;
}

@end
