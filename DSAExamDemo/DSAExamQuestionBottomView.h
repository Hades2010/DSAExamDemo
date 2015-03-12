//
//  DSAExamQuestionBottomView.h
//  DSAExamDemo
//
//  Created by JinYong on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectQuestionCompleted)(int questionNo);
@interface DSAExamQuestionBottomView : UIView
- (void)setSelectCompletionBlock:(SelectQuestionCompleted)block;
@end
