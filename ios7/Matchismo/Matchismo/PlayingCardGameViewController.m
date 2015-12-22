//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Davis Koh on 12/12/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardTableView.h"
#import "PlayingCard.h"
// OPTIMIZE: separate out PlayingCard specific logic and include PlayingCardView.h
#import "CardView.h"

@interface PlayingCardGameViewController ()

// FIXME: find better way to do below than overriding collectionView prop
@property (strong, nonatomic) PlayingCardTableView *collectionView;

@end

@implementation PlayingCardGameViewController

@dynamic collectionView;

- (CardTableView *)createCardTableView {
    return [[PlayingCardTableView alloc] initWithFrame:self.view.bounds
                                  collectionViewLayout:self.collectionViewLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Playing Card";

    [self.collectionView.historySlider addTarget:self
                           action:@selector(onSliderValueChange:)
                 forControlEvents:UIControlEventValueChanged];

    [self.collectionView.gameModeSwitch addTarget:self
                        action:@selector(onSwitchToggle:)
              forControlEvents:UIControlEventTouchUpInside];
}

- (PlayingCardDeck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void)onSwitchToggle:(UISwitch *)sender {
    self.game.requiredMatcheeCount = self.game.requiredMatcheeCount == 1 ? 2 : 1;
}

- (void)onCardChosen:(UIButton *)sender {
    [super onCardChosen:sender];
    self.collectionView.gameModeSwitch.enabled = NO;
}

- (void)onDealButtonTouch:(UIButton *)sender {
    [super onDealButtonTouch:sender];
    self.collectionView.gameModeSwitch.enabled = YES;
}

- (void)onSliderValueChange:(UISlider *)sender {
    int i = (int)(sender.value + 0.5);

    // if index NOT out of bounds then update label
    if (i < self.history.count) {

        self.collectionView.lastResultLabel.attributedText = (NSAttributedString *)self.history[i];
        self.collectionView.historySlider.maximumValue = self.history.count - 1;
    }
}

- (void)updateCards {
    for (CardView *cardView in self.cardButtons) {
        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardView];
        // OPTIMIZE: is below typecasting allowed / normal?
        PlayingCard *card = (PlayingCard *)[self.game cardAtIndex:cardButtonIndex];

        cardView.suit = card.suit;
        cardView.rank = card.rank;

        if ([card.suit  isEqual: @"♧"] || [card.suit  isEqual: @"♤"]) {
            cardView.color = [UIColor blackColor];
        } else {
            cardView.color = [UIColor redColor];
        }

        cardView.faceUp = card.isChosen;

        // TODO: implement enabled property
        // cardView.enabled = card.isMatched;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
