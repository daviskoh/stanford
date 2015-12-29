//
//  BezierPathView.m
//  Dropit
//
//  Created by Davis Koh on 12/29/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

- (void)setPath:(UIBezierPath *)path {
    _path = path;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] setStroke];
    [self.path stroke];
}

@end
