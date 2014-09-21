//
//  SudokuStartTests.m
//  SudokuStartTests
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBSTGridModel.h"
#import <XCTest/XCTest.h>

@interface SudokuStartTests : XCTestCase

@end

@implementation SudokuStartTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

// Test getValue
// Assumes that the inputs row, col to getValue will be in the range [0,8]
- (void) testGetValues
{
    LBSTGridModel *testModel = [[LBSTGridModel alloc] init];
    XCTAssertTrue([testModel getValueAtRow:2 andColumn:6] == 5, @"Testing value at 2,6");
    XCTAssertTrue([testModel getValueAtRow:0 andColumn:0] == 7, @"Testing value at 0,0");
    XCTAssertTrue([testModel getValueAtRow:8 andColumn:8] == 0, @"Testing value at 8,8");
}

// Test setValue
// Assumes that the value to set will be an int in the range [1,9]
// Assumes that the row, col to set the value to has been checked for mutability and consistency
- (void) testSetValues
{
    LBSTGridModel *testModel = [[LBSTGridModel alloc] init];
    
    XCTAssertTrue([testModel getValueAtRow:6 andColumn:2] == 0, @"Ensure cell 6,2 is empty");
    [testModel setValue:2 atRow:6 andColumn:2];
    XCTAssertTrue([testModel getValueAtRow:6 andColumn:2] == 2, @"Ensure value 2 was set at 6,2");
    [testModel setValue:3 atRow:6 andColumn:2];
    XCTAssertTrue([testModel getValueAtRow:6 andColumn:2] == 3, @"Ensure value 3 was set at 6,2");
    
    XCTAssertTrue([testModel getValueAtRow:2 andColumn:5] == 0, @"Ensure cell 2,5 is empty");
    [testModel setValue:1 atRow:2 andColumn:5];
    XCTAssertTrue([testModel getValueAtRow:2 andColumn:5] == 1, @"Ensure value 1 was set at 2,5");
    [testModel setValue:8 atRow:2 andColumn:5];
    XCTAssertTrue([testModel getValueAtRow:2 andColumn:5] == 8, @"Ensure value 8 was set at 2,5");
}

// Test isMutable
// Assumes that the inputs row, col to isMutable will be in the range [0,8]
- (void) testIsMutable
{
    LBSTGridModel *testModel = [[LBSTGridModel alloc] init];
    
    XCTAssertTrue([testModel isCellMutableAtRow:1 andColumn:0], @"Test that cell 1,0 is mutable");
    XCTAssertFalse([testModel isCellMutableAtRow:0 andColumn:0], @"Test that cell 0,0 is not mutable");
    XCTAssertTrue([testModel isCellMutableAtRow:7 andColumn:8], @"Test that cell 7,8 is mutable");
}

// Test isConsistent
// Assumes that the inputs row, col to isConsistent will be in the range [0,8]
// Assumes that the value to be checked is an int in the range [1,9]
- (void) testIsConsistent
{
    LBSTGridModel *testModel = [[LBSTGridModel alloc] init];
    
    XCTAssertTrue([testModel isValueConsistent:1 atRow:0 andColumn:2], @"Test if 1 is consistent at 0,2");
    
    // Ensure that inconsistencies are found for row, col, and subgrid
    XCTAssertFalse([testModel isValueConsistent:4 atRow:7 andColumn:5], @"Test that 4 is not consistent at 7,5");
    XCTAssertFalse([testModel isValueConsistent:9 atRow:6 andColumn:2], @"Test that 9 is not consistent at 6,2");
    XCTAssertFalse([testModel isValueConsistent:9 atRow:6 andColumn:5], @"Test that 9 is not consistent at 6,5");
}

@end
