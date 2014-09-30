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

// All tests implicitly test parseGridString

// Test getValue
// Assumes that the inputs row, col to getValue will be in the range [0,8]
- (void) testGetValues
{
  LBSTGridModel *testModel = [[LBSTGridModel alloc] init];
  NSString* testGrid = @"7..6...38..2581.4..9.......456...8932.9..46......65..2..54.6.17...3....494..7.2..";
  [testModel parseGridString:testGrid];

  XCTAssertTrue([testModel getValueAtRow:6 andColumn:2] == 5, @"Testing value at 6,2");
  XCTAssertTrue([testModel getValueAtRow:0 andColumn:0] == 7, @"Testing value at 0,0");
  XCTAssertTrue([testModel getValueAtRow:8 andColumn:8] == 0, @"Testing value at 8,8");
}

// Test setValue
// Assumes that the value to set will be an int in the range [1,9]
// Assumes that the row, col to set the value to has been checked for mutability and consistency
- (void) testSetValues
{
  LBSTGridModel *testModel = [[LBSTGridModel alloc] init];
  NSString* testGrid = @"7..6...38..2581.4..9.......456...8932.9..46......65..2..54.6.17...3....494..7.2..";
  [testModel parseGridString:testGrid];

  XCTAssertTrue([testModel getValueAtRow:2 andColumn:6] == 0, @"Ensure cell 2,6 is empty");
  [testModel setValue:2 atRow:2 andColumn:6];
  XCTAssertTrue([testModel getValueAtRow:2 andColumn:6] == 2, @"Ensure value 2 was set at 2,6");
  [testModel setValue:3 atRow:2 andColumn:6];
  XCTAssertTrue([testModel getValueAtRow:2 andColumn:6] == 3, @"Ensure value 3 was set at 2,6");
  
  XCTAssertTrue([testModel getValueAtRow:5 andColumn:2] == 0, @"Ensure cell 5,2 is empty");
  [testModel setValue:1 atRow:5 andColumn:2];
  XCTAssertTrue([testModel getValueAtRow:5 andColumn:2] == 1, @"Ensure value 1 was set at 5,2");
  [testModel setValue:8 atRow:5 andColumn:2];
  XCTAssertTrue([testModel getValueAtRow:5 andColumn:2] == 8, @"Ensure value 8 was set at 5,2");
}

// Test isMutable
// Assumes that the inputs row, col to isMutable will be in the range [0,8]
- (void) testIsMutable
{
  LBSTGridModel *testModel = [[LBSTGridModel alloc] init];
  NSString* testGrid = @"7..6...38..2581.4..9.......456...8932.9..46......65..2..54.6.17...3....494..7.2..";
  [testModel parseGridString:testGrid];

  XCTAssertTrue([testModel isCellMutableAtRow:0 andColumn:1], @"Test that cell 0,1 is mutable");
  XCTAssertFalse([testModel isCellMutableAtRow:0 andColumn:0], @"Test that cell 0,0 is not mutable");
  XCTAssertTrue([testModel isCellMutableAtRow:8 andColumn:7], @"Test that cell 8,7 is mutable");
}

// Test isConsistent
// Assumes that the inputs row, col to isConsistent will be in the range [0,8]
// Assumes that the value to be checked is an int in the range [1,9]
- (void) testIsConsistent
{
  LBSTGridModel *testModel = [[LBSTGridModel alloc] init];
  NSString* testGrid = @"7..6...38..2581.4..9.......456...8932.9..46......65..2..54.6.17...3....494..7.2..";
  [testModel parseGridString:testGrid];

  XCTAssertTrue([testModel isValueConsistent:1 atRow:2 andColumn:0], @"Test if 1 is consistent at 2,0");
  
  // Ensure that inconsistencies are found for row, col, and subgrid
  XCTAssertFalse([testModel isValueConsistent:4 atRow:5 andColumn:7], @"Test that 4 is not consistent at 5,7");
  XCTAssertFalse([testModel isValueConsistent:9 atRow:2 andColumn:6], @"Test that 9 is not consistent at 2,6");
  XCTAssertFalse([testModel isValueConsistent:9 atRow:5 andColumn:6], @"Test that 9 is not consistent at 5,6");
}

// Test isWinning
- (void) testIsWinning
{
  LBSTGridModel *testModel = [[LBSTGridModel alloc] init];
  
  NSString *nearWinningBoard = @"96152843743761958258243796182619375475926431831487562917534289664398127529875614.";
  [testModel parseGridString:nearWinningBoard];
  int lastValue = 3;
  [testModel setValue:lastValue atRow:8 andColumn:8];
  
  XCTAssertTrue([testModel isWinning], @"Confirm that a winning board is found to be correct");
  
  // Ensure that inconsistencies are found for row, col, and subgrid
  [testModel clearGrid];
  nearWinningBoard = @".61529437437619582582437961826193754759264318314875629175342896643981275298756143";
  [testModel parseGridString:nearWinningBoard];
  lastValue = 9;
  [testModel setValue:lastValue atRow:0 andColumn:0];
  
  [testModel clearGrid];
  nearWinningBoard = @".61528437437619582582437961926193754759264318314875629175342896643981275298756143";
  [testModel parseGridString:nearWinningBoard];
  lastValue = 9;
  [testModel setValue:lastValue atRow:0 andColumn:0];
  
  [testModel clearGrid];
  nearWinningBoard = @".61528437437619582592437961826193754759264318314875629175342896643981275298756143";
  [testModel parseGridString:nearWinningBoard];
  lastValue = 9;
  [testModel setValue:lastValue atRow:0 andColumn:0];
}

@end
