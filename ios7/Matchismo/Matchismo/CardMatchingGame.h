//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Davis Koh on 12/8/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;

@property (nonatomic) int requiredMatcheeCount;

@property (nonatomic) NSMutableArray *previouslyMatchedCards;
@property (nonatomic) int scoreChange;

@property (nonatomic) BOOL allowReDeals;

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
         withRequiredMatcheeCount:(int)requiredMatcheeCount;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

- (BOOL)drawCards:(int)numberOfCards onDraw:(void(^)(Card *))block
            error:(NSError **)errorPtr;

@end
