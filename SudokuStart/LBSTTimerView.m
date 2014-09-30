//
//  LBSTTimerView.m
//  SudokuStart
//
//  Created by Sarah Trisorus on 9/27/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBSTTimerView.h"

@implementation LBSTTimerView {
  NSTimer *_gameClock;
  NSDate *_startDate;
}

@synthesize timerLabel = _timerLabel;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self) {
    // Set up the game clock
    NSMethodSignature *signature = [self methodSignatureForSelector:
                                      @selector(updateTimer)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                  signature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(updateTimer)];
    
    _gameClock = [NSTimer timerWithTimeInterval:1.0 invocation:invocation
                                        repeats:YES];
    
    // Set up the label to display
    CGRect timerLabelFrame = CGRectMake(0, 0, CGRectGetWidth(frame),
                                        CGRectGetHeight(frame));
    _timerLabel = [[UILabel alloc] initWithFrame:timerLabelFrame];
    [self addSubview:_timerLabel];
    
    // Default the timer label to show no time elapsed
    _timerLabel.text = @"00:00";
    
    // Style the label to display
    _timerLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:28];
    _timerLabel.textColor = [UIColor whiteColor];
    _timerLabel.textAlignment = NSTextAlignmentCenter;
  }
  
  return self;
}

- (void)startTimer
{
  // Make sure the timer starts at 0
  [self resetTimer];
  
  // Start the loop updating the timer label
  NSRunLoop *timerLoop = [NSRunLoop currentRunLoop];
  [timerLoop addTimer:_gameClock forMode:NSDefaultRunLoopMode];
}

- (void)updateTimer
{
  // Grab the current date and assign the timeInterval to the amount of time
  // that has elapsed since the timer was started
  NSDate *currentDate = [NSDate date];
  NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:_startDate];
  NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
  
  // Update the label with the new elapsed time
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"mm:ss"];
  NSString *timerString = [dateFormatter stringFromDate:timerDate];
  
  _timerLabel.text = timerString;
}

- (void)resetTimer
{
  _startDate = [NSDate date];
  _timerLabel.text = @"00:00";
}


@end
