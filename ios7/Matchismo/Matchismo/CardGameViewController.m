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
    NSString *imageName,
        *title = @"";

    if ([sender.currentTitle length]) {
        imageName = @"cardback.png";

        [sender setBackgroundImage:[UIImage imageNamed:imageName]
                              forState:UIControlStateNormal];
    } else {
        imageName = @"cardfront.png";

        Card *card = [self.deck drawRandomCard];

        // stop flipping when deck runs out
        if (card) {
            [sender setBackgroundImage:[UIImage imageNamed:imageName]
                              forState:UIControlStateNormal];

            title = card.contents;
        }
    }

    [sender setTitle:title
          forState:UIControlStateNormal];

    // OPTIMIZE: should entire text label be getting reassigned?
    self.view.countLabel.text = [NSString stringWithFormat:@"Flips Count: %d", ++self.flipsCount];
}

@end
