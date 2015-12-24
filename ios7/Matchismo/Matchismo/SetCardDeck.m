//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Davis Koh on 12/13/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];

    if (self) {
        for (NSString *suit in [SetCard validSuits]) {
            for (UIColor *color in [SetCard validColors]) {
                for (NSNumber *shading in [SetCard validShading]) {
                    for (int rank = 1; rank <= [SetCard maxRank]; rank++) {
                        SetCard *card = [[SetCard alloc] initWithSuit:suit
                                                                 rank:rank
                                                                color:color
                                                          shading:shading];
                        [self addCard:card];
                    }
                }
            }
        }

    }

    return self;
}

@end
