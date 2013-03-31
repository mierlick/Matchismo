//
//  PlayingCardCollectionViewCell.h
//  Matchismo
//
//  Created by Matthew I Erlick on 3/20/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
