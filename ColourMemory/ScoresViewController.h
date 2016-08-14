//
//  ScoresViewController.h
//  ColourMemory
//
//  Created by George Gameal on 24/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoresViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)NSMutableArray* arrUsers;
- (IBAction)btnBackTouch:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tblScores;

@end
