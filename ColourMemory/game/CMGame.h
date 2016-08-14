//
//  CMGame.h
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CMCard;

@interface CMGame : NSObject

@property(strong,nonatomic)CMCard* lastCardPressed;
@property(strong,nonatomic)NSMutableArray* arrCards;
@property(assign,nonatomic)NSInteger score;
@property(assign,nonatomic)int gameStatus;

-(BOOL)saveScore:(NSString*)name;
-(CMCard*)getCard:(int)row withColumn:(int) col;
-(CMCard*)getCard:(int)numb;
-(void)startGame;
-(void)idleState;


@end
