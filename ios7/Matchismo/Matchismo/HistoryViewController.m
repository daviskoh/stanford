//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Davis Koh on 12/15/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "HistoryViewController.h"

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"History";

    UITextView *textView = [[UITextView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    textView.backgroundColor = [UIColor lightGrayColor];
    textView.attributedText = [[NSAttributedString alloc] initWithString:(NSString *)[[self.history firstObject] string]
                                                              attributes:@{
                                                                           NSFontAttributeName: [UIFont fontWithName:@"arial" size:25]
                                                                          }];
    [self.view addSubview:textView];
}

@end
