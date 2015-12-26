//
//  SetCard.m
//  Matchismo
//
//  Created by Davis Koh on 12/12/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validSuits {
    return @[@"diamond", @"squiggle", @"oval"];
}

+ (NSArray *)rankStrings {
    return @[@"?", @"1", @"2", @"3"];
}

+ (NSArray *)validColors {
    return @[
             [UIColor redColor],
             [UIColor greenColor],
             [UIColor purpleColor]
             ];
}

+ (NSArray *)validShading {
    // fill+stroke, fill, stroke
    return @[@"empty", @"stripe", @"fill"];
}

- (instancetype)initWithSuit:(NSString *)suit
                        rank:(int)rank
                       color:(UIColor *)color
                 shading:(NSString *)shading {
    self = [super init];

    if (self) {
        self.suit = suit;
        self.rank = rank;
        self.color = color;
        self.shading = shading;
    }

    return self;
}

- (void)setColor:(UIColor *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setShading:(NSString *)shading {
    if ([[SetCard validShading] containsObject:shading]) {
        _shading = shading;
    }
}

@synthesize suit = _suit;

- (void)setSuit:(NSString *)suit {
    if ([[SetCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

// advantage: Set Card always uses 3 cards to match
- (int)match:(NSArray *)otherCards {
    // all match or all diff: rank, suit, color, stripe

    // for all available attributes
    // if card1[attribute] == card2[attribute] == card3[attribute] continue
    // if card1[attribute] != card2[attribute] != card3[attribute] continue
    // else return 0

    SetCard *card1 = self;
    SetCard *card2 = otherCards[0];
    SetCard *card3 = otherCards[1];

    for (NSString *property in @[@"rank", @"suit", @"color", @"shading"]) {
        BOOL card1MatchesCard2 = [[card1 valueForKey:property] isEqual:[card2 valueForKey:property]];
        BOOL card2MatchesCard3 = [[card2 valueForKey:property] isEqual:[card3 valueForKey:property]];
        if ((card1MatchesCard2 && !card2MatchesCard3) ||
            (!card1MatchesCard2 && card2MatchesCard3)) {
            return 0;
        }
    }

    return 8;
}

@end
