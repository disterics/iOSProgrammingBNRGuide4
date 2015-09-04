//
//  BNRDrawView.m
//  TouchTracker
//
//  Created by disterics on 9/3/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRDrawView.h"

#import "BNRLine.h"

@interface BNRDrawView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *moveRecognizer;
@property (nonatomic, strong) NSMutableDictionary *linesInProgress;
@property (nonatomic, strong) NSMutableArray *finishedLines;
@property (nonatomic, weak) BNRLine *selectedLine;
@property (nonatomic) BOOL longPressInProgress;

@end

@implementation BNRDrawView

- (instancetype)initWithFrame:(CGRect)r
{
    self = [super initWithFrame:r];
    
    if (self)
    {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
        self.longPressInProgress = NO;
        
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = YES;
        [self addGestureRecognizer:doubleTapRecognizer];

        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapRecognizer.delaysTouchesBegan = YES;
        [tapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];
        [self addGestureRecognizer:tapRecognizer];
        
        UILongPressGestureRecognizer *pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:pressRecognizer];

        self.moveRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveLine:)];
        self.moveRecognizer.delegate = self;
        self.moveRecognizer.cancelsTouchesInView = NO; // we do this so that line drawing code will work
        // if we left it as the default, we would never get any of the touchesEvent since those events are
        // the same set used by the PanGestureRecognizer
        [self addGestureRecognizer:self.moveRecognizer];
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

    // draw the lines in progress in red
    [[UIColor redColor] set];
    for (NSValue *key in self.linesInProgress)
    {
        [self strokeLine:self.linesInProgress[key]];
    }
//    for (BNRLine *line in self.linesInProgress.allValues)
//    {
//        [self strokeLine:line];
//    }
    
    if (self.selectedLine)
    {
        [[UIColor greenColor] set];
        [self strokeLine:self.selectedLine];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - Touch Event Handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // log to see order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches)
    {
        //get the location in the view's co-ordinate system
        CGPoint location = [t locationInView:self];
        BNRLine *line = [[BNRLine alloc] init];
        line.begin = location;
        line.end = location;
        NSValue *key = [NSValue valueWithNonretainedObject:t]; // essentially the address of the touch event
        self.linesInProgress[key] = line;
    }
    if (self.selectedLine)
    {
        self.selectedLine = nil;
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // log to see order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));

    for (UITouch *t in touches)
    {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];

        CGPoint location = [t locationInView:self];
        line.end = location;
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // log to see order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    for (UITouch *t in touches)
    {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        BNRLine *line = self.linesInProgress[key];

        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // log to see order of events
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // Why cant we do - [self.linesInProgress removeAllObjects]???
    for (UITouch *t in touches)
    {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

#pragma mark - Gesture Recognizer Actions
- (void)doubleTap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognzied double tap");
    [self.linesInProgress removeAllObjects];
    [self.finishedLines removeAllObjects];
    [self setNeedsDisplay];
}

- (void)tap:(UIGestureRecognizer *)gr
{
    NSLog(@"Recognzied tap");
    CGPoint pt = [gr locationInView:self];
    self.selectedLine = [self lineAtPoint:pt];
    
    if (self.selectedLine)
    {
        // Make ourselves the target of menu item action messages
        [self becomeFirstResponder];
        
        // Grab the menu controller
        UIMenuController *menu = [UIMenuController sharedMenuController];
        // Create a new "Delete" UIMenuItem
        UIMenuItem *deleteItem = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(deleteLine:)];
        menu.menuItems = @[deleteItem];
        
        // tell the menu where it show come show it
        [menu setTargetRect:CGRectMake(pt.x, pt.y, 2, 2) inView:self];
        [menu setMenuVisible:YES animated:YES];
    }
    else
    {
        // hide the menu if no line is selected
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
    }
    
    [self setNeedsDisplay];

}

- (void)longPress:(UIGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"Recognzied long press start");
        CGPoint pt = [gr locationInView:self];
        self.selectedLine = [self lineAtPoint:pt];
        self.longPressInProgress = YES;
        
        if (self.selectedLine)
        {
            [self.linesInProgress removeAllObjects];
        }
    }
    else if (gr.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Recognzied long press end");
        self.selectedLine = nil;
        self.longPressInProgress = NO;
    }
    [self setNeedsDisplay];
}

- (void)moveLine:(UIPanGestureRecognizer *)gr
{
    // if we have not selected a line, nothing to do
    if (!self.selectedLine || !self.longPressInProgress)
    {
        return;
    }
    // the pan gesture recognizer changes its position
    if (gr.state == UIGestureRecognizerStateChanged)
    {
        // how far has the pan moved
        CGPoint translation = [gr translationInView:self];
        
        // add the translation to the current begin and end points of the line
        CGPoint begin = self.selectedLine.begin;
        CGPoint end = self.selectedLine.end;
        begin.x += translation.x;
        begin.y += translation.y;
        end.x += translation.x;
        end.y += translation.y;
        
        // set the new begin and end points
        self.selectedLine.begin = begin;
        self.selectedLine.end = end;

        [self setNeedsDisplay];
        
        // reset the translation start point so that next call returns only the delat
        [gr setTranslation:CGPointZero inView:self];
    }
}
#pragma mark - Actions

- (void)deleteLine:(id)sender
{
    // remove the selected line
    [self.finishedLines removeObject:self.selectedLine];
    
    [self setNeedsDisplay];
}

#pragma mark - GestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer == self.moveRecognizer)
    {
        return YES;
    }
    return NO;
}

#pragma mark - Helper methods

- (BNRLine *)lineAtPoint:(CGPoint)p
{
    // Find a line lose to p
    for (BNRLine *l in self.finishedLines)
    {
        CGPoint start = l.begin;
        CGPoint end = l.end;
        
        // check a few points on the line
        for (float t = 0.0; t <= 1.0; t += 0.05)
        {
            float x = start.x + t * (end.x -start.x);
            float y = start.y + t * (end.y - start.y);
            // if the tapped point is within 20 points, let's return this line
            if (hypot(x-p.x, y-p.y) < 20.0)
            {
                return l;
            }
        }
    }
    
    // if nothing is close enough, we did not select a line
    return nil;
}
@end
