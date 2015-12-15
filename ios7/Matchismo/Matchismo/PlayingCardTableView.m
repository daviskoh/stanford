//
//  PlayingCardTableView.m
//  Matchismo
//
//  Created by Davis Koh on 12/11/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "PlayingCardTableView.h"

@implementation PlayingCardTableView

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame
           collectionViewLayout:layout];

    if (self) {
        [self setupHistorySlider];
        [self setupGameModeSwitch];
    }

    return self;
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

- (void)setupGameModeSwitch {
    self.gameModeSwitch = [[UISwitch alloc] init];
    [self.gameModeSwitch setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.gameModeSwitch];

    NSLayoutConstraint *modeSwitchYConstraint = [NSLayoutConstraint constraintWithItem:self.gameModeSwitch
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.9
                                                                    constant:0];

    NSLayoutConstraint *modeSwitchXConstraint = [NSLayoutConstraint constraintWithItem:self.gameModeSwitch
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:0];

    [self addConstraints:@[modeSwitchYConstraint, modeSwitchXConstraint]];
}

@end
