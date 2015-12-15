//
//  CardTableView.m
//  Matchismo
//
//  Created by Davis Koh on 12/12/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardTableView.h"

@implementation CardTableView

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame
           collectionViewLayout:layout];

    if (self) {
        [self registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"cardCell"];

        [self setBackgroundColor:[UIColor greenColor]];

        [self setupScoreLabel];
        [self setupDealButton];
        [self setupLastResultLabel];
        [self setupHistorySlider];
    }

    return self;
}

- (void)setupScoreLabel {
    self.scoreLabel = [[UILabel alloc] init];
    self.scoreLabel.text = @"Score: 0";
    [self.scoreLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.scoreLabel];

    NSLayoutConstraint *yConstraint = [NSLayoutConstraint constraintWithItem:self.scoreLabel
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.6
                                                                    constant:0];
    [self addConstraint:yConstraint];
}

- (void)setupDealButton {
    self.dealButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [self.dealButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.dealButton setTitle:@"Deal" forState:UIControlStateNormal];
    [self addSubview:self.dealButton];

    NSLayoutConstraint *dealButtonYConstraint = [NSLayoutConstraint constraintWithItem:self.dealButton
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.8
                                                                    constant:0];

    NSLayoutConstraint *dealButtonXConstraint = [NSLayoutConstraint constraintWithItem:self.dealButton
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.8
                                                                    constant:0];

    [self addConstraints:@[dealButtonYConstraint, dealButtonXConstraint]];
}

- (void)setupLastResultLabel {
    self.lastResultLabel = [[UILabel alloc] init];
    self.lastResultLabel.text = @"Last Result";
    self.lastResultLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.lastResultLabel];

    NSLayoutConstraint *lastResultYConstraint = [NSLayoutConstraint constraintWithItem:self.lastResultLabel
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.8
                                                                    constant:0];
    [self addConstraint:lastResultYConstraint];
}

- (void)setupHistorySlider {
    self.historySlider = [[UISlider alloc] init];
    self.historySlider.minimumValue = 0;
    self.historySlider.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.historySlider];

    NSLayoutConstraint *historySliderXConstraint = [NSLayoutConstraint constraintWithItem:self.historySlider
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:0];

    NSLayoutConstraint *historySliderYConstraint = [NSLayoutConstraint constraintWithItem:self.historySlider
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.7
                                                                    constant:0];

    NSLayoutConstraint *historySliderWidthConstraint = [NSLayoutConstraint constraintWithItem:self.historySlider
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:0.8
                                                                    constant:0];

    [self addConstraints:@[historySliderXConstraint, historySliderYConstraint, historySliderWidthConstraint]];
}

@end
