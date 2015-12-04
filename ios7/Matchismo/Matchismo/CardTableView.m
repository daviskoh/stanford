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

        self.countLabel = [[UILabel alloc] init];
        self.countLabel.text = @"Flips Count: 0";
        [self.countLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:self.countLabel];
        [self setupCountLabelView];
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

- (void)setupCountLabelView {
    self.countLabel.textAlignment = NSTextAlignmentCenter;

    NSLayoutConstraint *xConstraint = [NSLayoutConstraint constraintWithItem:self.countLabel
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:0];

    NSLayoutConstraint *yConstraint = [NSLayoutConstraint constraintWithItem:self.countLabel
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.75
                                                                    constant:0];

    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.countLabel
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:0.5
                                                                    constant:0];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.countLabel
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeHeight
                                                                  multiplier:0.1
                                                                    constant:0];

    [self addConstraints:@[xConstraint, yConstraint, widthConstraint, heightConstraint]];
}

@end
