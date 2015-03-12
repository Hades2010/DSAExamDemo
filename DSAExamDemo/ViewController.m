//
//  ViewController.m
//  DSAExamDemo
//
//  Created by JinYong on 15-3-11.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "ViewController.h"
#import "DSAExamViewController.h"
@interface ViewController ()
@property (nonatomic, retain) DSAExamViewController *examVC;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showExamVC];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _examVC = nil;
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [super dealloc];
    [_examVC release];
}
- (void)showExamVC{
    
    DSAExamViewController *exam = [[DSAExamViewController alloc] init];
    [exam.view setFrame:CGRectMake(250, 50, 774, 698)];
    self.examVC = exam;
    [exam release];
    [self.view addSubview:self.examVC.view];
    [self.view sendSubviewToBack:self.examVC.view];
    [self addChildViewController:self.examVC];
}
@end
