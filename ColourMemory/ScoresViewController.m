//
//  ScoresViewController.m
//  ColourMemory
//
//  Created by George Gameal on 24/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "ScoresViewController.h"
#import "CMUser.h"
#import "CMTableCell.h"
@interface ScoresViewController ()

@end

@implementation ScoresViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrUsers=[CMUser listScores];
    
    
   
    self.tblScores.dataSource=self;
    self.tblScores.delegate=self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)btnBackTouch:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CMTableCell";
    
    CMTableCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = (CMTableCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    CMUser* user=(CMUser*)[self.arrUsers objectAtIndex:indexPath.row];
    [cell startWithUser:user];
    
    return cell;
}









@end
