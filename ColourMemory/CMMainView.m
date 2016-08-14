//
//  CMMainView.m
//  ColourMemory
//
//  Created by George Gameal on 22/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "CMMainView.h"
#import "CMCardImageView.h"
#import "CMConstants.h"
#import "AppDelegate.h"
@implementation CMMainView
-(void)layoutSubviews
{
    [self alignCardsView];
    
    
    
        }

-(void)awakeFromNib
{
   
 
    self.imgMinusWidth.constant=0;
    self.imgPlusWidth.constant=0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:CM_EVENT_CARD_MATCH
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:CM_EVENT_CARD_NOT_MATH
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:CM_EVENT_SHOW_CARD
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:CM_EVENT_GAME_FINISHED
                                               object:nil];

    [self initColourMemory];
    
    [self initCardViews];
    [self idleState];
    
    
    
}

-(void)showStartButton
{
    [self.gameView bringSubviewToFront:self.btnStart];
    [self.btnStart.layer setBorderColor: [[UIColor redColor] CGColor]];
    [self.btnStart.layer setBorderWidth: 3.0];
    self.btnStart.layer.cornerRadius = 5.0;
    
}
-(void) idleState
{
    self.btnStart.hidden=NO;
    [self updateScoreLabel:0];
    [self.colourMemory idleState];
    CMCardImageView* cmv=nil;
    NSMutableArray* row=nil;
    
    for (int j=0; j<4; j++) {
        row=[self.arrViews objectAtIndex:j];
        for (int i=0; i<4; i++) {
                        cmv=[row objectAtIndex:i];
            [cmv startIdleState];
            
        }
    }
    [self showStartButton];

}

-(void) stopidleState
{
    
    CMCardImageView* cmv=nil;
    NSMutableArray* row=nil;
    
    for (int j=0; j<4; j++) {
        row=[self.arrViews objectAtIndex:j];
        for (int i=0; i<4; i++) {
            cmv=[row objectAtIndex:i];
            [cmv stopIdleState];
            
        }
    }
    
}

-(void) attachCardsToViews
{
    
    CMCardImageView* cmv=nil;
    NSMutableArray* row=nil;
    
    for (int j=0; j<4; j++) {
        row=[self.arrViews objectAtIndex:j];
        for (int i=0; i<4; i++) {
            cmv=[row objectAtIndex:i];
            cmv.card=[self.colourMemory getCard:j withColumn:i];
            [cmv initializeCardImage];
            
        }
    }
    
}

-(void)startGame
{
    [self stopidleState];
    [self.colourMemory startGame];
    
    [self attachCardsToViews];
    self.btnStart.hidden=YES;
    
}
-(void)initCardViews
{
    self.arrViews=[[NSMutableArray alloc]init];
    
    self.lblScore.layer.cornerRadius=10;
    self.lblScore.clipsToBounds=YES;
  
    CMCardImageView* cmv=nil;
    NSMutableArray* row=nil;
    
    for (int j=0; j<4; j++) {
        row=[[NSMutableArray alloc]init];
        for (int i=0; i<4; i++) {
            cmv=[[CMCardImageView alloc]initWithFrame:CGRectMake(i*50,j*50, 50, 50) withCard:[self.colourMemory getCard:j withColumn:i]];
            [self.gameView addSubview:cmv];
            [row addObject:cmv];
            
           
        }
        
        [self.arrViews addObject:row];
        
    }

}

-(void)initColourMemory
{
    self.colourMemory=[[CMGame alloc]init];
}

-(void)alignCardsView
{
    CGSize gameViewSize=self.gameView.frame.size;
    CMCardImageView* cmv=nil;
    NSMutableArray* row=nil;
    CGRect frame;
    
    for (int j=0; j<4; j++) {
        row=[self.arrViews objectAtIndex:j];
        for (int i=0; i<4; i++) {
            frame=CGRectMake(i*gameViewSize.width/4,j*gameViewSize.height/4, gameViewSize.width/4, gameViewSize.height/4);
            cmv=[row objectAtIndex:i];
            cmv.frame=frame;
            
        }
    }

    
}

-(CMCardImageView*)getCardView:(NSInteger)cardNumb
{
    CMCardImageView* cmv=nil;
    NSMutableArray* row=nil;
   
    
    for (int j=0; j<4; j++) {
        row=[self.arrViews objectAtIndex:j];
        for (int i=0; i<4; i++) {
            cmv=[row objectAtIndex:i];
           if(cmv.card.numb==cardNumb)
               return cmv;
            
        }
    }
    
    return nil;
}
- (void) receiveNotification:(NSNotification *) notification
{
    
    
    if ([[notification name] isEqualToString:CM_EVENT_CARD_MATCH])
    {
        NSDictionary* userInfo = notification.userInfo;
       
        NSInteger score=[userInfo[@"score"] intValue];
       [self cardsMatch:[userInfo[@"cardNumb1"] intValue] withCard2Numb:[userInfo[@"cardNumb2"] intValue] withScore:score];
        
        
    }
    else   if ([[notification name] isEqualToString:CM_EVENT_CARD_NOT_MATH])
    {
        NSDictionary* userInfo = notification.userInfo;
        
        NSInteger score=[userInfo[@"score"] intValue];
        [self cardsNotMatch:[userInfo[@"cardNumb1"] intValue] withCard2Numb:[userInfo[@"cardNumb2"] intValue] withScore:score];

    }
    else   if ([[notification name] isEqualToString:CM_EVENT_SHOW_CARD])
    {
        NSDictionary* userInfo = notification.userInfo;
       
        [self showCard:[userInfo[@"cardNumb"] intValue]];
        
    }
    else   if ([[notification name] isEqualToString:CM_EVENT_GAME_FINISHED])
    {
        NSDictionary* userInfo = notification.userInfo;
        
        NSInteger score=[userInfo[@"score"] intValue];
        [self gameFinished:score];
        
    }
}

-(void)gameFinished:(NSInteger)score
{
    [self updateScoreLabel:score];
    NSString* title=[NSString stringWithFormat:@"your Score:%ld",(long)score];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"Enter your name."
                                preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        [textField addTarget:self
                      action:@selector(textFieldDidChange:)
            forControlEvents:UIControlEventEditingChanged];
       
    }];
    
    self.saveAction=[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textField = alert.textFields[0];
        
        // WE SHOULD NOTIFY USER IF ERROR HAPPENS HERE
        [self.colourMemory saveScore:textField.text];
         [self idleState];
    }];

    self.saveAction.enabled=false;
    [alert addAction:self.saveAction
     ];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self idleState];
    }] ];
    
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alert animated:YES completion:nil];
   
    
    
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSString *trimmedString = [theTextField.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    
   if([trimmedString length]>0)
       self.saveAction.enabled=YES;
    else  self.saveAction.enabled=NO;
}

-(void)updateScoreLabel:(NSInteger)score
{
    [self.lblScore setText:[NSString stringWithFormat:@"Score:%ld",(long)score]];
}

-(void)showCard:(int)cardNumb
{
    CMCardImageView* cmv=[self getCardView:cardNumb];
    [cmv showCard];
    
}
-(void)cardsMatch:(NSInteger)card1Numb withCard2Numb:(NSInteger)card2Numb withScore:(NSInteger)score
{
    [self updateScoreLabel:score];
    
    [self showplusScoreAnimation];
    
    [[self getCardView:card1Numb] match];
    [[self getCardView:card2Numb] match];
   
    }

-(void)cardsNotMatch:(NSInteger)card1Numb withCard2Numb:(NSInteger)card2Numb withScore:(NSInteger)score
{
    [self updateScoreLabel:score];
    
    [self showMinusScoreAnimation];
   
   
    [[self getCardView:card1Numb] dismatch];
   [[self getCardView:card2Numb] dismatch];
    
    
    

    }

-(void) showMinusScoreAnimation
{
    [self.gameView bringSubviewToFront:self.imgMinus];
    [UIView animateWithDuration:1.5f animations:^{
        self.imgMinusWidth.constant=150;
        [self.gameView layoutIfNeeded];
    } completion:^(BOOL finished){
        [self hideMinusScoreAnimation];
    }];
}

-(void) hideMinusScoreAnimation
{
    [UIView animateWithDuration:.5f animations:^{
        self.imgMinusWidth.constant=0;
        [self.gameView layoutIfNeeded];
    } ];
}

-(void) showplusScoreAnimation
{
    [self.gameView bringSubviewToFront:self.imgPlus];
    [UIView animateWithDuration:1.5f animations:^{
        self.imgPlusWidth.constant=150;
        [self.gameView layoutIfNeeded];
    } completion:^(BOOL finished){
        [self hideplusScoreAnimation];
    }];
}

-(void) hideplusScoreAnimation
{
    [UIView animateWithDuration:0.5f animations:^{
        self.imgPlusWidth.constant=0;
        [self.gameView layoutIfNeeded];
    } ];
}


- (IBAction)btnStartTouchUp:(id)sender {
    [self startGame];
}

@end
