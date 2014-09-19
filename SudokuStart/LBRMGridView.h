//
//  LBRMGrid.h
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellWasTapped
- (void)cellWasTapped:(id)sender;
@end

@interface LBRMGridView : UIView

@property (nonatomic, assign) id <CellWasTapped> delegate;

-(void)setValueAtRow:(int)row andColumn:(int)col to:(int)value;

@end
