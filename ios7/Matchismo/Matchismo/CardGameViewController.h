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

@property (strong, nonatomic) NSMutableArray *cardButtons; // of CardViews

- (Deck *)createDeck; // abstract

- (void)onCardChosen:(UITapGestureRecognizer *)sender;
- (void)onDealButtonTouch:(UIButton *)sender;

- (void)updateLastResultLabelWithPreviousResult:(NSArray *)previousResult
                                    scoreChange:(int)scoreChange;

- (void)updateCardsAndAnimate:(BOOL)animate;

@end

