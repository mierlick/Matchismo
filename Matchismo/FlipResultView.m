//
//  FlipResultView.m
//  Matchismo
//
//  Created by Matthew I Erlick on 3/30/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import "FlipResultView.h"
#import "Card.h"

@interface FlipResultView()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardViewCollection;
@property (strong, nonatomic) NSMutableArray *cardViewList;

@end

@implementation FlipResultView

-(void)setResultString:(NSString *)resultString
{
    _resultString = resultString;
    self.resultLabel.text = resultString;
}

-(void) addCardView:(UIView*)cardView
{
    [self.carViewList insertObject:cardView atIndex:0];
    [self updateUI];
}

-(void) removeAllCardViews
{
    [self.cardViewList removeAllObjects];
    [self updateUI];
}


-(void) updateUI
{
    for(UIView *view in self.cardViewCollection) {
        for(UIView *subView in [view subviews]) {
            [subView removeFromSuperview];
        }
        int index = [self.cardViewCollection indexOfObject:view];
        if(index < [self.carViewList count]) {
            UIView *cardView = [self.carViewList objectAtIndex:index];
            cardView.frame = view.bounds;
            cardView.backgroundColor = [UIColor clearColor];
            [view addSubview:cardView];
            [cardView setNeedsDisplay];
        }
    }
}

-(NSMutableArray*) carViewList
{
    if(!_cardViewList) {
        _cardViewList = [[NSMutableArray alloc]init];
    }
    return _cardViewList;
}

-(void)setup
{
    // do inialization here
}

-(void)awakeFromNib
{
    [self setup];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
