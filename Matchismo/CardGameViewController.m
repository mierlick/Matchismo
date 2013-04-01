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


- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [self.game cardsInPlay];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Card" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    
    // Score
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    // Result
    if (self.game.lastMove.cards.count < self.game.numberOfCardsToMatch) {
        self.flipResultView.resultString = self.game.lastMove.lastMove;
    } else {
        self.flipResultView.resultString = [NSString stringWithFormat:@"%@ for %d points", self.game.lastMove.lastMove, self.game.lastMove.points];
    }
    
    [self.flipResultView removeAllCardViews];
    NSArray *cards = self.game.lastMove.cards;
    for (Card *card in cards) {
        [self.flipResultView addCardView:[self createCardViewUsingCard:card]];
    }
    
    // Remove Match
    if( self.game.lastMove.points > 0 && self.removeCards ) {
        NSArray *cardsToRemove = cards;
        NSMutableArray *cardIndexesToBeDeleted = [[NSMutableArray alloc]init];
        NSMutableArray *removedCard = [[NSMutableArray alloc]init];
        
        for(Card *card in cardsToRemove){
            // remove card from model
            [cardIndexesToBeDeleted addObject:[NSIndexPath indexPathForItem:[self.game indexOfCard:card] inSection:0]];
        }
        
        for(Card *card in cardsToRemove){
            [self.game removeCard:card];
            [removedCard addObject:card];
        }
        
        [self.cardCollectionView performBatchUpdates:^{
            [self.cardCollectionView deleteItemsAtIndexPaths:cardIndexesToBeDeleted];
        } completion:^(BOOL finished) {
        }];
    }
    
    [self.cardCollectionView reloadData];
}

- (IBAction)deal
{
    self.game = nil;
    self.flipCount = 0;
    [self.cardCollectionView reloadData];
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

- (void) addCards:(NSArray *)cards
{
    [self.game addCards:[cards copy]];
    
    NSMutableArray *indexPathsOfInsertedCards = [NSMutableArray array];
    NSIndexSet *indexes = self.game.indexesOfInsertedCards;
    
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [indexPathsOfInsertedCards addObject:[NSIndexPath indexPathForItem:idx inSection:0]];
    }];
    
    [self.cardCollectionView performBatchUpdates:^{
        [self.cardCollectionView insertItemsAtIndexPaths:indexPathsOfInsertedCards];
    } completion:nil];
    
    [self.cardCollectionView scrollToItemAtIndexPath:[indexPathsOfInsertedCards lastObject] atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

- (UIView*) createCardViewUsingCard:(Card*) card
{
    return nil; // abstract
}


- (Deck *)createDeck
{
    return nil; // abstract
}


- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // abstract
}

@end
