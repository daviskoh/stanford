//
//  ViewController.h
//  Matchismo
//
//  Created by Davis Koh on 12/1/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//
// Abstract Class

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "CardTableView.h"

@interface CardGameViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) NSMutableArray *history;

- (Deck *)createDeck; // abstract

- (void)onCardChosen:(UIButton *)sender;
- (void)onDealButtonTouch:(UIButton *)sender;

- (NSAttributedString *)titleForCard:(Card *)card;

- (void)updateLastResultLabelWithPreviousResult:(NSArray *)previousResult
                                    scoreChange:(int)scoreChange;

@end

