//
//  ViewController.h
//  Matchismo
//
//  Created by Davis Koh on 12/1/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//
// Abstract Class

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "PlayingCardTableView.h"

@interface CardGameViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (Deck *)createDeck; // abstract

@end

