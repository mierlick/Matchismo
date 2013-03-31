//
//  SetCardView.h
//  Matchismo
//
//  Created by Matthew I Erlick on 3/29/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCardView.h"

@interface SetCardView : UIView

@property (strong, nonatomic)NSString *color;
@property (strong, nonatomic)NSString *shape;
@property (strong, nonatomic)NSString *shade;
@property (nonatomic)NSUInteger rank;
@property (nonatomic) BOOL faceUp;

@end
