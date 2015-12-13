//
//  ViewController.m
//  Matchismo
//
//  Created by Davis Koh on 12/1/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "CardView.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

// FIXME: find better way to do below than overriding collectionView prop
@property (strong, nonatomic) CardTableView *collectionView;

@property (strong, nonatomic) NSMutableArray *cardButtons; // of CardViews

@property (strong, nonatomic) NSMutableArray *history;

@property (nonatomic) int previousChosenCardIndex;

@end

@implementation CardGameViewController

@dynamic collectionView;

- (instancetype)init {
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];

    return self;
}

#pragma mark - Getters & Setters

- (NSMutableArray *)cardButtons {
    if (!_cardButtons) _cardButtons = [[NSMutableArray alloc] init];
    return _cardButtons;
}

- (Deck *)createDeck { // abstract
    return nil;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                 usingDeck:[self createDeck]];
        _game.requiredMatcheeCount = 1;
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

    self.collectionView = [self createCardTableView];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView.dealButton addTarget:self
                        action:@selector(onDealButtonTouch:)
              forControlEvents:UIControlEventTouchUpInside];
    
    [self.collectionView.historySlider addTarget:self
                           action:@selector(onSliderValueChange:)
                 forControlEvents:UIControlEventValueChanged];
}

#pragma mark - UICollectionViewDataSource protocol

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    // 4 x 3
    return 12;
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
                                                  usingDeck:[self createDeck]];
    [self updateUI];
    self.history = [[NSMutableArray alloc] init];
    self.collectionView.lastResultLabel.text = @"";
    // set to dummy index / little hackish but at least comparing i is faster than comparing objs?
    self.previousChosenCardIndex = -1;
}

- (void)onSliderValueChange:(UISlider *)sender {
    int i = (int)(sender.value + 0.5);

    // if index NOT out of bounds then update label
    if (i < self.history.count) {
        self.collectionView.lastResultLabel.text = self.history[i];
    }

}

#pragma mark - Utility Methods

- (void)updateScoreLabel {
    self.collectionView.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (void)updateLastResultLabelWithPreviousResult:(NSString *)previousResult
                                    scoreChange:(int)scoreChange {
    self.collectionView.lastResultLabel.text = [NSString stringWithFormat:@"%@ at %d points", previousResult, scoreChange];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = (int)[self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];

        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];

        cardButton.enabled = !card.isMatched;
    }

    [self updateScoreLabel];
    [self updateLastResultLabelWithPreviousResult:self.game.previousResult
                                      scoreChange:self.game.scoreChange];

    [self.history addObject:self.collectionView.lastResultLabel.text];
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
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
