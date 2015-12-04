//
//  CardView.m
//  Matchismo
//
//  Created by Davis Koh on 12/2/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        UIImage *btnImage = [UIImage imageNamed:@"cardback.png"];
        [self setBackgroundImage:btnImage
                        forState:UIControlStateNormal];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];

        [self setTitleColor:[UIColor blackColor]
                   forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:50];
    }

    return self;
}

@end
