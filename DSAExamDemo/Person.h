//
//  Person.h
//  DSAExamDemo
//
//  Created by JinYong on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
+ (Person *)sharedInstance;
- (void)showPerson;
- (void)releasePerson;
@end
