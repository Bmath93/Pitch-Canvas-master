//
//  MAGMainViewController.m
//  Mobile Music Template
//
//  Created by MillTwo on 7/19/13.
//  Copyright (c) 2013 MAG. All rights reserved.
//

#import "MAGMainViewController.h"
#import "MAGCanvas.h"

@interface MAGMainViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *baseRange;

@property (weak, nonatomic) IBOutlet UISegmentedControl *keySwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl *shiftSwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sizeSwitch;

@property (weak, nonatomic) IBOutlet UISegmentedControl *multipleKeySwitch;

- (IBAction)loadCanvas;

@end

@implementation MAGMainViewController
@synthesize pdButler;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loadLastView:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)loadCanvas
{
    //[self performSegueWithIdentifier:@"loadCanvas" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loadCanvas"])
    {
        [segue.destinationViewController setBaseKey:([self.keySwitch selectedSegmentIndex] + 45 + (12 * [self.baseRange selectedSegmentIndex]))];
        [segue.destinationViewController setCircleSize:([self.sizeSwitch selectedSegmentIndex]*50.0 + 50.0)];
        [segue.destinationViewController setShift:([self.shiftSwitch selectedSegmentIndex])];
        [segue.destinationViewController setMultipleKeys:([self.multipleKeySwitch selectedSegmentIndex])];
        
        [segue.destinationViewController setPdButler:self.pdButler];
        [segue.destinationViewController setOscButler:self.oscButler];
        
        //[segue.destinationViewController setUserAddress:[self.IPAddressTextField text]];
        //[segue.destinationViewController setUserPort:[[self.portNumberTextField text] intValue]];
        
        if (!self.pdButler) {
            NSLog(@"pdButler not loaded");
        }
        if (!self.oscButler) {
            NSLog(@"oscButler not loaded");
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

- (void)viewDidUnload {
    [self setKeySwitch:nil];
    [self setShiftSwitch:nil];
    [self setSizeSwitch:nil];
    [super viewDidUnload];
}
@end
