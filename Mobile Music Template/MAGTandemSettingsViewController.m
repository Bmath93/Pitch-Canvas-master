//
//  MAGTandemSettingsViewController.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/11/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGTandemSettingsViewController.h"
#import "MAGAnotherCanvas.h"

@interface MAGTandemSettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userAddressTextField;

@property (weak, nonatomic) IBOutlet UITextField *userPortTextField;

@end

@implementation MAGTandemSettingsViewController
- (IBAction)loadTandemCanvas:(id)sender {
    //[self performSegueWithIdentifier:@"loadTandemCanvas" sender:self];
}

- (IBAction)loadLastView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loadTandemCanvas"])
    {
        [segue.destinationViewController setUserAddress:[self.userAddressTextField text]];
        [segue.destinationViewController setUserPort:[[self.userPortTextField text] intValue]];
    }
}

@end
