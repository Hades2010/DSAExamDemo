//
//  DSAExamQOptionButton.m
//  DSAExamDemo
//
//  Created by JinYong on 15-3-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DSAExamQOptionButton.h"

@implementation DSAExamQOptionButton
{
//    SelectOptionCompleted mySelectBlock;
}
- (void)setOptionType:(DSAExamOptionType)optionType{
    _optionType = optionType;
    switch (optionType) {
        case DSAExamOptionTypeSingle:
            {
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
                [self.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
                [self setTitle:@"〇" forState:UIControlStateNormal];
                [self setTitle:@"√" forState:UIControlStateSelected];
            }
            break;
        case DSAExamOptionTypeMultipe:
            {
                [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
                [self.titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
                [self setTitle:@"口" forState:UIControlStateNormal];
                [self setTitle:@"√" forState:UIControlStateSelected];
            }
            break;
        default:
            break;
    }
}
- (void)setSelectOptionCompletionBlock:(SelectOptionCompleted)block{
    _selectBlock = [block copy];
}
@end
