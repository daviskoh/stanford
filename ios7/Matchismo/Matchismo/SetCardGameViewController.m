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
#import "SetCardTableView.h"
#import "Matchismo-Swift.h"

@interface SetCardGameViewController ()

// FIXME: find better way to do below than overriding collectionView prop
@property (strong, nonatomic) SetCardTableView *collectionView;

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

    [self.collectionView.dealThreeMoreButton addTarget:self
                                                action:@selector(onThreeMoreButtonTouch:)
                                      forControlEvents:UIControlEventTouchUpInside];
}

- (CardTableView *)createCardTableView {
    return [[SetCardTableView alloc] initWithFrame:self.view.bounds
                                  collectionViewLayout:self.collectionViewLayout];
}

- (CardMatchingGame *)game {
    CardMatchingGame *game = [super game];
    game.allowReDeals = YES;
    return game;
}

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (void)onThreeMoreButtonTouch:(UIButton *)sender {
    if (self.cardButtons.count > 9) return;

    // FIXME: do something when error occurs
    int baseIndex = (int)self.cardButtons.count;
    BOOL success = [self.game drawCards:3
                                 onDraw:^(int i, Card *card) {
                                     NSUInteger indexes[] = {0, baseIndex + i};
                                     NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndexes:indexes
                                                                                           length:2];
                                     UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell"
                                                                                                                  forIndexPath:indexPath];

                                     SetCardView *cardView = [self createCardViewWithFrame:cell.bounds];
                                     [UIView transitionWithView:self.collectionView
                                                       duration:1.0
                                                        options:UIViewAnimationOptionTransitionCrossDissolve
                                                      animations:^{
                                                          [cell.contentView addSubview:cardView];
                                                          // OPTIMIZE: this should be done as batch
                                                          [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
                                                      }
                                                      completion:nil];
                                 }
                                  error:nil];

    if (!success) {
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Deck is Empty"
                                                                           message:@"No more set cards left to draw."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:nil];
        [alertCtrl addAction:ok];
        [self presentViewController:alertCtrl
                           animated:YES
                         completion:nil];
    }
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

- (SetCardView *)createCardViewWithFrame:(CGRect)frame {
    SetCardView *cardView = [[SetCardView alloc] initWithFrame:frame];

    UIGestureRecognizer *touchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                         action:@selector(onCardChosen:)];
    [cardView addGestureRecognizer:touchGesture];

    return cardView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell"
                                                                           forIndexPath:indexPath];
    SetCardView *cardView = [self createCardViewWithFrame:cell.bounds];

    [cell.contentView addSubview:cardView];
    [self.cardButtons addObject:cardView];

    return cell;
}

- (void)updateCardsAndAnimate:(BOOL)animate {
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

        if (animate) [self flipCardView:cardView];
    }

    // needed because removing views in above loop would be
    // mutating mid-loop
    for (SetCardView *cardView in matchedCardViews) {
        [self.cardButtons removeObject:cardView];

        [UIView animateWithDuration:1.5
                         animations:^{
                             cardView.alpha = 0;
                         }
                         completion:^(BOOL fin){
                            [cardView removeFromSuperview];
                         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
