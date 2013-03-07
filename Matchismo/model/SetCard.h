//
//  SetCard.h
//  Matchismo
//
//  Created by Matthew I Erlick on 3/5/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic)NSString *color;
@property (strong, nonatomic)NSString *shape;
@property (strong, nonatomic)NSString *shade;
@property (nonatomic)NSUInteger rank;

+ (NSArray *)validColors;
+ (NSArray *)validShapes;
+ (NSArray *)validShades;

@end
