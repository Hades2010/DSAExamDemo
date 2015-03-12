//
//  DSAExamViewController.m
//  DSAExamDemo
//
//  Created by JinYong on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DSAExamViewController.h"
#import "DSAExamQuestionView.h"
#import "DSAExamQuestionBottomView.h"
@interface DSAExamViewController ()
@property DSAExamQuestionView *examQuestionView;
@property DSAExamQuestionBottomView *examQuestionBottomView;
@end

@implementation DSAExamViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initExamQuestionDeatilArray];
    [self initExamContentView];
    [self setIndexQuestionNo:0];
    // Do any additional setup after loading the view from its nib.
}

- (void)initExamQuestionDeatilArray{
    _examQuestionDetailArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i++) {
        NSMutableArray *optionSet = [NSMutableArray array];
        [_examQuestionDetailArr addObject:optionSet];
    }
    NSLog(@"%@",_examQuestionDetailArr);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_submitBtn release];
    [super dealloc];
    [self removeObserver:self.examQuestionBottomView forKeyPath:@"indexQuestionNo" context:NULL];
    [self removeObserver:self.examQuestionView forKeyPath:@"indexQuestionNo" context:NULL];
}

- (void)setIndexQuestionNo:(int)indexQuestionNo {
    if (indexQuestionNo == _indexQuestionNo) return;
//    [self willChangeValueForKey:@"indexQuestionNo"];
    _indexQuestionNo = indexQuestionNo;
//    [self didChangeValueForKey:@"indexQuestionNo"];
}

- (void)initExamContentView{
    DSAExamQuestionView *examQuestion = [[DSAExamQuestionView alloc] initWithFrame:CGRectMake(0, 52, 774, 498)];
    [examQuestion setBackgroundColor:[UIColor lightTextColor]];
    self.examQuestionView = examQuestion;
    [self.view addSubview:self.examQuestionView];
    [examQuestion release];
    
    [self addObserver:self.examQuestionView forKeyPath:@"indexQuestionNo" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    DSAExamQuestionBottomView *examQuestionBottom = [[DSAExamQuestionBottomView alloc] initWithFrame:CGRectMake(0, 552, 774, 80)];
    [examQuestionBottom setBackgroundColor:[UIColor lightGrayColor]];
    self.examQuestionBottomView = examQuestionBottom;
    [self.view addSubview:self.examQuestionBottomView];
    [examQuestionBottom release];
    
    [self addObserver:self.examQuestionBottomView forKeyPath:@"indexQuestionNo" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    __block DSAExamViewController *weakEVC = self;
    
    [self.examQuestionView setSlideCompletionBlock:^(int questionNo) {
        DSAExamViewController *strongEVC = weakEVC;
        [strongEVC setIndexQuestionNo:questionNo];
    }];
    
    [self.examQuestionView setChooseOptionCompletionBlock:^(int questionNo, NSString *optiongID, BOOL isSelected, int btnType) {
        NSMutableArray *arr = [_examQuestionDetailArr objectAtIndex:questionNo];
        NSLog(@"%@第%d题的选项%@被%@",(btnType == 0)?@"单选||":@"多选||",questionNo,optiongID,isSelected?@"选中":@"取消");
        if (btnType == 0) {
            //单选
            if (!isSelected) return;

            [arr removeAllObjects];
            [arr addObject:optiongID];
            
        } else {
            //多选
            if (isSelected) {
                if (![arr containsObject:optiongID]) {
                    [arr addObject:optiongID];
                }
            } else {
                if ([arr containsObject:optiongID]) {
                    [arr removeObject:optiongID];
                }
            }
        }
        
    }];

    
    [self.examQuestionBottomView setSelectCompletionBlock:^(int questionNo) {
        DSAExamViewController *strongEVC = weakEVC;
        [strongEVC setIndexQuestionNo:questionNo];
    }];
    
    
}

- (IBAction)actionClickSubmit:(id)sender {
    NSLog(@"答题内容:%@",_examQuestionDetailArr);
}
@end
