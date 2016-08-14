//
//  CMCard.m
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "CMCard.h"

@implementation CMCard

-(id)init:(NSInteger)cardID
{
    if(self=[super init])
    {
        self.matched=NO;
        self.cardID=cardID;
    }
    
    return self;
}

-(void) restart
{
    self.matched=NO;
}
@end
