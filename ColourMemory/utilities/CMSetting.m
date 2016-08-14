//
//  CMSetting.m
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "CMSetting.h"

@implementation CMSetting


static CMSetting *sharedInstance;


+(CMSetting*)getIntsance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CMSetting alloc] init];
        
    });
    return sharedInstance;
}
-(id)init
{
    if(self=[super init])
    {

        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if([userDefaults objectForKey:KEY_SOUNDS]==nil)
        {
            self.sounds=YES;
            [userDefaults setBool:self.sounds
                   forKey:KEY_SOUNDS];
        }
        else
            self.sounds=[userDefaults boolForKey:KEY_SOUNDS];
    }
    
    return self;
}

-(void) save
{
    
    [[NSUserDefaults standardUserDefaults]  setBool:self.sounds
                                             forKey:KEY_SOUNDS];
}

@end
