//
//  CMCard.h
//  ColourMemory
//
//  Created by George Gameal on 23/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMCard : NSObject
@property(assign,nonatomic) BOOL matched;
@property(assign,nonatomic)NSInteger cardID;
@property(assign,nonatomic)NSInteger numb;

-(id)init:(NSInteger)cardID;
-(void) restart;
@end
