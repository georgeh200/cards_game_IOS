//
//  CMTableCell.m
//  ColourMemory
//
//  Created by George Kastour on 25/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "CMTableCell.h"

@implementation CMTableCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)startWithUser:(CMUser*)user
{
    self.lblName.text=user.name;
    self.lblScore.text=[NSString stringWithFormat:@"%d",user.score ];
    self.lblRank.text=[NSString stringWithFormat:@"%d",user.rank ];
     
}

@end
