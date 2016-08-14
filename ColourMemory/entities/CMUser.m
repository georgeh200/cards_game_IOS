//
//  CMUser.m
//  ColourMemory
//
//  Created by George Gameal on 26/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "CMUser.h"
#import "AppDelegate.h"
#import <limits.h>
@implementation CMUser
 static NSString* MODEL_NAME=@"CMUserModel";

-(id)initWithName :(NSString*)name withScore:(NSInteger)score
{
    if(self=[super init])
    {
        self.name=name;
        self.score=score;
    }
    
    return self;
}

-(BOOL)save
{
    
    
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    
    
    NSManagedObject* oldUserModel=[self getUserModelByName:self.name];
    NSError *error = nil;
    if(oldUserModel)
    {
        if([[oldUserModel valueForKey:@"score"] integerValue]>self.score)
            return false;
        else
        {
            [oldUserModel setValue: @(self.score) forKey:@"score"];
            if (![context save:&error]) {
                return false;
            }
            return true;
        }
    }

    
    
    
    
    NSManagedObject *userModel;
    userModel = [NSEntityDescription
                  insertNewObjectForEntityForName:MODEL_NAME
                  inManagedObjectContext:context];
    
    [userModel setValue: self.name forKey:@"name"];
    [userModel setValue: @(self.score) forKey:@"score"];
   
   
  
   
    
    if (![context save:&error]) {
        return false;
    }
    return true;
}
-(NSManagedObject*)getUserModelByName:(NSString*)name
{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:MODEL_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    if(results.count>0)
        return (NSManagedObject*)results[0];
    else return nil;
}


+(NSMutableArray*)listScores
{
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:MODEL_NAME];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO]];
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    
    NSMutableArray* arrUsers=[[NSMutableArray alloc]init];
    
    if(results!=nil)
        
    {
        NSManagedObject* object=nil;
        CMUser* user=nil;
        
        for(int j=0;j<results.count;j++)
        {
            object=(NSManagedObject*)results[j];
            user=[[CMUser alloc]init];
            user.score=[[object valueForKey:@"score"] integerValue];
            user.name=[object valueForKey:@"name"];
            [arrUsers addObject:user];
            user=nil;
            object=nil;
        }
    }
    [CMUser fixUsersRanks:arrUsers];
    return arrUsers;
}

+(void)fixUsersRanks:(NSMutableArray*)arrUsers // in decending order
{
    int rank=0;
    int max=INT_MAX;
    
    
    CMUser* user=nil;
    
    for(int j=0;j<arrUsers.count;j++)
    {
        user=(CMUser*)arrUsers[j];
        if(user.score<max)
        {
            rank++;
            max=user.score;
           
        }
         user.rank=rank;
    }
    
}

@end
