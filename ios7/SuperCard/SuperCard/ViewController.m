//
//  ViewController.m
//  SuperCard
//
//  Created by Davis Koh on 12/18/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"

@interface ViewController ()

@property (strong, nonatomic) PlayingCardView *playingCardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];

    CGRect screenBounds = self.view.bounds;
    CGRect bounds = CGRectMake(
                               screenBounds.origin.x,
                               screenBounds.origin.y,
                               screenBounds.size.width / 2,
                               screenBounds.size.height / 2
                               );
    self.playingCardView = [[PlayingCardView alloc] initWithFrame:bounds];
    self.playingCardView.rank = 13;
    self.playingCardView.suit = @"📬";
    self.playingCardView.center = self.view.center;

    UIGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView
                                                                             action:@selector(pinch:)];
    [self.playingCardView addGestureRecognizer:pinchGesture];

    UIGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(swipe:)];
    [self.playingCardView addGestureRecognizer:swipeGesture];

    [self.view addSubview:self.playingCardView];
}

/**
 * Q - Why does Ctrl handles swipe, while View handles pinch?
 * A - Because when integrate Deck to draw new playing card during swipe,
 * should not tie View to Deck Model
 */

- (void)swipe:(UISwipeGestureRecognizer *)gesture {
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

@end
