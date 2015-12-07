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

@interface CardGameViewController ()

@property (strong, nonatomic) Deck *deck;

@property (strong, nonatomic) UILabel *countLabel;

@end

@implementation CardGameViewController

@dynamic view;

- (instancetype)init {
    self = [super initWithCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];

    return self;
}

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cardCell"];

    [self.collectionView setBackgroundColor:[UIColor greenColor]];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    // 4 x 3
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell"
                                                                           forIndexPath:indexPath];

    // TODO: use card views
    //CardView *card = [[CardView alloc] init];
    UIView *card = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    card.backgroundColor = [UIColor redColor];

    [cell.contentView addSubview:card];

    return cell;
}

#pragma mark - Getters & Setters

- (Deck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    return _deck;
}

#pragma mark - Event Handlers

- (void)onButtonClick:(UIButton *)sender {
    NSString *imageName,
        *title = @"";

    if ([sender.currentTitle length]) {
        imageName = @"cardback.png";

        [sender setBackgroundImage:[UIImage imageNamed:imageName]
                              forState:UIControlStateNormal];
    } else {
        imageName = @"cardfront.png";

        Card *card = [self.deck drawRandomCard];

        // stop flipping when deck runs out
        if (card) {
            [sender setBackgroundImage:[UIImage imageNamed:imageName]
                              forState:UIControlStateNormal];

            title = card.contents;
        }
    }

    [sender setTitle:title
          forState:UIControlStateNormal];
}

#pragma mark - Performance

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
