//
//  DSAExamViewController.h
//  DSAExamDemo
//
//  Created by JinYong on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSAExamViewController : UIViewController
@property (nonatomic, assign) int indexQuestionNo;
@property (nonatomic, retain) NSMutableArray *examQuestionDetailArr;
@property (retain, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)actionClickSubmit:(id)sender;

@end
