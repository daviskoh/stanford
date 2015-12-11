//
//  PlayingCardTableView.h
//  Matchismo
//
//  Created by Davis Koh on 12/11/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardTableView : UICollectionView

@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UIButton *dealButton;
@property (strong, nonatomic) UISwitch *gameModeSwitch;
@property (strong, nonatomic) UILabel *lastResultLabel;
@property (strong, nonatomic) UISlider *historySlider;

@end
