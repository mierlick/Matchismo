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
    int numberOfCardsInSet = otherCards.count+1;
    
    NSMutableSet *rankSet = [[NSMutableSet alloc] init];
    NSMutableSet *colorSet = [[NSMutableSet alloc] init];
    NSMutableSet *shapeSet = [[NSMutableSet alloc] init];
    NSMutableSet *shadeSet = [[NSMutableSet alloc] init];
    
    [rankSet addObject:[[NSNumber alloc] initWithInt:self.rank]];
    [colorSet addObject:self.color];
    [shapeSet addObject:self.shape];
    [shadeSet addObject:self.shade];
    
    for (SetCard *otherCard in otherCards) {
        [rankSet addObject:[[NSNumber alloc] initWithInt:otherCard.rank]];
        [colorSet addObject:otherCard.color];
        [shapeSet addObject:otherCard.shape];
        [shadeSet addObject:otherCard.shade];
    }
    
    if (rankSet.count == numberOfCardsInSet
        || colorSet.count == numberOfCardsInSet
        || shapeSet.count == numberOfCardsInSet
        || shadeSet.count == numberOfCardsInSet
        || rankSet.count == 1
        || colorSet.count == 1
        || shapeSet.count == 1
        || shadeSet.count == 1) {
        score = 1 * otherCards.count;
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
