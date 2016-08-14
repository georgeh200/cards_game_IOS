//
//  CMGame.m
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "CMGame.h"
#import "CMCard.h"
#import "CMConstants.h"
#import "CMUser.h"
@implementation CMGame


-(id)init
{
    if(self=[super init])
    {
       
      
        self.gameStatus=GAME_STATUS_BEFORE_START;
        [self initCards];
        [self randomCards];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:)
                                                     name:CM_EVENT_CARD_PRESS
                                                   object:nil];
    }
    
    return self;
}

-(BOOL)saveScore:(NSString*)name
{
    
    CMUser* user=[[CMUser alloc]initWithName:name withScore:self.score];
    
    return [user save];
   
}

-(void)initCards
{
    self.arrCards=[[NSMutableArray alloc]init];
    CMCard* card=nil;
    NSMutableArray* row=nil;
    int count=0;
    for(int j=0;j<4;j++)
    {
        row=[[NSMutableArray alloc]init];
        for(int i=0;i<4;i++)
        {
            card=[[CMCard alloc]init:(count%8)];
            card.numb=count;
            [row addObject:card];
            count++;
        }
        [self.arrCards addObject:row];
        
    }
}

-(void) randomCards
{
    
    
    
    for(int j=0;j<4;j++)
    {
        [self.arrCards exchangeObjectAtIndex:[self getRandomNumberBetween:0 to:3] withObjectAtIndex:[self getRandomNumberBetween:0 to:3]];
    }
    
    NSMutableArray* row=nil;
       for(int j=0;j<4;j++)
    {
        row=[self.arrCards objectAtIndex:j];
        for(int i=0;i<4;i++)
        {
           [row exchangeObjectAtIndex:[self getRandomNumberBetween:0 to:3] withObjectAtIndex:[self getRandomNumberBetween:0 to:3]];
        }
        
    }
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

-(void)startGame
{
    self.score=0;
    [self randomCards];
    [self resetCards];
    self.gameStatus=GAME_STATUS_RUNNING;
    
}
-(void)idleState
{
    self.gameStatus=GAME_STATUS_BEFORE_START;
}
-(void)resetCards
{
    CMCard* card=nil;
    NSMutableArray* row=nil;
    for(int j=0;j<4;j++)
    {
        row=[self.arrCards objectAtIndex:j];
        for(int i=0;i<4;i++)
        {
            card=[row objectAtIndex:i];
            card.matched=NO;
        }
        
    }

}
-(CMCard*)getCard:(int)row withColumn:(int) col
{
    NSMutableArray* arrRow=[self.arrCards objectAtIndex:row];
    return [arrRow objectAtIndex:(col)];
}


-(CMCard*)getCard:(int)numb
{
    CMCard* card=nil;
    NSMutableArray* row=nil;
    for(int j=0;j<4;j++)
    {
        row=[self.arrCards objectAtIndex:j];
        for(int i=0;i<4;i++)
        {
            card=[row objectAtIndex:i];
            if(card.numb==numb)
            {
                return card;
            }
        }
        
    }
    return nil;
}

- (void) receiveNotification:(NSNotification *) notification
{
  
    
    if ([[notification name] isEqualToString:CM_EVENT_CARD_PRESS])
    {
        NSDictionary* userInfo = notification.userInfo;
        NSNumber* cardNumb = (NSNumber*)userInfo[@"cardNumb"];
        [self cardPresses:[self getCard:cardNumb.intValue]];
    }
}

-(void)cardPresses:(CMCard*)card
{
    
    if(self.gameStatus!=GAME_STATUS_RUNNING)
    {
        return;

    }
    
    
    NSDictionary* userInfo = @{@"cardNumb": @(card.numb)};
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:CM_EVENT_SHOW_CARD
     object:self userInfo:userInfo];
    
    
    if(self.lastCardPressed==nil)
    {
        self.lastCardPressed=card;
    }
    else{
        if(self.lastCardPressed.numb==card.numb)
        {
            return;
        }
        if(self.lastCardPressed.cardID==card.cardID)
        {
            [self cardsMatch:self.lastCardPressed withCard2:card];
        }
        else
        {
            [self cardsNotMatch:self.lastCardPressed withCard2:card];
        }
        self.lastCardPressed=nil;
        
        
    }
    
    
    
}

-(void)cardsMatch:(CMCard*)card1 withCard2:(CMCard*)card2
{
    self.score+=2;
    card1.matched=YES;
    card2.matched=YES;
    NSDictionary* userInfo = @{@"cardNumb1": @(card1.numb),@"cardNumb2": @(card2.numb),@"score": @(self.score)};
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:CM_EVENT_CARD_MATCH
     object:self userInfo:userInfo];
    [self betweenRoundWait];
    
}

-(void)cardsNotMatch:(CMCard*)card1 withCard2:(CMCard*)card2
{
    self.score-=1;
    card1.matched=NO;
    card2.matched=NO;
    NSDictionary* userInfo = @{@"cardNumb1": @(card1.numb),@"cardNumb2": @(card2.numb),@"score": @(self.score)};
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:CM_EVENT_CARD_NOT_MATH
     object:self userInfo:userInfo];
    [self betweenRoundWait];
}

-(void)betweenRoundWait
{
    self.gameStatus=GAME_STATUS_BETWEEN_ROUNDS;
    NSTimer *timer;
    
    timer = [NSTimer scheduledTimerWithTimeInterval: 2
                                             target: self
                                           selector: @selector(handleTimerAfterRound:)
                                           userInfo: nil
                                            repeats: NO];
}

-(void)handleTimerAfterRound:(NSTimer*)timer
{
    if(![self isGameFinished])
    self.gameStatus=GAME_STATUS_RUNNING;
    else{
        
        self.gameStatus=GAME_STATUS_FINISHED;
        NSDictionary* userInfo = @{@"score": @(self.score)};
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:CM_EVENT_GAME_FINISHED
         object:self userInfo:userInfo];
    }
    
    
}
-(BOOL)isGameFinished
{
    CMCard* card=nil;
    NSMutableArray* row=nil;
    for(int j=0;j<4;j++)
    {
        row=[self.arrCards objectAtIndex:j];
        for(int i=0;i<4;i++)
        {
            card=[row objectAtIndex:i];
            if(!card.matched)
                return  NO;
        }
        
    }
    
    return YES;
}




@end
