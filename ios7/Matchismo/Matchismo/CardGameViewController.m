//
//  ViewController.m
//  Matchismo
//
//  Created by Davis Koh on 12/1/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryViewController.h"
#import "Deck.h"
#import "CardView.h"
#import "CardMatchingGame.h"
#import "NSArray+NSArray_KOHMap.h"

@interface CardGameViewController ()

// FIXME: find better way to do below than overriding collectionView prop
@property (strong, nonatomic) CardTableView *collectionView;

@property (strong, nonatomic) NSMutableArray *cardButtons; // of CardViews

@property (nonatomic) int previousChosenCardIndex;

@property (nonatomic) int numberOfCards;

@end

@implementation CardGameViewController

@dynamic collectionView;

- (instancetype)init {
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];

    if (self) {
        // TODO: allow prop to be configurable in init
        self.numberOfCards = 12;
    }

    return self;
}

#pragma mark - Getters & Setters

- (NSMutableArray *)cardButtons {
    if (!_cardButtons) _cardButtons = [[NSMutableArray alloc] init];
    return _cardButtons;
}

// abstract
- (Deck *)createDeck {
    return nil;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.numberOfCards
                                                 usingDeck:[self createDeck]
                                  withRequiredMatcheeCount:1];
    }
    return _game;
}

- (NSMutableArray *)history {
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

#pragma mark - View

- (CardTableView *)createCardTableView {
    return [[CardTableView alloc] initWithFrame:self.view.bounds
                                  collectionViewLayout:self.collectionViewLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"History"
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(onHistoryButtonTouch:)];
    self.navigationItem.rightBarButtonItem = button;

    self.collectionView = [self createCardTableView];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView.dealButton addTarget:self
                        action:@selector(onDealButtonTouch:)
              forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UICollectionViewDataSource protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    // 4 x 3
    return self.numberOfCards;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell"
                                                                           forIndexPath:indexPath];

    CardView *card = [[CardView alloc] initWithFrame:cell.bounds];

    [card addTarget:self
             action:@selector(onCardChosen:)
   forControlEvents:UIControlEventTouchUpInside];

    [cell.contentView addSubview:card];
    [self.cardButtons addObject:card];

    return cell;
}

#pragma mark - UICollectionViewFlowLayout protocol

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize viewSize = self.view.bounds.size;
    CGSize cellSize = CGSizeMake(viewSize.width * 0.2, viewSize.height * 0.2);

    return cellSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    CGSize viewSize = self.view.bounds.size;
    CGFloat width = viewSize.width * 0.05;
    CGFloat height = viewSize.height * 0.05;

    // top, left, bottom, right
    return UIEdgeInsetsMake(height, width, height, width);
}

#pragma mark - Event Handlers

- (void)onCardChosen:(UIButton *)sender {
    int chosenButtonIndex = (int)[self.cardButtons indexOfObject:sender];
    if (chosenButtonIndex == self.previousChosenCardIndex) return;

    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];

    self.previousChosenCardIndex = chosenButtonIndex;
}

- (void)onDealButtonTouch:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[self createDeck]
                                   withRequiredMatcheeCount:1];

    [self updateUI];
    self.history = [[NSMutableArray alloc] init];
    self.collectionView.lastResultLabel.attributedText = [[NSAttributedString alloc] initWithString:@""];
    // set to dummy index / little hackish but at least comparing i is faster than comparing objs?
    self.previousChosenCardIndex = -1;
}

- (void)onHistoryButtonTouch:(UIBarButtonItem *)sender {
    HistoryViewController *historyViewCtrl = [[HistoryViewController alloc] init];
    historyViewCtrl.history = self.history;
    [self.navigationController pushViewController:historyViewCtrl
                                         animated:YES];
}

#pragma mark - Utility Methods

- (void)updateScoreLabel {
    self.collectionView.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (void)updateLastResultLabelWithPreviousResult:(NSArray *)previouslyMatchedCards
                                    scoreChange:(int)scoreChange {
    NSArray *mappedArray = [previouslyMatchedCards map:^id(Card *obj) {
        return obj.contents;
    }];
    NSString *contentString = [mappedArray componentsJoinedByString:@""];
    NSString *string = [NSString stringWithFormat:@"%@ at %d points", contentString, scoreChange];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    self.collectionView.lastResultLabel.attributedText = attributeString;
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];

        [cardButton setAttributedTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];

        cardButton.enabled = !card.isMatched;
    }

    [self updateScoreLabel];
    [self updateLastResultLabelWithPreviousResult:self.game.previouslyMatchedCards
                                      scoreChange:self.game.scoreChange];

    [self.history addObject:self.collectionView.lastResultLabel.attributedText];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    NSString *string = card.isChosen ? card.contents : @"";
    return [[NSAttributedString alloc] initWithString:string];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    NSString *imageName = card.isChosen ? @"cardfront" : @"cardback";
    return [UIImage imageNamed:imageName];
}

#pragma mark - Performance

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
