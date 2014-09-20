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
    //NSMutableArray *_initialGrid;
    //NSMutableArray *_currentGrid;
}

int _initialGrid[9][9]={
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

int _currentGrid[9][9]={
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

- (void) initializeGrid
{
    // Generate new grid (not needed now)
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

    // Put in initialGrid and currentGrid, counting 0s while going through
//    _initialGrid = [[NSMutableArray alloc] initWithCapacity:9];
//    _currentGrid = [[NSMutableArray alloc] initWithCapacity:9];
//
//    for (int i = 0; i < 9; ++i){
//        [_initialGrid addObject:[[NSMutableArray alloc] initWithCapacity:9]];
//        [_currentGrid addObject:[[NSMutableArray alloc] initWithCapacity:9]];
//    }
//    
//    for (int row = 0; row < 9; ++row){
//        for (int col = 0; col < 9; ++col){
//            [[_initialGrid objectAtIndex:row] insertObject:[NSNumber numberWithInt:initialGrid[row][col]] atIndex:col];
//            [[_currentGrid objectAtIndex:row] insertObject:[NSNumber numberWithInt:initialGrid[row][col]] atIndex:col];
//        }
//    }
}

- (int) getValueAtRow:(int)row andColumn:(int) col
{
//    NSNumber *nsValue = [[_currentGrid objectAtIndex:row] objectAtIndex:col];
//    return [nsValue intValue];
    return _currentGrid[row][col];
}

-(void) setValue:(int)value atRow:(int)row andColumn:(int)col
{
//    [[_currentGrid objectAtIndex:row] setObject:[NSNumber numberWithInt:value] atIndex:col];
    _currentGrid[row][col] = value;
}

-(BOOL) isCellMutable:(int)row andColumn:(int)col
{
//    if ([[_initialGrid objectAtIndex:row] objectAtIndex:col] == 0){
    if (_initialGrid[row][col] == 0) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL) isValueConsistent:(int)value atRow:(int)row andColumn:(int)col
{
    // Check the row of the value
    for (int i = 0; i < 9; ++i) {
        if (_initialGrid[row][i] == value) {
            return NO;
        }
    }

    // Check the column of the value
    for (int i = 0; i < 9; ++i) {
        if (_initialGrid[i][col] == value) {
            return NO;
        }
    }
    
    // Check the subgrid of the value
    int subgridRowStart = row - (row % 3);
    int subgridColStart = col - (col % 3);
    
    for (int i = 0; i < 3; ++i) {
        for (int j = 0; j < 3; ++j) {
            if (_initialGrid[subgridRowStart+i][subgridColStart+j] == value) {
                return NO;
            }
        }
    }
    
    // Otherwise, the value is consistent
    return YES;
}

@end
