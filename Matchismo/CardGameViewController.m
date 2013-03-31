//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/28/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "CardGameViewController.h"
#import "FlipResultView.h"

@interface CardGameViewController () <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@property (weak, nonatomic) IBOutlet FlipResultView *flipResultView;


@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount usingDeck:[self createDeck] matchingNumberOfCard:self.numberOfCardsToMatch matchBonus:self.matchBonus mismatchPenalty:self.mismatchPenalty];
    }
    
    return _game;
}

- (Deck *)createDeck
{
    return nil; // abstract
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // abstract
}


- (void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self setFlipResultFromLastMove:self.game.lastMove];
}

- (void)setFlipResultFromLastMove:(LastMove *)lastMove
{
    if (lastMove.cards.count < self.game.numberOfCardsToMatch) {
        self.flipResultView.resultString = lastMove.lastMove;
    } else {
        self.flipResultView.resultString = [NSString stringWithFormat:@"%@ for %d points", lastMove.lastMove, lastMove.points];
    }
    
    [self.flipResultView removeAllCardViews];
    NSArray *cards = lastMove.cards;
    for (Card *card in cards) {
        [self.flipResultView addCardView:[self createCardViewUsingCard:card]];
    }
    
}

- (IBAction)deal
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        self.flipCount++;
        [self updateUI];
    }
}

- (UIView*) createCardViewUsingCard:(Card*) card
{
    return nil; // abstract
}

@end
