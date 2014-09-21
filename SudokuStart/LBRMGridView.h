//
//  LBRMGrid.h
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBRMGridView : UIView

-(void)setValueAtRow:(int)row andColumn:(int)col to:(int)value isInitial:(BOOL)isInitial;
-(void)addTarget:(id)target action:(SEL) action;

@end
