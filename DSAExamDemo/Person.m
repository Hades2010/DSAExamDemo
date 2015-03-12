//
//  Person.m
//  DSAExamDemo
//
//  Created by JinYong on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Person.h"

@implementation Person
Person *sharedPerson = nil;
+ (Person *)sharedInstance{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken,^{
//        if (sharedPerson == nil) {
//            sharedPerson = [[Person alloc] init];
//        }
//    });
    
    @synchronized(self) {
        if (sharedPerson == nil) {
            sharedPerson = [[Person alloc] init];
        }
    }
    return sharedPerson;
}
- (void)showPerson {
    NSLog(@"%p",self);
}
- (void)releasePerson{
    sharedPerson = nil;
}
@end
