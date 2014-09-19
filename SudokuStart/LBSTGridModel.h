//
//  LBSTGridModel.h
//  SudokuStart
//
//  Created by Laptop 16 on 9/19/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBSTGridModel : NSObject

-(void) initializeGrid;
-(int) getValueAtRow:(int)row andColumn:(int)col;
-(BOOL) isCellMutable:(int)row andColumn:(int)col;


@end
