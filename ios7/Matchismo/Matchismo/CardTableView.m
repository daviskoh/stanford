//
//  CardTableView.m
//  Matchismo
//
//  Created by Davis Koh on 12/2/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardTableView.h"
#import "CardView.h"

@implementation CardTableView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor greenColor];

        self.cardButton = [[CardView alloc] init];
        [self addSubview:self.cardButton];
        [self setupCardButtonView];
    }
    
    return self;
}

- (void)setupCardButtonView {
    NSLayoutConstraint *xConstraint = [NSLayoutConstraint constraintWithItem:self.cardButton
                                                                       attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1
                                                                        constant:0];

    NSLayoutConstraint *yConstraint = [NSLayoutConstraint constraintWithItem:self.cardButton
                                                                       attribute:NSLayoutAttributeCenterY
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeCenterY
                                                                      multiplier:1
                                                                        constant:0];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.cardButton
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:0.3
                                                                        constant:0];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.cardButton
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.cardButton
                                                                       attribute:NSLayoutAttributeHeight
                                                                      multiplier:0.6
                                                                        constant:0];

    [self addConstraints:@[xConstraint, yConstraint, heightConstraint, widthConstraint]];
}

@end
