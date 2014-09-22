//
//  SudokuStartTests.m
//  SudokuStartTests
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LBRMGridModel.h"

@interface SudokuStartTests : XCTestCase
{
    LBRMGridModel *_gridModel;
}

@end

int _solution[9][9] = {
    {7,6,5,4,2,3,8,1,9},
    {1,3,9,5,7,8,2,6,4},
    {4,2,8,6,9,1,5,7,3},
    {6,5,7,2,8,9,4,3,1},
    {2,8,4,1,3,6,9,5,7},
    {9,1,3,7,4,5,6,2,8},
    {5,7,1,8,6,4,3,9,2},
    {3,4,2,9,5,7,1,8,6},
    {8,9,6,3,1,2,7,4,5}
};

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

@implementation SudokuStartTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _gridModel = [[LBRMGridModel alloc] init];
}

// Tests if the model will correctly update a non-initial cell and refuse to update
// an initial value
- (void)testUpdateValueatRow
{
    int initalValue = [_gridModel getValueAtRow:0 Column:0];
    XCTAssertTrue(initalValue == initialGrid[0][0], @"Initial value is wrong or ability to read value is wrong");
    
    [_gridModel updateValueAtRow:0 Column:0 withNewValue:5];
    XCTAssertTrue([_gridModel getValueAtRow:0 Column:0] == initalValue, @"Updates initial values.");
    
    [_gridModel updateValueAtRow:1 Column:1 withNewValue:_solution[1][1]];
    XCTAssertTrue([_gridModel getValueAtRow:1 Column:1] == _solution[1][1], @"Doesn't correctly update non-inital values");
    
}

// Tests to see if the check solution method works properly
- (void)testCheckSolution
{
    XCTAssertTrue(![_gridModel checkGridIsSolved], @"Thinks the initial grid is a solution.");
    
    for (int i = 0; i < 9; ++i) {
        for (int j = 0; j < 9; ++j) {
            [_gridModel updateValueAtRow:i Column:j withNewValue:5];
        }
    }
    XCTAssertTrue(![_gridModel checkGridIsSolved], @"Thinks a grid where all non-initial values are 5 is solved.");
    
    for (int i = 0; i < 9; ++i) {
        for (int j = 0; j < 9; ++j) {
            [_gridModel updateValueAtRow:i Column:j withNewValue:_solution[i][j]];
        }
    }
    
    XCTAssertTrue([_gridModel checkGridIsSolved], @"Thinks the plugged in solution doesn't solve the puzzle.");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


@end
