//
//  LBRMGrid.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//                      Sarah Trisorus
//

#import "LBRMGridView.h"

@implementation LBRMGridView {
    NSMutableArray *_cells;
}

static CGFloat const IPAD_FONT_SIZE = 40;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if (self) {
    // Initialize array of cells for 9x9 sudoku
    _cells = [[NSMutableArray alloc] initWithCapacity:9];
    
    for (int i = 0; i < 9; ++i) {
      [_cells addObject:[[NSMutableArray alloc] initWithCapacity:9]];
    }

    // Setup cell size and offset
    CGFloat frameSize = MIN(CGRectGetHeight(frame), CGRectGetWidth(frame));
    
    // 9 cells, plus 1 cellSize reserved for borders
    CGFloat cellSize = frameSize/(9.0 + 1.0);
    
    // 10 Borders for 9 columns, + 4 to further separate subgrids
    CGFloat baseOffset = cellSize/(10.0 + 4.0);
    
    CGFloat yOffset = baseOffset;
    
    UIButton *cell;
    
    for (int row = 0; row < 9; ++row){
      // Set/reset xOffset for new column
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
        
        // Set up frame and cell
        CGRect cellFrame = CGRectMake(xOffset, yOffset, cellSize, cellSize);
        cell = [[UIButton alloc] initWithFrame:cellFrame];
      
        int xSubgrid = col / 3;
        int ySubgrid = row / 3;
        
        [self addSubview: cell];
        
        // Create target for cell
        [cell addTarget:self action:@selector(cellSelected:)
           forControlEvents:UIControlEventTouchUpInside];
        
        // Style the cell
        // Give different colors to every other subgrid
        // Colors arbitrarily chosen for aesthetic pleasure. Both are blue.
        if (abs(xSubgrid - ySubgrid) % 2 == 1) {
          cell.backgroundColor = [UIColor colorWithRed:0.706 green:0.867
                                                  blue:0.922 alpha:1.0];
        }
        else {
          cell.backgroundColor = [UIColor colorWithRed:0.898 green:0.973
                                                  blue:1.0 alpha:1.0];
        }
        
        // Highlight color arbitrarily chosen for aesthetic pleasure
        // It's green
        UIColor *cellHighlightColor = [UIColor colorWithRed:0.486 green:0.816
                                                       blue:0.447 alpha:1.0];
        [cell setBackgroundImage: [UIImage imageWithColor:cellHighlightColor]
                        forState:UIControlStateHighlighted];
        
        [cell setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cell.titleLabel.adjustsFontSizeToFitWidth = YES;
        
        // Make the tag such that the first digit represents the row, and the
        // second represents the column
        cell.tag = (row * 10) + col;
        
        [[_cells objectAtIndex:row] insertObject:cell atIndex:col];
        
        // Update column offset
        xOffset += cellSize + baseOffset;
      }
      
      // Update row offset
      yOffset += cellSize + baseOffset;
    }
  }
  
  return self;
}

- (void)cellSelected:(id)sender
{
  // Delegate to ViewController
  [self.delegate cellWasTapped:sender];
}

- (void)setValue:(int)value atRow:(int)row andColumn:(int)col
{
  UIButton *cell = [[_cells objectAtIndex:row] objectAtIndex:col];
  
  // If the value is not 0, convert it into a string for the cell title
  // Otherwise, the string is blank
  if (value != 0){
    NSString *numberToDisplay = [NSString stringWithFormat:@"%d", value];
    [cell setTitle:numberToDisplay forState:UIControlStateNormal];
  }
  else {
    [cell setTitle:@"" forState:UIControlStateNormal];
  }
}

- (void)setInitialValue:(int)value atRow:(int)row andColumn:(int)col
{
  UIButton *cell = [[_cells objectAtIndex:row] objectAtIndex:col];
  
  // If the value is not 0, it is an initial value, so make it bold
  // Otherwise, it is not initial, so set the font lighter so the
  // user can differentiate between initial and non-initial
  if (value != 0){
    cell.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold"
                                           size:IPAD_FONT_SIZE];
    
  } else {
    cell.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light"
                                           size:IPAD_FONT_SIZE];
  }
  
  [self setValue:value atRow:row andColumn:col];
}

@end
