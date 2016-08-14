//
//  CMSoundsPlayer.h
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface CMSoundsPlayer : NSObject
@property(assign) BOOL soundsON;
+(CMSoundsPlayer*)getIntsance;
@property(strong,nonatomic) AVAudioPlayer *cardShowPlayer;
-(void) playCardChangeSound;
@end
