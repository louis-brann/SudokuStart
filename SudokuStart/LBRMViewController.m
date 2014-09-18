//
//  LBRMViewController.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBRMViewController.h"
#import "LBRMGridView.h"

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

static double const padding = .1;
static int const sizeRelativeToPadding = 8;

@interface LBRMViewController (){
    LBRMGridView* _gridView;
}

@end

@implementation LBRMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // Create the frame, leaving 10% padding on each side, resulting in a centred
    // frame that takes up 80% of the screen.
    CGRect frame = self.view.frame;
    CGFloat x = CGRectGetWidth(frame) * padding;
    CGFloat y = CGRectGetHeight(frame) * padding;
    CGFloat size = MIN(x, y) * sizeRelativeToPadding;
    
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    
    // Set target and action for button presses in grid view
    
    
    // create grid view
    _gridView = [LBRMGridView alloc];
    [_gridView addTarget:self action:@selector(buttonPressed:)];
    _gridView = [_gridView initWithFrame:gridFrame];
    
    
    _gridView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_gridView];
    
    // Set the initial values of the squares in the sudoku grid.
    for (int i = 0; i < 9; ++i){
        for (int j = 0; j < 9; ++j){
            [_gridView setValueAtRow:i andColumn:j to:initialGrid[i][j]];
        }
    }

    
}


- (void)buttonPressed:(id) sender
{
    UIButton* button = (UIButton*)sender;
    NSLog(@"Row: %d, Column: %d", button.tag % 10 + 1, button.tag / 10 + 1);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
