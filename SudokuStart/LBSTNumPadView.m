//
//  LBSTNumPadView.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/18/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBSTNumPadView.h"

@implementation LBSTNumPadView
{
    NSMutableArray* _numbers;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    
    _numbers = [[NSMutableArray alloc] initWithCapacity:9];
    
    // Initialize number buttons
    for (int i = 0; i < 9; ++i) {
        UIButton* button;
    }
    
    return self;
}

@end
