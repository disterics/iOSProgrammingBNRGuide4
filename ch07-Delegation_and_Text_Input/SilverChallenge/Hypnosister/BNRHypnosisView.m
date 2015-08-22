//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by disterics on 8/7/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisView.h"
@interface BNRHypnosisView()

@property (strong, nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // always start with a clear background
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
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
    [self.circleColor setStroke];
    // draw the circle
    [path stroke];
    CGRect challengeRect = [self getCenteredHalfRectOf:rect];
    [self drawTriangleWithGradientWithin:challengeRect];
    [self drawLogoWithin:[self getCenteredHalfRectOf:rect] withShadow:YES];
}

// when a finger touches the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    // Get 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

#pragma mark - Bronze challenge
-(void) drawLogoWithin:(CGRect) rect
{
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    [logoImage drawInRect:rect];
}

#pragma mark - Gold challenge - shadows and gradients
-(void) drawTriangleWithGradientWithin:(CGRect) rect
{
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 1.0, 0.0, 1.0, // start color is yellow
                              0.0, 1.0, 0.0, 1.0 }; // end color is green
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    UIBezierPath *path = [self createTrianglePathWithin: rect];
    [path addClip];
    CGPoint startPoint = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    CGPoint endPoint = rect.origin;
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGContextRestoreGState(currentContext);
}

-(void) drawLogoWithin:(CGRect)rect withShadow:(BOOL)drawShadow
{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    if (drawShadow) CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    [self drawLogoWithin:rect];
    CGContextRestoreGState(currentContext);
}

-(CGRect) getCenteredHalfRectOf:(CGRect)rect
{
    float x = rect.origin.x + (rect.size.width / 4.0);
    float y = rect.origin.y + (rect.size.height / 4.0);
    float w = rect.size.width / 2.0;
    float h = rect.size.height / 2.0;
    return CGRectMake(x, y, w, h);
}

-(UIBezierPath *) createTrianglePathWithin:(CGRect) rect
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint apex = CGPointMake(rect.origin.x + rect.size.width / 2.0, rect.origin.y);
    float bottomY = rect.origin.y + rect.size.height;
    float rightX= rect.origin.x + rect.size.width;
    [path moveToPoint:apex];
    [path addLineToPoint:CGPointMake(rect.origin.x, bottomY)];
    [path addLineToPoint:CGPointMake(rightX, bottomY)];
    [path addLineToPoint:apex];
    return path;
}
@end
