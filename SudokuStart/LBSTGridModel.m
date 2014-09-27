//
//  LBSTGridModel.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/19/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBSTGridModel.h"

@implementation LBSTGridModel{
  int _numBlankCells;
  NSMutableArray *_initialGrid;
  NSMutableArray *_currentGrid;
}

- (NSString *) getGridString:(int)gridNumber {
  // Determine which file the chosen grid is in
  int gridFile = gridNumber / 30000;
  
  NSString *path;
  NSError *error;
  
  // Choose the correct path to the file
  if (gridFile == 0) {
    path = [[NSBundle mainBundle] pathForResource:@"grid1" ofType:@"txt"];
  } else {
    path = [[NSBundle mainBundle] pathForResource:@"grid2" ofType:@"txt"];
  }
  
  NSString *gridString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
  
  // Get the substring of 81 chars for the chosen grid
  int gridSubstringStartIndex = (gridNumber - (gridFile * 30000)) * 82;
  NSString *gridSubstring = [gridString substringWithRange:NSMakeRange(gridSubstringStartIndex, 81)];
  
  return gridSubstring;
}

- (void) parseGridString:(NSString *)gridString {
  
  // Put in initialGrid and currentGrid, counting 0s while going through
  _initialGrid = [[NSMutableArray alloc] initWithCapacity:9];
  _currentGrid = [[NSMutableArray alloc] initWithCapacity:9];
  _numBlankCells = 0;
  NSNumber *numberToAdd;
  
  // It returned an out of bounds error after trying to add to empty nested arrays,
  // so we made the inner arrays first, then added
  for (int row = 0; row < 9; ++row){
    
    NSMutableArray *initRowArray = [[NSMutableArray alloc] initWithCapacity:9];
    NSMutableArray *currRowArray = [[NSMutableArray alloc] initWithCapacity:9];
    
    for (int col = 0; col < 9; ++col){
      int currentNumberPosition = (row * 9) + col;
      NSString *currentNumberString = [gridString substringWithRange:NSMakeRange(currentNumberPosition, 1)];
      
      if ([currentNumberString isEqualToString:@"."]) {
        numberToAdd = [NSNumber numberWithInt:0];
      } else {
        numberToAdd =[NSNumber numberWithInt:[currentNumberString intValue]];
      }
      
      if ([numberToAdd intValue] == 0){
        ++_numBlankCells;
      }
      
      [initRowArray insertObject:numberToAdd atIndex:col];
      [currRowArray insertObject:numberToAdd atIndex:col];
    }
    
    [_initialGrid addObject:initRowArray];
    [_currentGrid addObject:currRowArray];
  }
}

- (void) initializeGrid
{
  // Choose a random grid to initialize the board with
  int randomGridNumber = arc4random_uniform(60000);
  
  NSString *randomGridString = [self getGridString:randomGridNumber];
  [self parseGridString:randomGridString];
  
}

- (int) getValueAtRow:(int)row andColumn:(int)col
{
  NSNumber *nsValue = [[_currentGrid objectAtIndex:row] objectAtIndex:col];
  return [nsValue intValue];
}

-(void) setValue:(int)value atRow:(int)row andColumn:(int)col
{
  NSNumber *currentNSValue = [[_currentGrid objectAtIndex:row] objectAtIndex:col];
  
  if ([currentNSValue intValue] == 0){
    --_numBlankCells;
  }
  
  [[_currentGrid objectAtIndex:row] setObject:[NSNumber numberWithInt:value] atIndex:col];
  
  // If input fills grid, check for a win
  if (_numBlankCells == 0){
    if ([self isWinning]){
      [self.delegate alertWin];
    }
  }
}

// Mutable if empty in initial grid
-(BOOL) isCellMutableAtRow:(int)row andColumn:(int)col
{
  NSNumber *nsValue = [[_initialGrid objectAtIndex:row] objectAtIndex:col];
  if ([nsValue intValue] == 0){
    return YES;
  } else {
    return NO;
  }
}

// Checks values for consistency against initial values upon being input
//   Does not need to avoid checking against itself, since it only gets called
//   when values are being input, and initial values cannot be overwritten
-(BOOL) isValueConsistent:(int)value atRow:(int)row andColumn:(int)col
{
  // Check the row of the value
  for (int i = 0; i < 9; ++i) {
    NSNumber *nsValue = [[_initialGrid objectAtIndex:row] objectAtIndex:i];
      if ([nsValue intValue] == value) {
          return NO;
      }
  }

  // Check the column of the value
  for (int i = 0; i < 9; ++i) {
    NSNumber *nsValue = [[_initialGrid objectAtIndex:i] objectAtIndex:col];
    if ([nsValue intValue] == value) {
      return NO;
    }
  }
  
  // Check the subgrid of the value
  int subgridRowStart = row - (row % 3);
  int subgridColStart = col - (col % 3);
  
  for (int i = 0; i < 3; ++i) {
    for (int j = 0; j < 3; ++j) {
      NSNumber *nsValue = [[_initialGrid objectAtIndex:subgridRowStart+i] objectAtIndex:subgridColStart+j];
      if ([nsValue intValue] == value) {
        return NO;
      }
    }
  }
  
  // Otherwise, the value is consistent
  return YES;
}

-(BOOL)isCurrentGridConsistentWithValue:(int)value atRow:(int)row andColumn:(int)col
{
  // Check the row of the value, avoiding checking against itself (i = col)
  for (int i = 0; i < 9; ++i) {
    NSNumber *nsValue = [[_currentGrid objectAtIndex:row] objectAtIndex:i];
    if (i != col && [nsValue intValue] == value) {
      return NO;
    }
  }
  
  // Check the column of the value, avoiding checking against itself (i = row)
  for (int i = 0; i < 9; ++i) {
    NSNumber *nsValue = [[_currentGrid objectAtIndex:i] objectAtIndex:col];
    if (i != row && [nsValue intValue] == value) {
      return NO;
    }
  }
  
  // Check the subgrid of the value
  int subgridRowStart = row - (row % 3);
  int subgridColStart = col - (col % 3);
  
  for (int i = 0; i < 3; ++i) {
    for (int j = 0; j < 3; ++j) {
      int currentCellRow = subgridRowStart+i;
      int currentCellCol = subgridColStart+j;
      
      NSNumber *nsValue = [[_currentGrid objectAtIndex:currentCellRow] objectAtIndex:currentCellCol];
      
      // Make sure to avoid checking against itself
      if (!(currentCellRow == row && currentCellCol == col) && [nsValue intValue] == value) {
        return NO;
      }
    }
  }

  return YES;
}

-(BOOL)isWinning
{
  // Check each cell for consistency with current (filled in) grid; if they're
  // all consistent, it is winning!
  for (int row = 0; row < 9; ++row){
    for (int col = 0; col < 9; ++col){
      NSNumber *nsValue = [[_currentGrid objectAtIndex:row] objectAtIndex:col];
      BOOL valueConsistent = [self isCurrentGridConsistentWithValue:[nsValue intValue] atRow:row andColumn:col];
      
      if (!valueConsistent){
        return NO;
      }
    }
  }
  
  return YES;
}

-(void)clearGrid
{
  [_initialGrid removeAllObjects];
  [_currentGrid removeAllObjects];
}

@end
