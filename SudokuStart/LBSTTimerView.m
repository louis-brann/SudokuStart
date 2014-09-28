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
    NSMethodSignature *signature = [self methodSignatureForSelector:@selector(updateTimer)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:self];
    [invocation setSelector:@selector(updateTimer)];
    
    _gameClock = [NSTimer timerWithTimeInterval:1.0 invocation:invocation repeats:YES];
    
    // Set up the label to display
    CGRect timerLabelFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    _timerLabel = [[UILabel alloc] initWithFrame:timerLabelFrame];
    [self addSubview:_timerLabel];
    
    _timerLabel.text = @"00:00";
    _timerLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:28];
    _timerLabel.textColor = [UIColor whiteColor];
    _timerLabel.textAlignment = NSTextAlignmentCenter;
  }
  
  return self;
}

- (void) startTimer
{
  [self resetTimer];
  
  NSRunLoop *timerLoop = [NSRunLoop currentRunLoop];
  [timerLoop addTimer:_gameClock forMode:NSDefaultRunLoopMode];
}

- (void) updateTimer
{
  NSDate *currentDate = [NSDate date];
  NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:_startDate];
  NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"mm:ss"];
  NSString *timerString = [dateFormatter stringFromDate:timerDate];
  
  _timerLabel.text = timerString;
}

- (void) resetTimer
{
  _startDate = [NSDate date];
  _timerLabel.text = @"00:00";
}


@end
