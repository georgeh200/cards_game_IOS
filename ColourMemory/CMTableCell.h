//
//  CMTableCell.h
//  ColourMemory
//
//  Created by George Kastour on 25/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CMUser.h"
@interface CMTableCell : UITableViewCell

//@property(strong,nonatomic)CMUserModel* user;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblScore;
@property (weak, nonatomic) IBOutlet UILabel *lblRank;

-(void)startWithUser:(CMUser*)user;

@end
