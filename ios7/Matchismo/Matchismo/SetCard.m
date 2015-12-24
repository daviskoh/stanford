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

- (int)match:(NSArray *)otherCards {
    int score = 0;

    if (otherCards.count) {
        for (SetCard *otherCard in otherCards) {
            // TODO: check if below is legal or use isEqualTo... methods
            if (self.rank == otherCard.rank ||
                self.suit == otherCard.suit ||
                self.color == self.color ||
                self.shading == self.shading) {

                // weight each attribute equally
                score += 2;
            }
        }
    }

    return score;
}

@end
