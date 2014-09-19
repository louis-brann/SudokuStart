//
//  LBSTGridModel.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/19/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBSTGridModel.h"

@implementation LBSTGridModel

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

int currentGrid[9][9]={
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
    // Do nothing for now?
}

- (int) getValueAtRow:(int)row andColumn:(int) col
{
    int numberGotten = currentGrid[row][col];
    return numberGotten;
}

-(BOOL) isCellMutable:(int)row andColumn:(int)col
{
    if (initialGrid[row][col] == 0){
        return YES;
    } else {
        return NO;
    }
}

@end
