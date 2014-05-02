//
//  MAGTopViewController.m
//  PitchCanvas
//
//  Created by Research Assistant [PureData] on 4/18/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#import "MAGTopViewController.h"

@interface MAGTopViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userAddressTextField;

@property (weak, nonatomic) IBOutlet UITextField *userPortTextField;

@end

@implementation MAGTopViewController

@synthesize pdButler;

- (void)viewDidLoad{
    [super viewDidLoad];
	
    self.pdButler = [[MAGPdButler alloc] init];
}
- (IBAction)loadTandemCanvasPlease:(id)sender {
    [self performSegueWithIdentifier:@"loadTandemCanvas" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loadCanvasSettings"])
    {
        [segue.destinationViewController setPdButler:self.pdButler];
        [segue.destinationViewController setOscButler:self.oscButler];
        if (self.oscButler){[segue.destinationViewController setOscButler:self.oscButler];}
    }
    
    if ([segue.identifier isEqualToString:@"loadTandemCanvas"])
    {
        NSLog(@"loading Tandem Canvas");
        [segue.destinationViewController setUserAddress:[self.userAddressTextField text]];
        [segue.destinationViewController setUserPort:[[self.userPortTextField text] intValue]];
        if (self.oscButler){[segue.destinationViewController setOscButler:self.oscButler];}
    }
}
- (IBAction)createOscButler:(id)sender {
    self.oscButler = [[MAGOSCButler alloc] initToAddress: [self.userAddressTextField text] onPort: [[self.userPortTextField text] intValue] ];
    [self.oscButler setSendPortNumber:[[self.userPortTextField text] intValue]];
}

@end
