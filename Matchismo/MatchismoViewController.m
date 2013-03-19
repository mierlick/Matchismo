//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/1/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "MatchismoViewController.h"
#import "PlayingCardDeck.h"

@interface MatchismoViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *matchControl;

@end

@implementation MatchismoViewController

@synthesize game = _game;

#define TWO_CARD_GAME 2

- (void)updateUI
{
    if (self.flipCount != 0) {
        self.matchControl.enabled = NO;
    } else {
        self.matchControl.enabled = YES;
    }
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];

        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if (!card.isFaceUp) {
            UIImage *cardBack = [UIImage imageNamed:@"phoenix-mobile"];
            [cardButton setImage:cardBack forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
        
    }
    self.scoreLabel.text =[NSString stringWithFormat:@"Score: %d", self.game.score];
    [self setLastMoveLabelFromLastMove:self.game.lastMove];
}

- (void)setLastMoveLabelFromLastMove:(LastMove *)lastMove
{
    if (!lastMove.lastMove) {
        self.lastMoveLabel.text = nil;
    } else if (lastMove.cards.count == 1) {
        Card *card = [lastMove.cards lastObject];
        self.lastMoveLabel.text = [[NSString alloc] initWithFormat:@"%@ %@", lastMove.lastMove, card.contents];
    } else {
        NSString *lastMoveString = [NSString stringWithFormat:@"%@", lastMove.lastMove];
        for (Card * otherCard in lastMove.cards) {
            lastMoveString = [NSString stringWithFormat:@"%@ %@", lastMoveString, otherCard.contents];
        }
        lastMoveString = [NSString stringWithFormat:@"%@ for %d points", lastMoveString, lastMove.points];
        self.lastMoveLabel.text = lastMoveString;
    }
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc]init] matchingNumberOfCard:TWO_CARD_GAME matchBonus:4 mismatchPenalty:2];
    }
    
    return _game;
}



- (IBAction)newGame:(id)sender
{
    [super newGame:sender];
    self.matchControl.selectedSegmentIndex = 0;
}

- (IBAction)gameChanger:(UISegmentedControl *)sender
{
    self.game.numberOfCardsToMatch = sender.selectedSegmentIndex + 2;
}



@end
