//
//  ViewController.m
//  Matchismo
//
//  Created by Davis Koh on 12/1/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardTableView.h"

@interface CardGameViewController ()

@property CardTableView *view;

@end

@implementation CardGameViewController

@dynamic view;

- (void)loadView {
    self.view = [[CardTableView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a

    [self.view.cardButton addTarget:self
                             action:@selector(onButtonClick:)
                   forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onButtonClick:(UIButton *)sender {
    NSString *imageName, *title;

    if ([sender.currentTitle length]) {
        imageName = @"cardback.png";
        title = @"";
    } else {
        imageName = @"cardfront.png";
        // TODO: remove hard-coded Card View text
        title = @"A♠︎";
    }

    [sender setBackgroundImage:[UIImage imageNamed:imageName]
                      forState:UIControlStateNormal];

    [sender setTitle:title
          forState:UIControlStateNormal];
}

@end
