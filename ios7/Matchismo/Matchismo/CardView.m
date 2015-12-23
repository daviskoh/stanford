//
//  CardView.m
//  Matchismo
//
//  Created by Davis Koh on 12/2/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardView.h"

@interface CardView()

@end

@implementation CardView

#pragma mark - Getters & Setters

// NOTE: setNeedsDisplay
// - anyone changes prop,
// tell system that view needs to be redrawn

- (void)setSuit:(NSString *)suit {
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank {
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp {
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;

    if (!enabled) {
        self.alpha = 0.8f;
        self.backgroundColor = [UIColor grayColor];
    } else {
        [self setup];
    }

    self.userInteractionEnabled = enabled;
}

#pragma mark - Drawing

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor {
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius {
    return CORNER_RADIUS * [self cornerScaleFactor];
}

// abstract
- (void)drawRect:(CGRect)rect {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:[self cornerRadius]];
    [roundedRect addClip];

    [[UIColor whiteColor] setFill];
    // fills rect
    UIRectFill(self.bounds);

    [[UIColor blackColor] setStroke];
    [roundedRect stroke];

    if (!self.faceUp) {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
        return;
    }
}

- (void)drawPips {} // abstract

- (void)setup {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.alpha = 1.0;
    self.contentMode = UIViewContentModeRedraw;
}

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setup];
    }

    return self;
}

@end
