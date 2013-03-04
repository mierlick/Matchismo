//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/1/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;

@end



@implementation CardMatchingGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (NSMutableArray *)cards
{
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    return _cards;	
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matchingNumberOfCard:(NSUInteger)cardsToMatch
{
    self = [super init];
    
    if (self) {
        self.numberOfCardsToMatch = cardsToMatch;
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
    
    if (!card.isUnplayable) {   
        if (!card.isFaceUp) {
            self.lastMove = [NSString stringWithFormat:@"Flipped up %@", card.contents];

            //Gather Other Cards
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                }
            }
            if (otherCards.count == self.numberOfCardsToMatch -1) {
                int matchScore = [card match:[otherCards copy]];
                
                if (matchScore) {
                    for (Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    self.score += matchScore * MATCH_BONUS;
                    NSString *matchString = [NSString stringWithFormat:@"Matched %@", card.contents];
                    for (Card * otherCard in otherCards) {
                        matchString = [NSString stringWithFormat:@"%@, %@", matchString, otherCard.contents];
                    }
                    self.lastMove = matchString;
                } else {
                    for (Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                    }
                    self.score -= MISMATCH_PENALTY;
                    NSString *misMatchString = [NSString stringWithFormat:@"Cards Dont Match %@", card.contents];
                    for (Card * otherCard in otherCards) {
                        misMatchString = [NSString stringWithFormat:@"%@, %@", misMatchString, otherCard.contents];
                    }
                    self.lastMove = misMatchString;
                }
            }
        
            self.score -= FLIP_COST;
        } else {
            self.lastMove = [NSString stringWithFormat:@"Flipped down %@", card.contents];
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
