//
//  LBSTNumPadView.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/18/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBSTNumPadView.h"
#import "UIImage+LBSTColorImage.h"

@implementation LBSTNumPadView
{
  NSMutableArray *_numbers;
}

static CGFloat const IPAD_FONT_SIZE = 30;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialize the array
    _numbers = [[NSMutableArray alloc] initWithCapacity:9];
    
    // Set up button size and offset
    CGFloat buttonSize = frame.size.width / 10.0;
    CGFloat baseOffset = buttonSize / 10.0;
    CGFloat xOffset = baseOffset;
    
    UIButton *button;
    
    // Initialize number buttons
    for (int i = 0; i < 9; ++i) {
      CGRect buttonFrame = CGRectMake(xOffset, baseOffset, buttonSize, buttonSize);
      
      button = [[UIButton alloc] initWithFrame:buttonFrame];
      
      // Set button properties
      int buttonNum = i + 1;
      button.tag = buttonNum;
      
      // Make button 1 the default selected button
      UIColor *NUMPAD_NORMAL_COLOR = [UIColor greenColor];
      UIColor *NUMPAD_SELECT_COLOR = [UIColor orangeColor];
      if (buttonNum == 1) {
        [self setCurrentNum:buttonNum];
        button.backgroundColor = NUMPAD_SELECT_COLOR;
      }
      else {
        button.backgroundColor = NUMPAD_NORMAL_COLOR;
      }
      
      // Set up title
      [button setTitle:[NSString stringWithFormat:@"%d", buttonNum] forState:UIControlStateNormal];
      [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:IPAD_FONT_SIZE];
      button.titleLabel.adjustsFontSizeToFitWidth = YES;
      
      [self addSubview:button];
      
      // Create target for button
      [button addTarget:self action:@selector(numSelected:) forControlEvents:UIControlEventTouchDown];
      
      // Add the button to the array
      [_numbers insertObject:button atIndex:i];
      
      xOffset += buttonSize + baseOffset;
    }
  }
  
  return self;
}

- (void)numSelected:(id)sender
{
    UIColor *NUMPAD_NORMAL_COLOR = [UIColor greenColor];
    UIColor *NUMPAD_SELECT_COLOR = [UIColor orangeColor];
    
    UIButton *newButton = (UIButton*)sender;
    UIButton *oldButton = [_numbers objectAtIndex:([self currentNum] - 1)];
    
    // Change the background colors appropriately
    oldButton.backgroundColor = NUMPAD_NORMAL_COLOR;
    newButton.backgroundColor = NUMPAD_SELECT_COLOR;
    
    // Update which button is currently selected
    [self setCurrentNum:(int)newButton.tag];
}

@end