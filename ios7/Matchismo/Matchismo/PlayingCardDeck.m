//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Davis Koh on 12/3/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

// return object w/ same type as object this message was sent to
- (instancetype)init {
    // return nil if cant initialize object
    // check if superclass can initialize itself

    // super - use superclass implementation of
    // in this case, init on ourself
    self = [super init];

    // just incase self comes back as nil
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                // OPTIMIZE: consider adding convenience init for properties
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }

    return self;
}

@end
