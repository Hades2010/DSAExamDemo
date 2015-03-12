//
//  DSACheckButton.h
//  DSAExamDemo
//
//  Created by JinYong on 15-3-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DSACheckButtonStyle){
    DSACheckButtonStyleDefault = 0 ,
    DSACheckButtonStyleBox = 1 ,
    DSACheckButtonStyleRadio = 2
};
@interface DSACheckButton : UIControl {
    UILabel * label ;
    UIImageView * icon ;
    BOOL checked ;
    id value , delegate ;
    DSACheckButtonStyle style ;
    NSString * checkname ,* uncheckname ; // 勾选／反选时的图片文件名
}
@property ( retain , nonatomic )UILabel* label;
@property ( retain , nonatomic )UIImageView* icon;
@property ( assign )DSACheckButtonStyle style;
-(DSACheckButtonStyle)style;
-(void)setStyle:(DSACheckButtonStyle)st;
-(BOOL)isChecked;
-(void)setChecked:(BOOL)b;
@end
