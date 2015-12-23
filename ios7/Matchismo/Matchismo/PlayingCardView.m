//
//  PlayingCardView.m
//  Matchismo
//
//  Created by Davis Koh on 12/19/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()

@property (nonatomic) CGFloat faceCardScaleFactor;

@end

@implementation PlayingCardView

#pragma mark - Getters & Setters

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

#pragma mark - Utils

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

#pragma mark - Drawing

- (CGFloat)cornerOffset {
    return [self cornerRadius] / 3.0;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

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

- (void)drawPips {
    // very long implentation from lecture
    // honestly...opt for just displaying the attributed text in
    // proper color
    // this is not a fucking drawing class...

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;

    UIFont *middleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    middleFont = [middleFont fontWithSize:(self.bounds.size.width / 2)];

    NSAttributedString *middleText = [[NSAttributedString alloc] initWithString:self.suit
                                                                     attributes:@{
                                                                                  NSFontAttributeName: middleFont,
                                                                                  NSParagraphStyleAttributeName: paragraphStyle,
                                                                                  NSForegroundColorAttributeName: self.color
                                                                                  }];
    CGRect textBounds;
    textBounds.size = middleText.size;
    textBounds.origin.x = CGRectGetMidX(self.bounds) - (textBounds.size.width / 2);
    textBounds.origin.y = CGRectGetMidY(self.bounds) - (textBounds.size.height / 2);

    [middleText drawInRect:textBounds];
}

#pragma mark - Gestures

#pragma mark - Gestures

// adjust face card scale
- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
}

@end
