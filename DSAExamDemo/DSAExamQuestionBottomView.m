//
//  DSAExamQuestionBottomView.m
//  DSAExamDemo
//
//  Created by JinYong on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DSAExamQuestionBottomView.h"

@implementation DSAExamQuestionBottomView
{
    UIButton *lastQuestionBtn;
    UIButton *preQuestionBtn;
    UIScrollView *questionNoScrollView;
    
    SelectQuestionCompleted mySelectBlock;
    
    int indexQNo;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        indexQNo = 0;
        
        preQuestionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [preQuestionBtn setFrame:CGRectMake(50, 20, 40, 40)];
        [preQuestionBtn setTitle:@"<<" forState:UIControlStateNormal];
        [preQuestionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [preQuestionBtn addTarget:self action:@selector(gotoPreQuestion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:preQuestionBtn];
        
        lastQuestionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [lastQuestionBtn setFrame:CGRectMake(680, 20, 40, 40)];
        [lastQuestionBtn setTitle:@">>" forState:UIControlStateNormal];
        [lastQuestionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [lastQuestionBtn addTarget:self action:@selector(gotoLastQuestion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lastQuestionBtn];
        
        questionNoScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(100, 20, 570, 40)];
        [questionNoScrollView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:questionNoScrollView];
        
        [self initQuestionNOView];
    }
    return self;
}

- (void)gotoPreQuestion:(id)sender {
    if (indexQNo == 0) return;
    mySelectBlock(--indexQNo);
}

- (void)gotoLastQuestion:(id)sender {    
    if (indexQNo == 19) return;
    mySelectBlock(++indexQNo);
}

- (void)gotoQuickQuestion:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    mySelectBlock(btn.tag - 101);
}

- (void)initQuestionNOView{
    int questionCount = 20;
    float qX = 10;
    float space_X = 20;
    
    for (int i = 0; i < questionCount; i++) {
        UIButton *QNOBTN = [UIButton buttonWithType:UIButtonTypeCustom];
        [QNOBTN setFrame:CGRectMake(qX, 0, 40, 40)];
        [QNOBTN setTag:(101+i)];
        [QNOBTN setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        [QNOBTN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [QNOBTN setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [QNOBTN addTarget:self action:@selector(gotoQuickQuestion:) forControlEvents:UIControlEventTouchUpInside];
        [questionNoScrollView addSubview:QNOBTN];
        
        qX = qX + QNOBTN.frame.size.width + space_X;
    }
    
    if (qX > questionNoScrollView.frame.size.width) {
        [questionNoScrollView setContentSize:CGSizeMake(qX, questionNoScrollView.frame.size.height)];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    int oldValue = [change[NSKeyValueChangeOldKey] integerValue];
    int newValue = [change[NSKeyValueChangeNewKey] integerValue];
    
    ((UIButton *)[self viewWithTag:(101+oldValue)]).selected = NO;
    ((UIButton *)[self viewWithTag:(101+newValue)]).selected = YES;
    
    CGFloat destX = 10 + 60*newValue;
    if (destX < questionNoScrollView.contentOffset.x || destX > questionNoScrollView.contentOffset.x + questionNoScrollView.bounds.size.width) {
        CGFloat X = destX;
        if (destX > questionNoScrollView.contentSize.width - questionNoScrollView.bounds.size.width) {
            X = questionNoScrollView.contentSize.width - questionNoScrollView.bounds.size.width;
        }
        [questionNoScrollView setContentOffset:CGPointMake(X, 0)];
    }
    indexQNo = newValue;
}

- (void)setSelectCompletionBlock:(SelectQuestionCompleted)block{
    mySelectBlock = [block copy];
}
@end
