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

@property (strong, nonatomic) UILabel *countLabel;

@property (nonatomic) int flipCount;

@end

@implementation CardGameViewController

@dynamic view;

- (instancetype)init {
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    self = [super initWithCollectionViewLayout:layout];

    return self;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a
}

#pragma mark - Getters & Setters

- (Deck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.view.countLabel.text = [NSString stringWithFormat:@"Flips Count: %d", flipCount];
}

#pragma mark - Event Handlers

- (void)onButtonClick:(UIButton *)sender {
    NSString *imageName,
        *title = @"";

    if ([sender.currentTitle length]) {
        imageName = @"cardback.png";

        [sender setBackgroundImage:[UIImage imageNamed:imageName]
                              forState:UIControlStateNormal];

        self.flipCount++;
    } else {
        imageName = @"cardfront.png";

        Card *card = [self.deck drawRandomCard];

        // stop flipping when deck runs out
        if (card) {
            [sender setBackgroundImage:[UIImage imageNamed:imageName]
                              forState:UIControlStateNormal];

            title = card.contents;
        }

        self.flipCount++;
    }

    [sender setTitle:title
          forState:UIControlStateNormal];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[UICollectionViewCell alloc] init];
}

#pragma mark - Performance

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
