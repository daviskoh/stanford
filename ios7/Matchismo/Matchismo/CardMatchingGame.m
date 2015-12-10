//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Davis Koh on 12/8/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;

@property (nonatomic, strong) NSMutableArray *cards;

@property (nonatomic) int tries;

@end

@implementation CardMatchingGame

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    self = [super init]; // super class designated initializer

    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                // return nil if cant initialize properly
                // given method args
                self = nil;
                break;
            }
        }
    }

    return self;
}

#pragma mark - Getters & Setters

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#pragma mark - Methods

static const int MISMATCH_PENALTY = 2;
static const int MISMATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

// more like toggleCardAtIndex
- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];

    if (card.isMatched) {
        card.chosen = NO;
    } else {
        // match against other chosen cards
        for (Card *otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.isMatched) {
                int matchScore = [card match:@[otherCard]];

                if (matchScore) {
                    self.score += matchScore * MISMATCH_BONUS;
                    card.matched = YES;
                    otherCard.matched = YES;
                    NSLog(@"-- matched --");
                    self.previousMatch = YES;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    otherCard.chosen = NO;
                    self.previousMatch = NO;
                }

                break;
            }

            NSLog(@"self.previousMatch: %d", self.previousMatch);
            NSLog(@"self.tries: %d", self.tries);
            if (!self.twoCardMatch) {
                if (self.tries > 2 && self.previousMatch) {
                    card.matched = YES;
                    self.tries = 0;
                }
            }
        }

        self.tries++;

        self.score -= COST_TO_CHOOSE;
        card.chosen = YES;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return index < self.cards.count ? self.cards[index] : nil;
}

@end
