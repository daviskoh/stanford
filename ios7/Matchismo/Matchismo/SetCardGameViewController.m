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
    self.title = @"Set Card Game";
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

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];

    NSRange suitRange = [text rangeOfString:card.suit];

    [string addAttribute:NSForegroundColorAttributeName
                   value:card.color
                   range:suitRange];

    [string addAttribute:NSStrokeWidthAttributeName
                   value:card.strokeWidth
                   range:suitRange];
    [string addAttribute:NSStrokeColorAttributeName
                    value:[UIColor blackColor]
                    range:suitRange];

    return string;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
