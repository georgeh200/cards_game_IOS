//
//  CMCardImageView.m
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "CMCardImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "CMConstants.h"
#import "CMSoundsPlayer.h"
@implementation CMCardImageView

-(id)initWithFrame:(CGRect)frame withCard:(CMCard*)card
{
    
    self=[super initWithFrame:frame];
    if(self)
    {
        self.card=card;
        self.imgBack=[UIImage imageNamed:@"card_bg.png"];
        [self setImage:self.imgBack];
        [self registerTouch];
        [self initializeCardImage];
        
        
    }
    return self;
}
- (void) initializeCardImage
{
   
    switch(self.card.cardID)
    {
        case 0:
            self.imgCard=[UIImage imageNamed:@"colour1.png"];
            
            break;
        case 1:
            self.imgCard=[UIImage imageNamed:@"colour2.png"];
            break;
        case 2:
            self.imgCard=[UIImage imageNamed:@"colour3.png"];
            break;
        case 3:
            self.imgCard=[UIImage imageNamed:@"colour4.png"];
            break;
        case 4:
            self.imgCard=[UIImage imageNamed:@"colour5.png"];
            break;
        case 5:
            self.imgCard=[UIImage imageNamed:@"colour6.png"];
            break;
        case 6:
            self.imgCard=[UIImage imageNamed:@"colour7.png"];
            break;
        case 7:
            self.imgCard=[UIImage imageNamed:@"colour8.png"];
            break;
    }
}

- (void) registerTouch
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerTapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:singleTap];
    [self setUserInteractionEnabled:YES];
}

- (void)bannerTapped:(UIGestureRecognizer *)gestureRecognizer {
    
    if(self.shown)
        return;
    
   
    
    NSDictionary* userInfo = @{@"cardNumb": @(self.card.numb)};

    [[NSNotificationCenter defaultCenter]
     postNotificationName:CM_EVENT_CARD_PRESS
     object:self userInfo:userInfo];
    
   
}

- (void) showCard
{
     self.shown=YES;
    [[CMSoundsPlayer getIntsance]playCardChangeSound];
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"contents"];
    
    fadeAnim.fromValue = self.imgBack;
    fadeAnim.toValue   = self.imgCard;
    fadeAnim.duration  = 0.5;         //smoothest value
    
    [self.layer addAnimation:fadeAnim forKey:@"contents"];
    
    
    [self setImage:self.imgCard];
}

-(void)hideCard
{
    
    self.shown=NO;
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"contents"];
    
    fadeAnim.fromValue = self.imgCard;
    fadeAnim.toValue   = self.imgBack;
    fadeAnim.duration  = 0.5;
    [self.layer addAnimation:fadeAnim forKey:@"contents"];
    
    
    [self setImage:self.imgBack];
}

-(void)removeBorders
{
    [self.layer setBorderWidth: 0.0];
     self.layer.cornerRadius = 0.0;
}

-(void)match
{
    
    [self.layer setBorderColor: [[UIColor yellowColor] CGColor]];
    [self.layer setBorderWidth: 3.0];
    self.layer.cornerRadius = 9.0;
    
    
    [self performSelector:@selector(removeBorders) withObject:nil  afterDelay:2];
}

-(void)dismatch
{
    [self.layer setBorderColor: [[UIColor redColor] CGColor]];
    [self.layer setBorderWidth: 3.0];
    self.layer.cornerRadius = 9.0;
    
    
    [self performSelector:@selector(hideCard) withObject:nil  afterDelay:2];
    [self performSelector:@selector(removeBorders) withObject:nil  afterDelay:2];
   
    
}

-(void)idleAnimation
{
    if(!self.idle)
        return;
    int rnd=[self getRandomNumberBetween:0 to:3];
    if(rnd==0)
        [self showCard];
    else if(rnd==2) [self hideCard];
    [self performSelector:@selector(idleAnimation) withObject:nil  afterDelay:[self getRandomNumberBetween:2 to:4]];
    
}
-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}
-(void)startIdleState
{
    self.idle=YES;
    [self idleAnimation];
}
-(void)stopIdleState
{
    self.idle=NO;
    [self hideCard];
}

@end
