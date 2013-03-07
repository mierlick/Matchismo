//
//  SetCard.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/5/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize shape = _shape;

- (NSString *)contents
{
    NSMutableString *contents = [[NSMutableString alloc] init];
    for (int i = 1; i <= self.rank; i++) {
        contents = [NSMutableString stringWithFormat:@"%@%@", contents, self.shape];
    }
    return contents;
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void)setShade:(NSString *)shade
{
    if ([[SetCard validShades] containsObject:shade]) {
        _shade = shade;
    }
}

- (void)setShape:(NSString *)shape
{
    if ([[SetCard validShapes] containsObject:shape]) {
        _shape = shape;
    }
}

- (NSString *)shape
{
    return _shape ? _shape : @"?";
}


- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    //Match Rank
    for (SetCard *otherCard in otherCards) {
        if (otherCard.rank != self.rank) {
            score = 0;
            break;
        }
        score = 1 * otherCards.count;
    }
    
    //Match Shade
    if (!score) {
        for (SetCard *otherCard in otherCards) {
            if ([otherCard.shade isEqualToString:self.shade]) {
                score = 0;
                break;
            }
            score = 2 * otherCards.count;
        }
    }
    
    //Match Shape
    if (!score) {
        for (SetCard *otherCard in otherCards) {
            if ([otherCard.shape isEqualToString:self.shape]) {
                score = 0;
                break;
            }
            score = 3 * otherCards.count;
        }
    }
    

    //Match Color
    if (!score) {
        for (SetCard *otherCard in otherCards) {
            if (![otherCard.color isEqualToString:self.color]) {
                score = 0;
                break;
            }
            score = 4 * otherCards.count;
        }
    }
    
    return score;
}

+ (NSArray *)validColors
{
    return @[@"red",@"blue",@"green"];
}

+ (NSArray *)validShapes
{
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)validShades
{
    return @[@"solid",@"striped",@"open"];
}

@end
