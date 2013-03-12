//
//  SetViewController.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/4/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"
#import "SetCard.h"

@interface SetViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;

@end

@implementation SetViewController

#define THREE_CARD_GAME 3

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
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        UIColor *color =  [self getUIColor:card.color];
        CGFloat alpha = [self getAlpha:card.shade];
        
        NSDictionary *style = @{NSFontAttributeName : [UIFont systemFontOfSize:18],
                                NSForegroundColorAttributeName : [color colorWithAlphaComponent:alpha],
                                NSStrokeWidthAttributeName :  @-3,
                                NSStrokeColorAttributeName : color};
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:card.contents attributes:style];
        
        [cardButton setAttributedTitle:attributedString forState:UIControlStateNormal];
        
        
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        if (!card.isFaceUp) {
            [cardButton setBackgroundColor:[UIColor whiteColor]];
        } else {
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
        }
        
    }
    self.scoreLabel.text =[NSString stringWithFormat:@"Score: %d", self.game.score];
    [self setLastMoveLabelFromLastMove:self.game.lastMove];
}

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc]init] matchingNumberOfCard:THREE_CARD_GAME matchBonus:4 mismatchPenalty:2];
    }
    
    return _game;
}

- (IBAction)newGame:(id)sender
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}


- (UIColor *) getUIColor:(NSString *)color
{
    if ([color isEqualToString:@"red"]) {
        return [UIColor redColor];
    } else if ([color isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    } else if ([color isEqualToString:@"green"]) {
        return [UIColor greenColor];
    }
    
    return [UIColor whiteColor];
}

- (CGFloat)getAlpha:(NSString *)shade
{
    if ([shade isEqualToString:@"striped"]) {
        return 0.3;
    } else if ([shade isEqualToString:@"open"]) {
        return 0.0;
    }
    
    return 1.0;
}

- (void)setLastMoveLabelFromLastMove:(LastMove *)lastMove
{
    if (!lastMove.lastMove) {
        self.lastMoveLabel.text = nil;
    } else if (lastMove.cards.count == 1) {
        SetCard *card = [lastMove.cards lastObject];
        UIColor *color =  [self getUIColor:card.color];
        CGFloat alpha = [self getAlpha:card.shade];
        
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:lastMove.lastMove];
        NSAttributedString *attributedCardString = [[NSAttributedString alloc] initWithString:card.contents attributes:[self getDictionaryStyleForLastMove:alpha withColor:color]];
        [mutableAttributedString insertAttributedString:attributedCardString atIndex:[mutableAttributedString length]];
        
        self.lastMoveLabel.attributedText = [mutableAttributedString copy];
    } else if (lastMove.cards.count > 1) {
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:lastMove.lastMove];

        for (SetCard * setCard in lastMove.cards) {
            UIColor *color =  [self getUIColor:setCard.color];
            CGFloat alpha = [self getAlpha:setCard.shade];
  
            NSString *contents = [[NSString alloc] initWithFormat:@" %@", setCard.contents];
            NSAttributedString *attributedCardString = [[NSAttributedString alloc] initWithString:contents attributes:[self getDictionaryStyleForLastMove:alpha withColor:color]];
            [mutableAttributedString insertAttributedString:attributedCardString atIndex:[mutableAttributedString length]];
        }
        
        [mutableAttributedString insertAttributedString:[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" for %d points", lastMove.points]] atIndex:[mutableAttributedString length]];
        self.lastMoveLabel.attributedText = [mutableAttributedString copy];
    }
}

- (NSDictionary *)getDictionaryStyleForLastMove:(CGFloat)alpha withColor:(UIColor *)color
{
   return @{NSFontAttributeName : [UIFont systemFontOfSize:18],
            NSForegroundColorAttributeName : [color colorWithAlphaComponent:alpha],
            NSStrokeWidthAttributeName :  @-3,
            NSStrokeColorAttributeName : color};
}

@end
