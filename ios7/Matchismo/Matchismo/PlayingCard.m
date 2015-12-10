//
//  PlayingCard.m
//  Matchismo
//
//  Created by Davis Koh on 12/3/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

#pragma mark - Overrides

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards {
    int score = 0;

    if (otherCards.count) {
        for (PlayingCard *otherCard in otherCards) {
            if (self.rank == otherCard.rank) {
                score += 4;
            } else if (self.suit == otherCard.suit) {
                score += 1;
            }
        }
    }

    return score;
}

#pragma mark - Class Methods

// NOTE: obviously cant ref properties in class methods
// as properties are associated w/ instances
+ (NSArray *)validSuits {
    return @[@"♧", @"♡", @"♢", @"♤"];
}

+ (NSArray *)rankStrings {
  return @[
           @"?",
           @"A",
           @"2",
           @"3",
           @"4",
           @"5",
           @"6",
           @"7",
           @"8",
           @"9",
           @"10",
           @"J",
           @"Q",
           @"K"
           ];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

#pragma mark - Getters & Setters

// needed because overriding BOTH getter & setter
@synthesize suit = _suit;

- (NSString *) suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
