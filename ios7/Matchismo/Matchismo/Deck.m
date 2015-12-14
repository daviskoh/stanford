//
//  Deck.m
//  Matchismo
//
//  Created by Davis Koh on 12/2/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@end

@implementation Deck

- (NSMutableArray *)cards {
    // make sure heap is allocated for cards before
    // trying to access it

    // Lazy Instantiation
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop {
    if (atTop) {
        [self.cards insertObject:card
                         atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card {
    return [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    // drawing from empty array will crash program
    if (self.cards.count) {
        unsigned i = arc4random() % self.cards.count;
        randomCard = self.cards[i];
        [self.cards removeObjectAtIndex:i];
    }
    
    return randomCard;
}

@end
