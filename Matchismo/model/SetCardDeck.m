//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/5/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *color in [SetCard validColors]) {
            for (NSString *shape in [SetCard validShapes]) {
                for (NSString *shade in [SetCard validShades]) {
                    for (int i = 1; i <= 3; i++) {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.shape = shape;
                        card.shade = shade;
                        card.rank = i;
                        [self addCard:card atTop:YES];
                    }
                }
            }
            
        }
    }
    
    return self;
}

@end
