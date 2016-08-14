//
//  CMSetting.h
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const KEY_SOUNDS=@"sounds";

@interface CMSetting : NSObject

+(CMSetting*)getIntsance;
@property(assign) BOOL sounds;
@end
