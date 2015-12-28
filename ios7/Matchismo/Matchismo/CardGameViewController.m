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
#import "CardMatchingGame.h"
#import "NSArray+NSArray_KOHMap.h"

@interface CardGameViewController ()

// FIXME: find better way to do below than overriding collectionView prop
@property (strong, nonatomic) CardTableView *collectionView;

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

- (int)previousChosenCardIndex {
    if (!_previousChosenCardIndex) _previousChosenCardIndex = -1;
    return _previousChosenCardIndex;
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

// abstract
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
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

- (void)addScore:(NSInteger)score forGameType:(NSString *)gameType {
    NSString *key = [gameType stringByAppendingString:@"HighScores"];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *scores = [defaults arrayForKey:key].mutableCopy;

    if (!scores.count) {
        scores = @[].mutableCopy;
    }

    NSNumber *scoreObj = @(score);
    [scores addObject:scoreObj];

    NSSortDescriptor *scoreDescriptor = [[NSSortDescriptor alloc] initWithKey:@"intValue"
                                                                    ascending:NO];
    NSArray *sortDescriptors = @[scoreDescriptor];
    NSArray *sortedArray = [scores sortedArrayUsingDescriptors:sortDescriptors];

    if (sortedArray.count > 2) {
        sortedArray = [sortedArray subarrayWithRange:NSMakeRange(0, 3)].mutableCopy;
    }

    [defaults setObject:sortedArray
                 forKey:key];
}

- (void)onCardChosen:(UITapGestureRecognizer *)sender {
    int chosenButtonIndex = (int)[self.cardButtons indexOfObject:sender.view];
    if (chosenButtonIndex == self.previousChosenCardIndex) return;

    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUIAndAnimate:NO];
    [self flipCardView:sender.view];

    self.previousChosenCardIndex = chosenButtonIndex;

    [self addScore:self.game.score
       forGameType:self.title];
}

- (void)onDealButtonTouch:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[self createDeck]
                                   withRequiredMatcheeCount:1];

    [self updateUIAndAnimate:YES];
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

- (void)updateCardsAndAnimate:(BOOL)animate {} // abstract / MUST be implemented

- (void)updateUIAndAnimate:(BOOL)animate {
    [self updateCardsAndAnimate:animate];

    [self updateScoreLabel];
    [self updateLastResultLabelWithPreviousResult:self.game.previouslyMatchedCards
                                      scoreChange:self.game.scoreChange];

    [self.history addObject:self.collectionView.lastResultLabel.attributedText];
}

#pragma Animation

- (void)flipCardView:(UIView *)cardView {
    [UIView transitionWithView:cardView
                          duration:0.2
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:nil
                        completion:nil];
}

#pragma mark - Performance

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
