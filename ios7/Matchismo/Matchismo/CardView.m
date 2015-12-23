//
//  CardView.m
//  Matchismo
//
//  Created by Davis Koh on 12/2/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardView.h"

@interface CardView()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation CardView

#pragma mark - Getters & Setters

// NOTE: setNeedsDisplay
// - anyone changes prop,
// tell system that view needs to be redrawn

@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90

- (CGFloat)faceCardScaleFactor {
    if (!_faceCardScaleFactor) {
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    }
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

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
        self.userInteractionEnabled = enabled;
        self.alpha = 0.8f;
        self.backgroundColor = [UIColor grayColor];
    }
}

#pragma mark - Gestures

// adjust face card scale
- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
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

- (CGFloat)cornerOffset {
    return [self cornerRadius] / 3.0;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:[self cornerRadius]];
    [roundedRect addClip];

    [[UIColor whiteColor] setFill];
    // fills rect
    UIRectFill(self.bounds);

    [[UIColor blackColor] setStroke];
    [roundedRect stroke];

    if (self.faceUp) {

        NSString *imageName = [NSString stringWithFormat:@"%@%@", [self rankAsString],self.suit];
        UIImage *faceImage = [UIImage imageNamed:imageName];
        if (faceImage) {
            // prevent image from "smashing corners"
            // scale image into rect
            CGSize size = self.bounds.size;
            CGRect imageRect = CGRectInset(self.bounds,
                                           // 90% of card
                                           size.width * (1.0 - self.faceCardScaleFactor),
                                           size.height * (1.0 - self.faceCardScaleFactor)
                                           );
            [faceImage drawInRect:imageRect];
        } else {
            [self drawPips];
        }

        [self drawCorners];
    } else {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

- (void)drawPips {} // abstract

- (NSString *)rankAsString {
    return @[
             @"?",
             @"A",
             @"2",
             @"3",
             @"4",
             @"5",
             @"6",
             @"7",
             @"8",
             @"9",
             @"10",
             @"J",
             @"Q",
             @"K"
             ][self.rank];
}

- (void)drawCorners {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;

    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];

    NSString *string = [NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit];
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:string
                                                                     attributes:@{
                                                                                  NSFontAttributeName: cornerFont,
                                                                                  NSParagraphStyleAttributeName: paragraphStyle,
                                                                                  NSForegroundColorAttributeName: self.color
                                                                                  }];
    // top
    CGRect textBounds;
    textBounds.origin = CGPointMake(
                                    [self cornerOffset],
                                    [self cornerOffset]
                                    );
    textBounds.size = cornerText.size;
    [cornerText drawInRect:textBounds];

    // upside down
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(
                          context,
                          self.bounds.size.width,
                          self.bounds.size.height
                          );
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
}

- (void)setup {
    self.backgroundColor = nil;
    self.opaque = NO;
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
