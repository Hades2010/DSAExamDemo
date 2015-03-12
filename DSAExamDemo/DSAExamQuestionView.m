//
//  DSAExamQuestionView.m
//  DSAExamDemo
//
//  Created by JinYong on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DSAExamQuestionView.h"
#import "DSAExamQOptionButton.h"
#import <QuartzCore/QuartzCore.h>
@implementation DSAExamQuestionView
{
    UIScrollView *contentScrollView;
    SlideQuestionCompleted mySelectBlock;
    ChooseOptionsCompleted myChooseBlock;
    NSMutableArray *allSelectionOptions;
    int indexQNo;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        indexQNo = -1;
        _optionArr = [[NSMutableArray alloc] init];
        allSelectionOptions = [[NSMutableArray alloc] init];
        
        contentScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [contentScrollView setBackgroundColor:[UIColor lightTextColor]];
        [self addSubview:contentScrollView];
        
        [self setGesture];
    }
    return self;
}

- (void)showQuestionContent:(int)questionNo{
    
    for (UIView *cview in [contentScrollView subviews]) {
        if (cview.tag > 99) {
            [cview removeFromSuperview];
        }
    }
    [contentScrollView setContentSize:CGSizeMake(contentScrollView.frame.size.width, contentScrollView.frame.size.height)];
    [_optionArr removeAllObjects];
    float lblY = 50;
    
    UILabel *titleQuestion = [[[UILabel alloc] initWithFrame:CGRectMake(50, lblY, 674, 30)] autorelease];
    titleQuestion.tag = 100;
    [titleQuestion setBackgroundColor:[UIColor clearColor]];
    [titleQuestion setTextColor:[UIColor darkGrayColor]];
    [titleQuestion setFont:[UIFont systemFontOfSize:17.0f]];
    [titleQuestion setText:[NSString stringWithFormat:@"题目%d:以下哪些颜色属于红旗L5外观颜色？",questionNo+1]];
    [contentScrollView addSubview:titleQuestion];
    
    lblY = lblY + titleQuestion.frame.size.height + 30;
    
    for (int i = 0; i < questionNo+1; i++) {
        
        DSAExamQOptionButton *optionBtn = [DSAExamQOptionButton buttonWithType:UIButtonTypeCustom];
        optionBtn.tag = 201+i;
        if (questionNo % 2) {
            [optionBtn setOptionType:DSAExamOptionTypeSingle];
        } else {
            [optionBtn setOptionType:DSAExamOptionTypeMultipe];
        }
        optionBtn.questionID = [NSString stringWithFormat:@"题目%d",questionNo+1];
        optionBtn.optionID = [NSString stringWithFormat:@"题目%d_选项%d",questionNo,i];
        
        __block typeof(self) weakSelf = self;
        [optionBtn setSelectOptionCompletionBlock:^(NSString *questionID, NSString *optionID, BOOL isSelected) {
            [weakSelf saveSelectState:questionID withOptionID:optionID withSelected:isSelected withType:optionBtn.optionType];
        }];
        
        [optionBtn setFrame:CGRectMake(50, lblY, 25, 25)];
        [optionBtn addTarget:self action:@selector(clickOption:) forControlEvents:UIControlEventTouchUpInside];
        if ([allSelectionOptions containsObject:optionBtn.optionID]) {
            optionBtn.selected = YES;
        } else {
            optionBtn.selected = NO;
        }
        
        [contentScrollView addSubview:optionBtn];
        
        [_optionArr addObject:optionBtn];
        
        UILabel *titleAnswer = [[UILabel alloc] initWithFrame:CGRectMake(80, lblY, 674, 30)];
        titleAnswer.tag = 101+i;
        [titleAnswer setBackgroundColor:[UIColor clearColor]];
        [titleAnswer setTextColor:[UIColor darkGrayColor]];
        [titleAnswer setFont:[UIFont systemFontOfSize:17.0f]];
        [titleAnswer setText:[NSString stringWithFormat:@"题目%d的答案%d",questionNo+1,i]];
        [contentScrollView addSubview:titleAnswer];
        lblY = lblY + titleAnswer.frame.size.height + 30;
        [titleAnswer release];
    }

    if (lblY > contentScrollView.frame.size.height) {
        [contentScrollView setContentSize:CGSizeMake(contentScrollView.frame.size.width, lblY)];
        
    }
}

- (void)clickOption:(DSAExamQOptionButton *)sender{
    if (sender.selected && sender.optionType == DSAExamOptionTypeSingle) return;
    
    BOOL isOldSelect = sender.selected;
    switch (sender.optionType) {
        case DSAExamOptionTypeSingle:
            {
                for (DSAExamQOptionButton *btn in _optionArr) {
                    if (btn.selected) {
                        btn.selected = NO;
                        [self calculateSelectedOption:btn.optionID withIsSelected:btn.selected];
                    }
                }
            }
            break;
        case DSAExamOptionTypeMultipe:
            
            break;
        default:
            break;
    }
    sender.selected = !isOldSelect;
    sender.selectBlock(sender.questionID,sender.optionID,sender.selected);
    [self calculateSelectedOption:sender.optionID withIsSelected:sender.selected];
}

- (void)calculateSelectedOption:(NSString *)optionID withIsSelected:(BOOL)isSelected{
    if (isSelected) {
        if (![allSelectionOptions containsObject:optionID]) {
            [allSelectionOptions addObject:optionID];
        }
    } else {
        if ([allSelectionOptions containsObject:optionID]) {
            [allSelectionOptions removeObject:optionID];
        }
    }
}
- (void)saveSelectState:(NSString *)qID withOptionID:(NSString *)pID withSelected:(BOOL) isSelected withType:(int)btnType{
    myChooseBlock(indexQNo,pID,isSelected,btnType);
}

- (void)dealloc {
    [super dealloc];
    [contentScrollView release];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    int oldValue = [change[NSKeyValueChangeOldKey] integerValue];
    int newValue = [change[NSKeyValueChangeNewKey] integerValue];
//    NSLog(@"考试内容 old : %d, new : %d",oldValue,newValue);
    if (indexQNo < 0 || oldValue != newValue) {
        [self showQuestionContent:newValue];
    }
    indexQNo = newValue;
    if (oldValue != newValue) {
        [self changeUIView:(newValue < oldValue)];
    }
    
}

- (void)setSlideCompletionBlock:(SlideQuestionCompleted)block{
    mySelectBlock = [block copy];
}

- (void)setChooseOptionCompletionBlock:(ChooseOptionsCompleted)block{
    myChooseBlock = [block copy];
}

- (void)changeUIView:(BOOL)isLeft{
    CATransition *animation=[CATransition animation];
    animation.delegate=self;
    animation.duration=0.3f;
    animation.timingFunction=UIViewAnimationCurveEaseInOut;
    animation.type=kCATransitionPush;
    animation.subtype=isLeft?kCATransitionFromLeft:kCATransitionFromRight;
    [self.layer addAnimation:animation forKey:@"push_view"];
}

- (void)setGesture{
    UISwipeGestureRecognizer *leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    UISwipeGestureRecognizer *rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self addGestureRecognizer:leftSwipeGestureRecognizer];
    [self addGestureRecognizer:rightSwipeGestureRecognizer];
    
    [leftSwipeGestureRecognizer release];
    [rightSwipeGestureRecognizer release];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (indexQNo == 19) return;
        mySelectBlock(++indexQNo);
        [self changeUIView:NO];
    }
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (indexQNo == 0) return;
        mySelectBlock(--indexQNo);
        [self changeUIView:YES];
    }
}
@end
