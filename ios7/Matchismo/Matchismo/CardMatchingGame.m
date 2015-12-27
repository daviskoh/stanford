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

@property (nonatomic, strong) Deck *deck;

@end

@implementation CardMatchingGame

- (BOOL)drawCards:(int)numberOfCards onDraw:(void(^)(Card *))block
            error:(NSError **)errorPtr {

    for (int i = 0; i < numberOfCards; i++) {
        Card *card = [self.deck drawRandomCard];
        if (card) {
            [self.cards addObject:card];
            if (block) block(card);
        } else {
            NSDictionary *userInfo = @{
                                       NSLocalizedDescriptionKey: NSLocalizedString(@"Not enough cards in deck.", nil),
                                       NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"The operation did not complete.", nil),
                                       NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Please make sure there are enough cards in the deck to draw.", nil)
                                       };
            *errorPtr = [NSError errorWithDomain:@"self.deck"
                                            code:400
                                        userInfo:userInfo];
            return NO;
        }
    }

    return YES;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
          withRequiredMatcheeCount:(int)requiredMatcheeCount {
    self = [super init]; // super class designated initializer

    if (self) {
        self.requiredMatcheeCount = requiredMatcheeCount;
        self.deck = deck;

        NSError *drawCardsError;
        BOOL success = [self drawCards:(int)count onDraw:nil error:&drawCardsError];
        if (!success) return nil;
    }

    return self;
}

#pragma mark - Getters & Setters

- (NSMutableArray *)cards {
    if (!_cards) _cards = @[].mutableCopy;
    return _cards;
}

- (NSMutableArray *)previouslyMatchedCards {
    if (!_previouslyMatchedCards) _previouslyMatchedCards = @[].mutableCopy;
    return _previouslyMatchedCards;
}

#pragma mark - Methods

static const int MISMATCH_PENALTY = -2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

// more like toggleCardAtIndex
- (void)chooseCardAtIndex:(NSUInteger)index {
    self.previouslyMatchedCards = @[].mutableCopy;

    Card *card = [self cardAtIndex:index];

    if (card.isMatched) {
        card.chosen = NO;
    } else {
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
        NSMutableArray *otherCards = [[NSMutableArray alloc] init];

        if (card) [self.previouslyMatchedCards addObject:card];

        for (Card *otherCard in self.cards) {
            if (otherCards.count == self.requiredMatcheeCount) break;

            if (otherCard.isChosen && !otherCard.isMatched) {
                [otherCards addObject:otherCard];
                [self.previouslyMatchedCards addObject:otherCard];
            }
        }

        if (otherCards.count < self.requiredMatcheeCount) {
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
        } else {
            // set score
            int score = [card match:otherCards];

            if (score) {
                self.scoreChange = score * MATCH_BONUS;

                card.matched = YES;
                for (Card *otherCard in otherCards) {
                    otherCard.matched = YES;
                    if (self.allowReDeals) [self.cards removeObject:otherCard];
                }
                if (self.allowReDeals) [self.cards removeObject:card];
            } else {
                if (self.lastChosenCard) {
                    self.scoreChange = MISMATCH_PENALTY;
                }
                self.lastChosenCard.chosen = NO;
            }

            self.score += self.scoreChange;
        }

        card.chosen = YES;
    }

    self.lastChosenCard = card;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return index < self.cards.count ? self.cards[index] : nil;
}

@end
