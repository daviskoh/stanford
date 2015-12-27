//
//  SetCardTableView.m
//  Matchismo
//
//  Created by Davis Koh on 12/26/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "SetCardTableView.h"

@implementation SetCardTableView

- (instancetype)initWithFrame:(CGRect)frame
         collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame
           collectionViewLayout:layout];

    if (self) {
        [self setupDealThreeMoreButton];
    }

    return self;
}

- (void)setupDealThreeMoreButton {
    self.dealThreeMoreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [self.dealThreeMoreButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.dealThreeMoreButton setTitle:@"3 More" forState:UIControlStateNormal];
    [self addSubview:self.dealThreeMoreButton];

    NSLayoutConstraint *yConstraint = [NSLayoutConstraint constraintWithItem:self.dealThreeMoreButton
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.6
                                                                    constant:0];

    NSLayoutConstraint *xConstraint = [NSLayoutConstraint constraintWithItem:self.dealThreeMoreButton
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:0];

    [self addConstraints:@[yConstraint, xConstraint]];
}

@end
