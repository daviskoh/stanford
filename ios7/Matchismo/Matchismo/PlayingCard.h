//
//  PlayingCard.h
//  Matchismo
//
//  Created by Davis Koh on 12/3/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

// ♧♡♢♤ or nil
@property (strong, nonatomic) NSString *suit;

// 0 (rank not set) to 13 (King)
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;

+ (NSUInteger)maxRank;

@end
