//
//  LastMove.h
//  Matchismo
//
//  Created by Matthew I Erlick on 3/6/13.
//  Copyright (c) 2013 Matthew I Erlick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LastMove : NSObject

@property (strong, nonatomic)NSString *lastMove;
@property (strong, nonatomic)NSArray *cards;
@property (nonatomic)NSUInteger points;

@end
