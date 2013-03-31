//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Matthew I Erlick on 3/28/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (readonly, nonatomic) NSUInteger startingCardCount; // abstract
@property (readonly, nonatomic) NSUInteger numberOfCardsToMatch; // abstract
@property (readonly, nonatomic) NSUInteger matchBonus; // abstract
@property (readonly, nonatomic) NSUInteger mismatchPenalty; // abstract
@property (readonly, nonatomic) int flipCount;
@property (readonly, strong, nonatomic) CardMatchingGame *game;



- (Deck *)createDeck; // abstract
- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card; // abstract
- (UIView*) createCardViewUsingCard:(Card*) card; // abstract
- (void)updateUI;
- (IBAction)deal;

@end
