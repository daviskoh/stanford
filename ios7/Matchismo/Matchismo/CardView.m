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
        [self setImage:btnImage forState:UIControlStateNormal];
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    }

    return self;
}

@end
