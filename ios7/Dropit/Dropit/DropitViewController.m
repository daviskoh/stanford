//
//  ViewController.m
//  Dropit
//
//  Created by Davis Koh on 12/27/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "DropitViewController.h"

@interface DropitViewController ()

@property (nonatomic) UIView *gameView;

@end

@implementation DropitViewController

static const CGSize DROP_SIZE = { 40, 40 };

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.gameView = [[UIView alloc] initWithFrame:self.view.frame];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tap:)];
    [self.gameView addGestureRecognizer:tapGesture];
    [self.view addSubview:self.gameView];
}

- (void)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

- (void)drop {
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random()%(int)self.gameView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;

    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
}

- (UIColor *)randomColor {
    switch (arc4random()%5) {
        case 0: return [UIColor greenColor];
        case 1: return [UIColor blueColor];
        case 2: return [UIColor orangeColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor purpleColor];
    }
    return [UIColor blackColor];
}

@end
