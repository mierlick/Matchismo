//
//  PlayingCardView.h
//  Matchismo
//
//  Created by Matthew I Erlick on 3/20/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end
