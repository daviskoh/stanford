//
//  ViewController.m
//  Matchismo
//
//  Created by Davis Koh on 12/1/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardView.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;

@property (strong, nonatomic) NSMutableArray *cardButtons; // of CardViews

@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UIButton *dealButton;
@property (strong, nonatomic) UISwitch *modeSwitch;
@property (strong, nonatomic) UILabel *lastResultLabel;
@property (strong, nonatomic) UISlider *historySlider;

@property (strong, nonatomic) NSMutableArray *history;

@end

@implementation CardGameViewController

@dynamic view;

- (instancetype)init {
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];

    return self;
}

#pragma mark - Getters & Setters

- (NSMutableArray *)cardButtons {
    if (!_cardButtons) _cardButtons = [[NSMutableArray alloc] init];
    return _cardButtons;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                 usingDeck:[[PlayingCardDeck alloc] init]];
        _game.requiredMatcheeCount = 1;
    }
    return _game;
}

- (NSMutableArray *)history {
    if (!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];

    // OPTIMIZE: use custom collection view so all this view logic is abstracted out of ctrl
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"cardCell"];

    [self.collectionView setBackgroundColor:[UIColor greenColor]];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    // add score label
    self.scoreLabel = [[UILabel alloc] init];
    self.scoreLabel.text = @"Score: 0";
    [self.scoreLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.scoreLabel];

    NSLayoutConstraint *yConstraint = [NSLayoutConstraint constraintWithItem:self.scoreLabel
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.9
                                                                    constant:0];
    [self.view addConstraint:yConstraint];

    self.dealButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [self.dealButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.dealButton setTitle:@"Deal" forState:UIControlStateNormal];
    [self.view addSubview:self.dealButton];
    [self.dealButton addTarget:self
                        action:@selector(onDealButtonTouch:)
              forControlEvents:UIControlEventTouchUpInside];

    NSLayoutConstraint *dealButtonYConstraint = [NSLayoutConstraint constraintWithItem:self.dealButton
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.9
                                                                    constant:0];

    NSLayoutConstraint *dealButtonXConstraint = [NSLayoutConstraint constraintWithItem:self.dealButton
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1.8
                                                                    constant:0];

    [self.view addConstraints:@[dealButtonYConstraint, dealButtonXConstraint]];

    self.modeSwitch = [[UISwitch alloc] init];
    [self.modeSwitch setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.modeSwitch];
    [self.modeSwitch addTarget:self
                        action:@selector(onSwitchToggle:)
              forControlEvents:UIControlEventTouchUpInside];

    NSLayoutConstraint *modeSwitchYConstraint = [NSLayoutConstraint constraintWithItem:self.modeSwitch
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.9
                                                                    constant:0];

    NSLayoutConstraint *modeSwitchXConstraint = [NSLayoutConstraint constraintWithItem:self.modeSwitch
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:0];

    [self.view addConstraints:@[modeSwitchYConstraint, modeSwitchXConstraint]];

    self.lastResultLabel = [[UILabel alloc] init];
    self.lastResultLabel.text = @"Last Result";
    self.lastResultLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.lastResultLabel];

    NSLayoutConstraint *lastResultYConstraint = [NSLayoutConstraint constraintWithItem:self.lastResultLabel
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.8
                                                                    constant:0];
    [self.view addConstraint:lastResultYConstraint];

    self.historySlider = [[UISlider alloc] init];
    self.historySlider.minimumValue = 0;
    self.historySlider.maximumValue = 2;
    self.historySlider.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.historySlider];
    [self.historySlider addTarget:self
                           action:@selector(onSliderValueChange:)
                 forControlEvents:UIControlEventValueChanged];

    NSLayoutConstraint *historySliderXConstraint = [NSLayoutConstraint constraintWithItem:self.historySlider
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:0];

    NSLayoutConstraint *historySliderYConstraint = [NSLayoutConstraint constraintWithItem:self.historySlider
                                                                   attribute:NSLayoutAttributeCenterY
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1.7
                                                                    constant:0];

    NSLayoutConstraint *historySliderWidthConstraint = [NSLayoutConstraint constraintWithItem:self.historySlider
                                                                   attribute:NSLayoutAttributeWidth
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeWidth
                                                                  multiplier:0.8
                                                                    constant:0];

    [self.view addConstraints:@[historySliderXConstraint, historySliderYConstraint, historySliderWidthConstraint]];
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

// FIXME: prevent card from matching with itself
// try tapping same card twice
- (void)onCardChosen:(UIButton *)sender {
    int chosenButtonIndex = (int)[self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];

    self.modeSwitch.enabled = NO;
}

- (void)onDealButtonTouch:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    [self updateUI];
    self.modeSwitch.enabled = YES;
}

- (void)onSwitchToggle:(UISwitch *)sender {
    self.game.requiredMatcheeCount = self.game.requiredMatcheeCount == 1 ? 2 : 1;
}

- (void)onSliderValueChange:(UISlider *)sender {
    int i = (int)(sender.value + 0.5);

    // if index NOT out of bounds then update label
    if (i < self.history.count) {
        self.lastResultLabel.text = self.history[i];
    }

}

#pragma mark - Utility Methods

- (void)updateScoreLabel {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (void)updateLastResultLabelWithPreviousResult:(NSString *)previousResult
                                    scoreChange:(int)scoreChange {
    self.lastResultLabel.text = [NSString stringWithFormat:@"%@ at %d points", previousResult, scoreChange];
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

    [self.history addObject:self.lastResultLabel.text];
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
