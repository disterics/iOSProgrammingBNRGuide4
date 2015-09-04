//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by disterics on 9/3/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawView.h"

#import "BNRLine.h"

@interface BNRDrawView ()

@property (nonatomic, strong) BNRLine *currentLine;
@property (nonatomic, strong) NSMutableArray *finishedLines;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    
    if (self)
    {
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)strokeLine:(BNRLine *)line
{
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

- (void)drawRect:(CGRect)rect
{
    // Draw the finished lines in black
    [[UIColor blackColor] set];
    for (BNRLine *line in self.finishedLines)
    {
        [self strokeLine:line];
    }
    
    if (self.currentLine)
    {
        // draw the current line in red
        [[UIColor redColor] set];
        [self strokeLine:self.currentLine];
    }
}

@end
