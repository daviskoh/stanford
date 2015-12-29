//
//  ViewController.m
//  Imaginarium
//
//  Created by Davis Koh on 12/29/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat offset = -100;
    NSArray *buttons = @[@"Flower", @"Peppers", @"Jellyfish"];
    for (NSString *buttonTitle in buttons) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button sizeToFit];

        CGRect frame = button.frame;
        frame.origin.x = CGRectGetMidX(self.view.bounds) - (button.frame.size.width / 2);
        frame.origin.y = CGRectGetMidY(self.view.bounds) + offset;
        offset += 100;
        button.frame = frame;

        [self.view addSubview:button];
    }
}

@end
