//
//  PlayingCardTableView.h
//  Matchismo
//
//  Created by Davis Koh on 12/11/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardTableView.h"

@interface PlayingCardTableView : CardTableView

@property (strong, nonatomic) UISlider *historySlider;
@property (strong, nonatomic) UISwitch *gameModeSwitch;

@end
