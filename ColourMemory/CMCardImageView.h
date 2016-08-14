//
//  CMCardImageView.h
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMCard.h"
@interface CMCardImageView : UIImageView
-(id)initWithFrame:(CGRect)frame withCard:(CMCard*)card;

@property(strong,nonatomic) UIImage* imgCard;
@property(strong,nonatomic) UIImage* imgBack;
@property(strong,nonatomic)CMCard* card;
@property(assign,nonatomic)BOOL shown;
@property(assign,nonatomic)BOOL idle;

- (void) initializeCardImage;

-(void)startIdleState;
-(void)stopIdleState;

-(void)hideCard;
- (void) showCard;
-(void)match;

-(void)dismatch;
@end
