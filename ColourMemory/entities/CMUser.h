//
//  CMUser.h
//  ColourMemory
//
//  Created by George Gameal on 26/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface CMUser : NSObject
-(id)initWithName :(NSString*)name withScore:(NSInteger)score;
@property(copy,nonatomic)NSString* name;
@property(assign,nonatomic)NSInteger score;
@property(assign,nonatomic)NSInteger rank;

-(BOOL)save;
+(NSMutableArray*)listScores;
@end
