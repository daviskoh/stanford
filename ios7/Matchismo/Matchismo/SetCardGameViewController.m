//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Davis Koh on 12/13/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

// FIXME: find better way to do below than overriding collectionView prop
@property (strong, nonatomic) CardTableView *collectionView;

@end

@implementation SetCardGameViewController

@dynamic collectionView;

- (instancetype)init {
    self = [super init];

    if (self) {
        self.game.requiredMatcheeCount = 2;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Set Card";
}

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (void)onDealButtonTouch:(UIButton *)sender {
    [super onDealButtonTouch:sender];
    self.game.requiredMatcheeCount = 2;
}

- (NSAttributedString *)titleForCard:(SetCard *)card {
    NSString *text = card.isChosen ? card.contents : @"";

    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text
                                                                 attributes:@{
                                                                              NSForegroundColorAttributeName: card.color,
                                                                              NSStrokeWidthAttributeName: card.strokeWidth,
                                                                              NSStrokeColorAttributeName: [UIColor blackColor]
                                                                              }];
    return string;
}

- (void)updateLastResultLabelWithPreviousResult:(NSArray *)previouslyMatchedCards
                                    scoreChange:(int)scoreChange {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];

    for (SetCard *card in previouslyMatchedCards) {
        NSAttributedString *subString = [[NSAttributedString alloc] initWithString:card.contents
                                        attributes:@{
                                                     NSForegroundColorAttributeName: card.color,
                                                     NSStrokeWidthAttributeName: card.strokeWidth,
                                                     NSStrokeColorAttributeName: [UIColor blackColor]
                                                     }];
        [string appendAttributedString:subString];
    }

    self.collectionView.lastResultLabel.attributedText = string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
