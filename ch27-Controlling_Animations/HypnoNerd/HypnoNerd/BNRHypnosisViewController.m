//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by disterics on 8/18/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController() <UITextFieldDelegate>

@end

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // set the tab item's title
        self.tabBarItem.title = @"Hypnotize";
        
        // create a UIImage from a file
        // will use Hypno@2x.png for retina display devices
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        
        // put the image on the tab bar item
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)loadView
{
    // CReate a view
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    CGRect textFieldRect = CGRectMake(40,70,240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    // set the border style tso that it is easier to see
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [backgroundView addSubview:textField];
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    // set it as *the* view of this view controller
    self.view = backgroundView;
}

- (void)viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"BNRHypnosisViewController loaded its view.");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; ++i)
    {
        UILabel *messageLabel = [[UILabel alloc] init];
        //configure the labels color and text
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        // resize the label relative to the text being displayed
        [messageLabel sizeToFit];
        // Get a random x value that fits within the hypnosis view's width
        int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
        int x = arc4random() % width;
        
        // Get a random y value that fits within the hypnosis views height
        int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
        int y = arc4random() % height;
        
        // Update the labels frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        // Add the label to the hierarchy
        [self.view addSubview:messageLabel];
        // Set the labels initial alpha
        messageLabel.alpha = 0.0;
        
        // Animate the alpha to 1.0
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
            messageLabel.alpha = 1.0;
        }
         completion:NULL];

        [self addMotionEffectTo:messageLabel];
    }
}

- (void)addMotionEffectTo:(UILabel *)label
{
    UIInterpolatingMotionEffect *motionEffect;
    motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionEffect.minimumRelativeValue = @-25;
    motionEffect.maximumRelativeValue = @25;
    [label addMotionEffect:motionEffect];

    motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionEffect.minimumRelativeValue = @-25;
    motionEffect.maximumRelativeValue = @25;
    [label addMotionEffect:motionEffect];
}

@end
