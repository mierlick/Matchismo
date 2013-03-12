//
//  MatchismoViewController.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/1/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "MatchismoViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface MatchismoViewController ()
		
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchControl;

@end

@implementation MatchismoViewController

#define TWO_CARD_GAME 2

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

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
            UIImage *cardBack = [UIImage imageNamed:@"phoenix-mobile.png"];
            [cardButton setImage:cardBack forState:UIControlStateNormal];
        } else {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
        
    }
    self.scoreLabel.text =[NSString stringWithFormat:@"Score: %d", self.game.score];
    [self setLastMoveLabelFromLastMove:self.game.lastMove];
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
    self.game = nil;
    self.flipCount = 0;
    self.matchControl.selectedSegmentIndex = 0;
    [self updateUI];
}

- (IBAction)gameChanger:(UISegmentedControl *)sender
{
    self.game.numberOfCardsToMatch = sender.selectedSegmentIndex + 2;
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

@end
