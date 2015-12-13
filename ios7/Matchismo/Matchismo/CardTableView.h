//
//  CardTableView.h
//  Matchismo
//
//  Created by Davis Koh on 12/12/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardTableView : UICollectionView

@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UIButton *dealButton;
@property (strong, nonatomic) UILabel *lastResultLabel;
@property (strong, nonatomic) UISlider *historySlider;

@end
