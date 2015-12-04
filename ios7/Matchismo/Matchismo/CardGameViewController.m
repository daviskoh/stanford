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
@property (strong, nonatomic) CardTableView *view;

@property (strong, nonatomic) Deck *deck;

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
}

@end
