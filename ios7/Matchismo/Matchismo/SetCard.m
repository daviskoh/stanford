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
    return @[@"▲", @"●", @"■"];
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

+ (NSArray *)validStrokeWidths {
    // fill+stroke, fill, stroke
    return @[@-5, @0, @5];
}

- (instancetype)initWithSuit:(NSString *)suit
                        rank:(int)rank
                       color:(UIColor *)color
                 strokeWidth:(NSNumber *)strokeWidth {
    self = [super init];

    if (self) {
        self.suit = suit;
        self.rank = rank;
        self.color = color;
        self.strokeWidth = strokeWidth;
    }

    return self;
}

- (void)setColor:(UIColor *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setStrokeWidth:(NSNumber *)strokeWidth {
    if ([[SetCard validStrokeWidths] containsObject:strokeWidth]) {
        _strokeWidth = strokeWidth;
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
                self.strokeWidth == self.strokeWidth) {

                // weight each attribute equally
                score += 2;
            }
        }
    }

    return score;
}

@end
