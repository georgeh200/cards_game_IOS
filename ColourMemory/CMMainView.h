//
//  CMMainView.h
//  ColourMemory
//
//  Created by George Gameal on 22/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CMGame.h"

@interface CMMainView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
- (IBAction)btnStartTouchUp:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnHighScore;
@property(strong,nonatomic)UIAlertAction* saveAction;

@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UIView *vGame;
@property(strong,nonatomic)  NSMutableArray* arrViews;
@property (weak, nonatomic) IBOutlet UIView *gameView;

@property(strong,nonatomic) CMGame* colourMemory;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgPlusWidth;
@property (weak, nonatomic) IBOutlet UIImageView *imgPlus;
@property (weak, nonatomic) IBOutlet UIImageView *imgMinus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgMinusWidth;

@end
