//
//  FlipResultView.h
//  Matchismo
//
//  Created by Matthew I Erlick on 3/30/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipResultView : UIView

@property (strong,nonatomic) NSString *resultString;
-(void) addCardView:(UIView*)cardView;
-(void) removeAllCardViews;

@end
