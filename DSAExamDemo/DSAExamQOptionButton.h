//
//  DSAExamQOptionButton.h
//  DSAExamDemo
//
//  Created by JinYong on 15-3-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DSAExamOptionType){
    DSAExamOptionTypeSingle = 0,//单选
    DSAExamOptionTypeMultipe = 1, //多选
    
};

typedef void(^SelectOptionCompleted)(NSString *questionID,NSString *optionID,BOOL isSelected);
@interface DSAExamQOptionButton : UIButton
@property (nonatomic, copy) NSString *questionID;
@property (nonatomic, copy) NSString *optionID;
@property (nonatomic, assign) DSAExamOptionType optionType;
@property (nonatomic, assign) SelectOptionCompleted selectBlock;
- (void)setSelectOptionCompletionBlock:(SelectOptionCompleted)block;
@end
