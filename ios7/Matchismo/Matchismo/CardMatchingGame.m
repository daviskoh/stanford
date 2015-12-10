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

@property (nonatomic, strong) Card *lastChosenCard;

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
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

// more like toggleCardAtIndex
- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];

    if (card.isMatched) {
        card.chosen = NO;
    } else {
        NSMutableArray *otherCards = [[NSMutableArray alloc] init];

        // How do you match against last 2 chosen cards??
        // NOTE: in 3-card mode, MUST choose at least 3 cards before seeing results

        // iterate through self.cards
        // if card.isChosen then push into otherCards
            // repeat until requiredMatcheeCount reached

        // if otherCards.count < requiredMatcheeCount then
            // set card chosen (other card is already chosen)
            // set score - choosing fee
        // else
            // card match:otherCards
            // set score
            // set matched

        for (Card *otherCard in self.cards) {
            if (otherCards.count == self.requiredMatcheeCount) break;

            if (otherCard.isChosen && !otherCard.isMatched) {
                [otherCards addObject:otherCard];
            }
        }

        if (otherCards.count < self.requiredMatcheeCount) {
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
        } else {
            // set score
            int score = [card match:otherCards];

            if (score) {
                self.score += score * MATCH_BONUS;
                card.matched = YES;
                for (Card *otherCard in otherCards) {
                    otherCard.matched = YES;
                }
            } else {
                self.score -= MISMATCH_PENALTY;
                self.lastChosenCard.chosen = NO;
            }
        }

        card.chosen = YES;
    }

    self.lastChosenCard = card;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return index < self.cards.count ? self.cards[index] : nil;
}

@end
