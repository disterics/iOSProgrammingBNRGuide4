//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by disterics on 8/7/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // always start with a clear background
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    //Center of the screen
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20)
    {
        // make sure circle starts somewhere n the circle
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        // add an arc at the center with radius from 0 to 2PI radians (a circle)
        [path addArcWithCenter:center radius:currentRadius startAngle:0 endAngle:M_PI * 2.0 clockwise:YES];
    }
    // configure the line width
    path.lineWidth = 10;
    // configure the stroke color to light grey
    [[UIColor lightGrayColor] setStroke];
    // draw the circle
    [path stroke];
    
#pragma mark - Bronze challenge
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    [logoImage drawInRect:rect];
}


@end
