//
//  ViewController.m
//  ColourMemory
//
//  Created by George Gameal on 22/04/16.
//  Copyright © 2016 George Gameal. All rights reserved.
//

#import "ViewController.h"
#import "ScoresViewController.h"
@interface ViewController ()

@end

@implementation ViewController


-(void)viewDidAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

/*-(BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait ;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return (UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        return YES;
    }
    return NO;
}*/



- (IBAction)btnHighScoreTouch:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ScoresViewController *myViewController = [storyboard instantiateViewControllerWithIdentifier:@"ScoresViewController"];
    [self presentViewController:myViewController animated:YES completion:nil];

}


@end
