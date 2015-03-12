//
//  DSAExamQuestionView.h
//  DSAExamDemo
//
//  Created by JinYong on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SlideQuestionCompleted)(int questionNo);
typedef void(^ChooseOptionsCompleted)(int questionNo, NSString *optiongID, BOOL isSelected, int btnType);
@interface DSAExamQuestionView : UIView
@property (nonatomic, retain) NSMutableArray *optionArr;
@property (nonatomic, retain) NSMutableArray *selectOptionArr;
- (void)setSlideCompletionBlock:(SlideQuestionCompleted)block;
- (void)setChooseOptionCompletionBlock:(ChooseOptionsCompleted)block;
@end
