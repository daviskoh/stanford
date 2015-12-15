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

    self.title = @"Playing Card Game";

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
