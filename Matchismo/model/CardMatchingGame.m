//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/1/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, nonatomic) LastMove *lastMove;
@property (nonatomic) int matchBonus;
@property (nonatomic) int mismatchPenalty;
@property (readwrite,nonatomic) NSIndexSet *indexesOfInsertedCards;


@end



@implementation CardMatchingGame

#define FLIP_COST 1

- (NSMutableArray *)cards
{
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;	
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matchingNumberOfCard:(NSUInteger)cardsToMatch matchBonus:(NSUInteger)bonus mismatchPenalty:(NSUInteger)penalty
{
    self = [super init];
    
    if (self) {
        self.numberOfCardsToMatch = cardsToMatch;
        self.matchBonus = bonus;
        self.mismatchPenalty = penalty;
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
        
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    self.lastMove = [[LastMove alloc] init];
    NSString *lastMoveText;
    NSArray *lastMoveCards;
    NSUInteger points = 0;
    
    if (!card.isUnplayable) {   
        if (!card.isFaceUp) {
            self.lastMove = [[LastMove alloc] init];
            lastMoveText = @"Flipped up";

            //Gather Other Cards
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            NSMutableArray *cardsForLastMove = [[NSMutableArray alloc] init];
            [cardsForLastMove addObject:card];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    [cardsForLastMove addObject:otherCard];
                }
            }
            if (otherCards.count == self.numberOfCardsToMatch -1) {
                int matchScore = [card match:[otherCards copy]];
                
                if (matchScore) {
                    for (Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    self.score += matchScore * self.matchBonus;
                    lastMoveText = @"Matched";
                    points = matchScore * self.matchBonus;
                } else {
                    for (Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= self.mismatchPenalty;
                    lastMoveText = @"Mismatch";
                    points = -self.mismatchPenalty;
                }
                lastMoveCards = [cardsForLastMove copy];
            } else {
                [otherCards addObject:card];
                lastMoveCards = otherCards;
            }
        
            self.score -= FLIP_COST;
        } else {
            lastMoveText = @"Flipped down";
            lastMoveCards = @[card];
        }
        card.faceUp = !card.isFaceUp;
    }
    self.lastMove.lastMove = lastMoveText;
    self.lastMove.cards = lastMoveCards;
    self.lastMove.points = points;
}

- (LastMove *)lastMove
{
    if (!_lastMove)
        _lastMove = [[LastMove alloc] init];
    return _lastMove;
}

- (void)addCards:(NSArray *)cards
{
    NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
    if (cards){
        for (Card *card in cards) {
            [self.cards addObject:card];
            [indexes addIndex: [self.cards indexOfObject:card]];
        }
        self.indexesOfInsertedCards = indexes;
    } else {
        self.indexesOfInsertedCards = nil;
    }
}

- (void)removeCard:(Card *)card
{
    [self.cards removeObject:card];
}

- (NSInteger)cardsInPlay
{
    return [self.cards count];
}

- (NSIndexSet  *)indexesOfInsertedCards
{
    if (!_indexesOfInsertedCards) {
        _indexesOfInsertedCards = [[NSIndexSet alloc] init];
    }
    return _indexesOfInsertedCards ;
}

-(NSInteger) indexOfCard:(Card *)card
{
    return [self.cards indexOfObject:card];
}

@end
