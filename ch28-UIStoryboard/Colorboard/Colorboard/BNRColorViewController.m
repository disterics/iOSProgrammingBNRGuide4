//
//  BNRColorViewController.m
//  Colorboard
//
//  Created by disterics on 9/7/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRColorViewController.h"

#import "BNRColorDescription.h"

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Remove the done button if this is an existing color
    if (self.existingColor)
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *color = self.colorDescription.color;
    CGFloat red, green, blue;
    [color getRed:&red
            green:&green
             blue:&blue
            alpha:nil];
    //set the initial slider values
    self.redSlider.value = red;
    self.greenSlider.value = green;
    self.blueSlider.value = blue;
    
    // set the background color and the text field value
    self.view.backgroundColor = color;
    self.textField.text = self.colorDescription.name;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.colorDescription.name = self.textField.text;
    self.colorDescription.color = self.view.backgroundColor;
}
@end
