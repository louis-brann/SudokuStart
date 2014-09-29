//
//  LBSTGridModel.h
//  SudokuStart
//
//  Created by Laptop 16 on 9/19/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>

@protocol AlertWin
-(void)alertWin;
@end

@interface LBSTGridModel : NSObject

@property (assign, nonatomic) id <AlertWin> delegate;

-(void) initializeGrid;
-(int) getValueAtRow:(int)row andColumn:(int)col;
-(void) setValue:(int)value atRow:(int)row andColumn:(int)col;
-(BOOL) isCellMutableAtRow:(int)row andColumn:(int)col;
-(BOOL) isValueConsistent:(int)input atRow:(int)row andColumn:(int)col;
-(void) clearGrid;

// public for testing
-(void) parseGridString:(NSString *)gridString;
-(BOOL) isWinning;

@end
