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
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

// OPTIMIZE: check if there is a protocol that can be implemented
- (void)addTarget:(id)target action:(nonnull SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
