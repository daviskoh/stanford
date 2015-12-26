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
#import "Matchismo-Swift.h"

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

- (void)updateLastResultLabelWithPreviousResult:(NSArray *)previouslyMatchedCards
                                    scoreChange:(int)scoreChange {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];

    for (SetCard *card in previouslyMatchedCards) {
        NSMutableDictionary *attributes = @{
                                     NSForegroundColorAttributeName: card.color,
                                     NSStrokeColorAttributeName: [UIColor blackColor]
                                     }.mutableCopy;
        if ([card.shading  isEqualToString: @"fill"]) {
            [attributes setObject:@0 forKey:@"NSStrokeWidthAttributeName"];
        } else if ([card.shading isEqualToString:@"empty"]) {
            [attributes setObject:@-5 forKey:@"NSStrokeWidthAttributeName"];
        } else if ([card.shading isEqualToString:@"stripe"]) {
            [attributes setObject:@5 forKey:@"NSStrokeWidthAttributeName"];
        }

        NSAttributedString *subString = [[NSAttributedString alloc] initWithString:card.contents
                                        attributes:attributes];
        [string appendAttributedString:subString];
    }

    NSString *scoreString = [NSString stringWithFormat:@"%d points", scoreChange];
    NSAttributedString *scoreAttString = [[NSAttributedString alloc] initWithString:scoreString];
    [string appendAttributedString:scoreAttString];

    self.collectionView.lastResultLabel.attributedText = string;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell"
                                                                           forIndexPath:indexPath];
    SetCardView *cardView = [[SetCardView alloc] initWithFrame:cell.bounds];

    UIGestureRecognizer *touchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                         action:@selector(onCardChosen:)];
    [cardView addGestureRecognizer:touchGesture];

    [cell.contentView addSubview:cardView];
    [self.cardButtons addObject:cardView];

    return cell;
}

- (void)updateCards {
    NSMutableArray *matchedCardViews = @[].mutableCopy;

    for (SetCardView *cardView in self.cardButtons) {
        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardView];
        // OPTIMIZE: is below typecasting allowed / normal?
        SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];

        // card has been matched & removed by game
        if (!card) {
            [matchedCardViews addObject:cardView];
            continue;
        }

        cardView.suit = card.suit;
        cardView.rank = card.rank;
        cardView.color = card.color;
        cardView.shading = card.shading;

        cardView.faceUp = card.isChosen;

        cardView.enabled = !card.isMatched;

        cardView.userInteractionEnabled = !card.isChosen;
    }

    // needed because removing views in above loop would be
    // mutating mid-loop
    for (SetCardView *cardView in matchedCardViews) {
        [self.cardButtons removeObject:cardView];
        [cardView.superview removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
