//
//  DSACheckButton.m
//  DSAExamDemo
//
//  Created by JinYong on 15-3-12.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "DSACheckButton.h"

@implementation DSACheckButton
@synthesize label,icon;
- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        icon =[[UIImageView alloc] initWithFrame :
               CGRectMake ( 10 , 0 , frame . size . height , frame . size . height )];
        [self setStyle:DSACheckButtonStyleRadio]; // 默认风格为方框（多选）样式
        //self.backgroundColor=[UIColor grayColor];
        [self addSubview:icon];
        label =[[ UILabel alloc ] initWithFrame : CGRectMake ( icon . frame . size . width + 24 , 0 ,
                                                              frame . size . width - icon . frame . size . width - 24 ,
                                                              frame . size . height )];
        label.backgroundColor =[ UIColor clearColor ];
        label.font =[ UIFont fontWithName : @"Arial" size : 20 ];
        label.textColor =[ UIColor
                            colorWithRed : 0xf9 / 255.0
                            green : 0xd8 / 255.0
                            blue : 0x67 / 255.0
                            alpha : 1 ];
        label.textAlignment = NSTextAlignmentLeft ;
        [self addSubview:label ];
        [self addTarget:self action:@selector (clicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
