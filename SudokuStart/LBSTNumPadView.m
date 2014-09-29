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
    
    // Set up button click audio
    NSError *error;
    NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"];
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    AVAudioPlayer *numpadPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    [numpadPlayer prepareToPlay];
    self.audioPlayer = numpadPlayer;
    
    // Set up button size and offset
    CGFloat buttonSize = frame.size.width / 10.0;
    CGFloat baseOffset = buttonSize / 10.0;
    CGFloat xOffset = baseOffset;
    
    // Set up delete button
    CGFloat deleteButtonWidth = (9 * buttonSize) + (8 * baseOffset);
    CGFloat deleteButtonHeight = 0.75 * buttonSize;
    CGFloat deleteButtonXOffset = baseOffset;
    CGFloat deleteButtonYOffset = buttonSize + (2 * baseOffset);
    
    // Set up delete button
    CGRect deleteButtonFrame = CGRectMake(deleteButtonXOffset, deleteButtonYOffset, deleteButtonWidth, deleteButtonHeight);
    UIButton *deleteButton = [[UIButton alloc] initWithFrame:deleteButtonFrame];
    deleteButton.tag = 0;
    
    // Delete button background TODO
    deleteButton.backgroundColor = [UIColor redColor];
    
    // Set up delete button title
    [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
    [deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    deleteButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:IPAD_FONT_SIZE];
    deleteButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [self addSubview:deleteButton];
    
    [deleteButton addTarget:self action:@selector(numSelected:) forControlEvents:UIControlEventTouchDown];
    [_numbers addObject:deleteButton];
    
    UIButton *button;
    
    // Initialize number buttons
    for (int i = 0; i < 9; ++i) {
      CGRect buttonFrame = CGRectMake(xOffset, baseOffset, buttonSize, buttonSize);
      
      button = [[UIButton alloc] initWithFrame:buttonFrame];
      
      // Set button properties
      int buttonNum = i + 1;
      button.tag = buttonNum;
      
      // Make button 1 the default selected button
      UIImage *numpadNormalImage = [UIImage imageNamed:@"numpad-normal.png"];
      UIImage *numpadSelectedImage = [UIImage imageNamed:@"numpad-highlight.png"];
      if (buttonNum == 1) {
        [self setCurrentNum:buttonNum];
        [button setBackgroundImage:numpadSelectedImage forState:UIControlStateNormal];
      }
      else {
        [button setBackgroundImage:numpadNormalImage forState:UIControlStateNormal];
      }
      
      // Set up title
      [button setTitle:[NSString stringWithFormat:@"%ld", (long)button.tag] forState:UIControlStateNormal];
      [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:IPAD_FONT_SIZE];
      button.titleLabel.adjustsFontSizeToFitWidth = YES;
      
      [self addSubview:button];
      
      // Create target for button
      [button addTarget:self action:@selector(numSelected:) forControlEvents:UIControlEventTouchDown];
      
      // Add the button to the array
      [_numbers insertObject:button atIndex:buttonNum];
      
      xOffset += buttonSize + baseOffset;
    }
    
    
    
//    CGRect clearGridButtonFrame = CGRectMake(clearGridButtonXOffset, secondRowYOffset, secondRowButtonWidth, buttonSize);
//    _clearGridButton = [[UIButton alloc] initWithFrame:clearGridButtonFrame];
//    
//    // Clear grid button background TODO
//    _clearGridButton.backgroundColor = [UIColor redColor];
//    
//    // Set up clear grid button title
//    [_clearGridButton setTitle:@"Clear Grid" forState:UIControlStateNormal];
//    [_clearGridButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    _clearGridButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:IPAD_FONT_SIZE];
//    _clearGridButton.titleLabel.adjustsFontSizeToFitWidth = YES;
//    
//    [self addSubview:_clearGridButton];
//    
//    [_clearGridButton addTarget:self action:@selector(clearWasPressed) forControlEvents:UIControlEventTouchUpInside];
  }

  return self;
}

- (void)numSelected:(id)sender
{
  // Play a sound effect!
  [self.audioPlayer play];
  
  UIImage *numpadNormalImage = [UIImage imageNamed:@"numpad-normal.png"];
  UIImage *numpadSelectedImage = [UIImage imageNamed:@"numpad-highlight.png"];

  UIButton *newButton = (UIButton*)sender;
  UIButton *oldButton = [_numbers objectAtIndex:[self currentNum]];
  
  // Change the background colors appropriately
  [oldButton setBackgroundImage:numpadNormalImage forState:UIControlStateNormal];
  [newButton setBackgroundImage:numpadSelectedImage forState:UIControlStateNormal];

  // Update which button is currently selected
  [self setCurrentNum:(int)newButton.tag];
}

- (void)clearWasPressed
{
  // Delegate to ViewController
  [self.delegate clearCellValues];
}

@end
