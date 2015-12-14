//
//  SetCard.h
//  Matchismo
//
//  Created by Davis Koh on 12/12/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "PlayingCard.h"
#import "UIKit/UIKit.h"

@interface SetCard : PlayingCard

@property (strong, nonatomic) UIColor *color;

// TODO: make more semantic
@property (strong, nonatomic) NSNumber *strokeWidth;

// designated initializer
- (instancetype)initWithSuit:(NSString *)suit
                        rank:(int)rank
                       color:(UIColor *)color
                 strokeWidth:(NSNumber *)strokeWidth;

+ (NSArray *)validColors;
+ (NSArray *)validStrokeWidths;

@end
