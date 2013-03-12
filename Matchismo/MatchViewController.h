//
//  MatchViewController.h
//  Matchismo
//
//  Created by Matthew I Erlick on 3/12/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface MatchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;

- (IBAction)newGame:(id)sender;
- (void)updateUI;
- (NSArray *)cardButtons;

@end
