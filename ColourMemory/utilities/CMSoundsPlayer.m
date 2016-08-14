//
//  CMSoundsPlayer.m
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "CMSoundsPlayer.h"
#import "CMSetting.h"
@implementation CMSoundsPlayer
/*

NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"test"
                                                          ofType:@"m4a"];
NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];

AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                               error:nil];
player.numberOfLoops = -1; //Infinite

[player play];*/

static CMSoundsPlayer *sharedInstance;



+(CMSoundsPlayer*)getIntsance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CMSoundsPlayer alloc] init];
        
    });
    return sharedInstance;
}

-(id)init
{
    if(self=[super init])
    {
        
        
        NSString *soundFilePath = [NSString stringWithFormat:@"%@/card-show.wav", [[NSBundle mainBundle] resourcePath]];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        self.cardShowPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL
                                                                       error:nil];
        

        
    }
    
    return self;
}

-(void) playCardChangeSound
{
    if([CMSetting getIntsance].sounds)
    {
        [self.cardShowPlayer play];
    }
}

@end
