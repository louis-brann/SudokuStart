//
//  LBRMGridModel.h
//  SudokuStart
//
//  Created by Laptop23 on 9/20/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBRMGridModel : NSObject

-(void)initializeGrid;
-(int)getValueAtRow:(int)row Column:(int)column;
-(BOOL)updateValueAtRow:(int)row Column:(int)column withNewValue:(int)newValue;
-(BOOL)checkGridIsSolved;

@end
