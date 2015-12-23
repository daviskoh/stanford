//
//  PlayingCardView.m
//  Matchismo
//
//  Created by Davis Koh on 12/19/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "PlayingCardView.h"

@implementation PlayingCardView

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

@end
