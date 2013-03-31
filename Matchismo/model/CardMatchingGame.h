//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Matthew I Erlick on 3/1/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "LastMove.h"

@interface CardMatchingGame : NSObject

@property (nonatomic)int numberOfCardsToMatch;
@property (nonatomic, readonly)int score;
@property (strong, nonatomic, readonly) LastMove *lastMove;
@property (readonly,nonatomic) NSIndexSet *indexesOfInsertedCards;


- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matchingNumberOfCard:(NSUInteger)cardsToMatch matchBonus:(NSUInteger)bonus mismatchPenalty:(NSUInteger)penalty;
- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)removeCard:(Card *)card;
- (void)addCards:(NSArray *)cards;
- (NSInteger)cardsInPlay;
-(NSInteger) indexOfCard:(Card *)card;

@end
