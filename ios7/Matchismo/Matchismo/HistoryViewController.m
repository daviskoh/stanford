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

    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] init];
    for (NSAttributedString *string in self.history) {
        [mutableString appendAttributedString:string];
        [mutableString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
    }

    // FIXME: ghetto...
    NSString *fullString = [mutableString string];
    NSRange range = [fullString rangeOfString:fullString];
    [mutableString addAttribute:NSFontAttributeName
    value: [UIFont fontWithName:@"arial" size:25]
    range:range];

    textView.attributedText = mutableString;

    [self.view addSubview:textView];
}

@end
