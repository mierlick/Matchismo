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
#import "SetCardCollectionViewCell.h"

@interface SetViewController ()

@property (weak, nonatomic) IBOutlet UIButton *drawCardsButton;
@property (strong, nonatomic) SetCardDeck *deck;

@end

@implementation SetViewController

#define THREE_CARD_GAME 3
#define MISMATCH_PENALTY 2
#define MATCH_BONUS 4
#define STARTING_CARD_COUNT 12
#define NUMBER_OF_CARDS_TO_MATCH 3

- (SetCardDeck *)deck
{
    if (!_deck) {
       _deck = [[SetCardDeck alloc] init];
    }
    return _deck;
}

- (Deck *)createDeck
{
    return self.deck;
}

- (NSUInteger)startingCardCount
{
    return STARTING_CARD_COUNT;
}

- (NSUInteger) numberOfCardsToMatch
{
    return NUMBER_OF_CARDS_TO_MATCH;
}

- (NSUInteger) matchBonus
{
    return MATCH_BONUS;
}

- (NSUInteger) mismatchPenalty
{
    return MISMATCH_PENALTY;
}

- (BOOL)removeCards
{
    return YES;
}

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    if ([cell isKindOfClass:[SetCardCollectionViewCell class]]) {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        if ([card isKindOfClass:[SetCard class]]) {
            SetCard *setCard = (SetCard *)card;
            setCardView.rank = setCard.rank;
            setCardView.shape = setCard.shape;
            setCardView.shade = setCard.shade;
            setCardView.color = setCard.color;
            setCardView.faceUp = setCard.isFaceUp;
            setCardView.alpha = setCard.isUnplayable ? 0.3 : 1.0;
        }
    }
}

- (IBAction)deal
{
    self.drawCardsButton.enabled = YES;
    [self.drawCardsButton setTitle:@"Draw Cards" forState:UIControlStateNormal];
    self.deck = nil;
    [super deal];
}

- (IBAction)drawCards:(id)sender
{
    NSMutableArray *cards = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        Card *card = [self.deck drawRandomCard];
        if (card) {
            [cards addObject:card];
        }
    }
    
    if(self.deck.cardCount == 0){
        [self.drawCardsButton setTitle:@"Empty Deck" forState:UIControlStateDisabled];
        [self.drawCardsButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        self.drawCardsButton.enabled = NO;
    }
    
    [self addCards:cards];

}

-(void)addCardImageToView:(UIView *)view forCard:(Card *)card inRect:(CGRect)rect;
{
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard =(SetCard *)card;
        SetCardView *newSetCardView = [[SetCardView alloc]  initWithFrame:rect];
        newSetCardView.opaque = NO;
        newSetCardView.rank = setCard.rank;
        newSetCardView.shape = setCard.shape;
        newSetCardView.shade = setCard.shade;
        newSetCardView.color = setCard.color;
        
        
        [view addSubview:newSetCardView];
    }
}

- (UIView*) createCardViewUsingCard:(Card*) card
{
    SetCardView *setCardView;
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        setCardView = [[SetCardView alloc]init];
        setCardView.rank = setCard.rank;
        setCardView.shape = setCard.shape;
        setCardView.shade = setCard.shade;
        setCardView.color = setCard.color;
        setCardView.faceUp = YES;
    }
    return setCardView;
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
