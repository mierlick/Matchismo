//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/1/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "MatchismoViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"

@interface MatchismoViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *matchControl;

@end

@implementation MatchismoViewController

#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define STARTING_CARD_COUNT 24
#define DEFAULT_NUMBER_OF_CARDS_TO_MATCH 2

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (NSUInteger)startingCardCount
{
    return STARTING_CARD_COUNT;
}

- (NSUInteger) numberOfCardsToMatch
{
    return DEFAULT_NUMBER_OF_CARDS_TO_MATCH + self.matchControl.selectedSegmentIndex;
}

- (NSUInteger) matchBonus
{
    return MATCH_BONUS;
}

- (NSUInteger) mismatchPenalty
{
    return MISMATCH_PENALTY;
}

- (BOOL)removeCards
{
    return NO;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]) {
        PlayingCardView *playingCardView = ((PlayingCardCollectionViewCell *)cell).playingCardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *playingCard = (PlayingCard *)card;
            playingCardView.rank = playingCard.rank;
            playingCardView.suit = playingCard.suit;
            playingCardView.faceUp = playingCard.isFaceUp;
            playingCardView.alpha = playingCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

- (void)updateUI
{
    [super updateUI];
    if (self.flipCount != 0) {
        self.matchControl.enabled = NO;
    } else {
        self.matchControl.enabled = YES;
    }
}

- (IBAction)gameChanger:(UISegmentedControl *)sender
{
    self.game.numberOfCardsToMatch = sender.selectedSegmentIndex + 2;
}

- (UIView*) createCardViewUsingCard:(Card*) card
{
    PlayingCardView *playingCardView;
    if([card isKindOfClass:[PlayingCard class]]){
        PlayingCard *playingCard = (PlayingCard*)card;
        playingCardView = [[PlayingCardView alloc]init];
        playingCardView.suit = playingCard.suit;
        playingCardView.rank = playingCard.rank;
        playingCardView.faceUp = YES;
    }
    return playingCardView;
}

@end
