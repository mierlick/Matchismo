//
//  PlayingCard.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/1/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (NSString *)contents
{
    NSArray *rankString = [PlayingCard rankString];
    return [rankString[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    NSMutableSet *rankSet = [[NSMutableSet alloc] init];
    NSMutableSet *suitSet = [[NSMutableSet alloc] init];
    
    [rankSet addObject:[[NSNumber alloc] initWithInt:self.rank]];
    [suitSet addObject:self.suit];
    
    if (suitSet.count == 1) {
        
    } else if (rankSet.count == 1) {
        
    }
    
    //Match Suit
    for (PlayingCard *otherCard in otherCards) {
        if (![otherCard.suit isEqualToString:self.suit]) {
            score = 0;
            break;
        }
        score = 1 * otherCards.count;
    }
    
    //Match Rank
    if (!score) {
        for (PlayingCard *otherCard in otherCards) {
            if (otherCard.rank != self.rank) {
                score = 0;
                break;
            }
            score = 4 * otherCards.count;
        }
    }
    
    
    return score;
}

+ (NSArray *)validSuits
{
    return @[@"♠",@"♣",@"♥",@"♦"];
}

+ (NSArray *)rankString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSInteger)maxRank
{
    return [self rankString].count-1;
}

@end
