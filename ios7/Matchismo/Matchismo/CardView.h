//
//  CardView.h
//  Matchismo
//
//  Created by Davis Koh on 12/2/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//
// Abstract Class

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic) NSUInteger rank;
// FIXME: fix nullability specifier warning
@property (strong, nonatomic) NSString *suit;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) BOOL enabled;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

- (void)drawPips;

@end
