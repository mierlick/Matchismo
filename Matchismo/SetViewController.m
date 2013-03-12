//
//  SetViewController.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/4/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "SetViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetViewController ()

@end

@implementation SetViewController

@synthesize game = _game;

#define THREE_CARD_GAME 3

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

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc]init] matchingNumberOfCard:THREE_CARD_GAME matchBonus:4 mismatchPenalty:2];
    }
    
    return _game;
}

- (NSDictionary *)getDictionaryStyleForLastMove:(CGFloat)alpha withColor:(UIColor *)color
{
   return @{NSFontAttributeName : [UIFont systemFontOfSize:18],
            NSForegroundColorAttributeName : [color colorWithAlphaComponent:alpha],
            NSStrokeWidthAttributeName :  @-3,
            NSStrokeColorAttributeName : color};
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

@end
