//
//  ViewController.m
//  Matchismo
//
//  Created by Davis Koh on 12/1/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardTableView.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

// OPTIMIZE: not sure if below is legal
// view Type override
@property (nonatomic) CardTableView *view;

@property (nonatomic) Deck *deck;

@property (nonatomic) UILabel *countLabel;

@property (nonatomic) int flipsCount;

@end

@implementation CardGameViewController

@dynamic view;

#pragma mark - View

- (void)loadView {
    self.view = [[CardTableView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a

    [self.view.cardButton addTarget:self
                             action:@selector(onButtonClick:)
                   forControlEvents:UIControlEventTouchUpInside];

    self.countLabel = [[UILabel alloc] init];
    self.countLabel.text = @"Flips Count: 0";
    [self.countLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.countLabel];

    self.countLabel.textAlignment = NSTextAlignmentCenter;

    NSLayoutConstraint *xConstraint = [NSLayoutConstraint constraintWithItem:self.countLabel
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:0];

    NSLayoutConstraint *yConstraint = [NSLayoutConstraint constraintWithItem:self.countLabel
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.75
                                                                    constant:0];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.countLabel
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:0.5
                                                                    constant:0];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.countLabel
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeHeight
                                                                  multiplier:0.1
                                                                    constant:0];

    [self.view addConstraints:@[xConstraint, yConstraint, widthConstraint, heightConstraint]];
}

#pragma mark - Getters & Setters

- (Deck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

#pragma mark - Performance

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Handlers

- (void)onButtonClick:(UIButton *)sender {
    NSString *imageName, *title;

    if ([sender.currentTitle length]) {
        imageName = @"cardback.png";
        title = @"";
    } else {
        imageName = @"cardfront.png";
        // TODO: remove hard-coded Card View text
        title = [self.deck drawRandomCard].contents;
    }

    [sender setBackgroundImage:[UIImage imageNamed:imageName]
                      forState:UIControlStateNormal];

    [sender setTitle:title
          forState:UIControlStateNormal];

    // OPTIMIZE: should entire text label be getting reassigned?
    self.countLabel.text = [NSString stringWithFormat:@"Flips Count: %d", ++self.flipsCount];
}

@end
