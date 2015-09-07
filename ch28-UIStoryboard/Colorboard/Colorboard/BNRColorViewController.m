//
//  BNRColorViewController.m
//  Colorboard
//
//  Created by disterics on 9/7/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRColorViewController.h"

@interface BNRColorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@end

@implementation BNRColorViewController

- (IBAction)dismiss:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)changeColor:(id)sender
{
    float red = self.redSlider.value;
    float green = self.greenSlider.value;
    float blue = self.blueSlider.value;
    UIColor *newColor = [UIColor colorWithRed:red
                                        green:green
                                         blue:blue
                                        alpha:1.0];
    self.view.backgroundColor = newColor;
}

@end
