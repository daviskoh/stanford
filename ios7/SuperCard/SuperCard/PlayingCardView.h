//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Davis Koh on 12/18/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
