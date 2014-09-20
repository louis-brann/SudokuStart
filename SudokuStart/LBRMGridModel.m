//
//  LBRMGridModel.m
//  SudokuStart
//
//  Created by Laptop23 on 9/20/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBRMGridModel.h"


int initialGrid[9][9]={
    {7,0,0,4,2,0,0,0,9},
    {0,0,9,5,0,0,0,0,4},
    {0,2,0,6,9,0,5,0,0},
    {6,5,0,0,0,0,4,3,0},
    {0,8,0,0,0,6,0,0,7},
    {0,1,0,0,4,5,6,0,0},
    {0,0,0,8,6,0,0,0,2},
    {3,4,0,9,0,0,1,0,0},
    {8,0,0,3,0,2,7,4,0}
};

@implementation LBRMGridModel
{
    int _initialGrid[9][9];
    int _currentGrid[9][9];
}

- (id)init
{
    self = [super init];
    [self initializeGrid];
    return self;
}

-(void)initializeGrid
{
    for (int i = 0; i < 9; ++i) {
        for (int j = 0; j < 9; ++j) {
            _currentGrid[i][j] = initialGrid[i][j];
        }
    }
}

-(int)getValueAtRow:(int)row Column:(int)column
{
    return _currentGrid[row][column];
}

-(BOOL)updateValueAtRow:(int)row Column:(int)column withNewValue:(int)newValue
{
    // check for consistency.  if the cell has a non-zero value in the initial
    // array, it can't be changed, otherwise it can.
    if (initialGrid[row][column] != 0) {
        return NO;
    }
    
    // IF the change is valid, tell the view controller
    _currentGrid[row][column] = newValue;
    return YES;
}
@end
