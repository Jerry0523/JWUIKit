//
//  ViewController.m
//  JWUIKitDemo
//
//  Created by Jerry on 16/3/16.
//  Copyright © 2016年 Jerry Wong. All rights reserved.
//

#import "ViewController.h"
#import <JWUIKit/JWUIKit.h>

@interface ViewController ()<JWPageViewDataSource, JWPageViewDelegate>

@property (strong, nonatomic) JWPageView *pageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageView = [[JWPageView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), 200)];
    self.pageView.backgroundColor = [UIColor redColor];
    self.pageView.delegate = self;
    self.pageView.dataSource = self;
    [self.pageView reloadData];
    
    [self.view addSubview:self.pageView];
    
    JWFPSLabel *label = [JWFPSLabel new];
    [label sizeToFit];
    
    CGRect labelFrame = label.frame;
    labelFrame.origin.y = 230;
    label.frame = labelFrame;
    
    [self.view addSubview:label];
    
    JWTickLabel *tickLabel = [JWTickLabel new];
    tickLabel.font = [UIFont fontWithName:@"Menlo" size:40];
    tickLabel.textValue = 1345.34;
    tickLabel.prefixString = @"¥";
    
    [tickLabel sizeToFit];
    
    labelFrame = tickLabel.frame;
    labelFrame.origin.y = 230;
    labelFrame.origin.x = 100;
    tickLabel.frame = labelFrame;

    
    [self.view addSubview:tickLabel];
    
    [tickLabel beginAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - JWPageViewDataSource & JWPageViewDelegate
- (NSUInteger)numberOfPagesInPageView:(JWPageView *)aPageView{
    return 4;
}

- (UIView*)pageView:(JWPageView *)aPageView viewAt:(NSUInteger)aIndex reusableView:(__kindof UIView*)reusableView{
    UILabel *label;
    if (reusableView) {
        label = reusableView;
    } else {
        label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
    }
    label.text = [NSString stringWithFormat:@"第%ld个页面", aIndex];
    return label;
}

@end
