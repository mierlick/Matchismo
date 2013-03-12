//
//  MatchViewController.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/12/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "MatchViewController.h"
#import "CardMatchingGame.h"

@interface MatchViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;

@end

@implementation MatchViewController

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)newGame:(id)sender
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (void)updateUI
{
    //Do nothing here override in sub classes.
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

@end
