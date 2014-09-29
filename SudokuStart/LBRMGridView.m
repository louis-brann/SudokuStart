//
//  LBRMGrid.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//                      Sarah Trisorus
//

#import "LBRMGridView.h"
#import "UIImage+LBSTColorImage.h"

@implementation LBRMGridView {
    NSMutableArray *_cells;
}

static CGFloat const IPAD_FONT_SIZE = 40;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self) {
    // Initialize array of buttons for 9x9 sudoku
    _cells = [[NSMutableArray alloc] initWithCapacity:9];
    for (int i = 0; i < 9; ++i) {
      [_cells addObject:[[NSMutableArray alloc] initWithCapacity:9]];
    }

    // Setup button size and offset
    CGFloat frameSize = MIN(frame.size.height, frame.size.width);
    
    // 9 buttons, plus 1 buttonSize reserved for borders
    CGFloat buttonSize = frameSize/(9.0 + 1.0);
    
    // 10 Borders for 9 columns, + 4 to further separate subgrids
    CGFloat baseOffset = buttonSize/(10.0 + 4.0);
    
    CGFloat yOffset = baseOffset;
    UIButton *button;
    
    for (int row = 0; row < 9; ++row){
      // Set/reset yOffset for new column
      CGFloat xOffset = baseOffset;
      
      // Extra horizontal offset to separate 3x3 subgrids
      if (row % 3 == 0){
        yOffset += baseOffset;
      }
      
      for (int col = 0; col < 9; ++col){
        // Extra vertical offset to separate 3x3 subgrids
        if (col % 3 == 0){
          xOffset += baseOffset;
        }
        
        // Setup frame and button
        CGRect buttonFrame = CGRectMake(xOffset, yOffset, buttonSize, buttonSize);
        button = [[UIButton alloc] initWithFrame:buttonFrame];
      
        int xSubgrid = col / 3;
        int ySubgrid = row / 3;
      
        // Give different colors to every other subgrid
        if (abs(xSubgrid - ySubgrid) % 2 == 1) {
          button.backgroundColor = [UIColor colorWithRed:0.706 green:0.867 blue:0.922 alpha:1.0];
        }
        else {
          button.backgroundColor = [UIColor colorWithRed:0.898 green:0.973 blue:1.0 alpha:1.0];
        }
        
        [self addSubview: button];
        
        // Create target for button
        [button addTarget:self action:@selector(cellSelected:)forControlEvents:UIControlEventTouchUpInside];
        
        // Set up title
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        // Set up highlighted background
        UIColor *cellHighlightColor = [UIColor colorWithRed:0.486 green:0.816 blue:0.447 alpha:1.0];
        [button setBackgroundImage: [UIImage imageWithColor:cellHighlightColor] forState:UIControlStateHighlighted];
        
        // Make the tag such that the first digit represents the
        // row, and the second represents the column
        button.tag = row*10+col;
        
        [[_cells objectAtIndex:row] insertObject:button atIndex:col];
        
        // Update column offset
        xOffset += buttonSize+baseOffset;
      }
      
      // Update row offset
      yOffset += buttonSize + baseOffset;
    }
  }
  
  return self;
}

- (void)cellSelected:(id)sender
{
  // Send info to ViewController
  [self.delegate cellWasTapped:sender];
}

-(void)setValue:(int)value atRow:(int)row andColumn:(int)col
{
  UIButton *button = [[_cells objectAtIndex:row] objectAtIndex:col];
  
  // If the value is not 0, convert it into a string for the button title
  // Otherwise, it is blank
  if (value != 0){
    NSString *numberToDisplay = [NSString stringWithFormat:@"%d", value];
    [button setTitle:numberToDisplay forState:UIControlStateNormal];
  }
  else {
    [button setTitle:@"" forState:UIControlStateNormal];
  }
}

-(void)setInitialValue:(int)value atRow:(int)row andColumn:(int)col
{
  UIButton *button = [[_cells objectAtIndex:row] objectAtIndex:col];
  
  // If the value is not 0, it is an initial value, so make it bold
  // Otherwise, it is not initial, so set the font lighter so the
  //  user can differentiate between initial and non-initial
  if (value != 0){
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:IPAD_FONT_SIZE];
    
  } else {
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:IPAD_FONT_SIZE];
  }
  
  [self setValue:value atRow:row andColumn:col];
}

@end
