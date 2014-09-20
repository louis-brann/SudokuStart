//
//  LBRMViewController.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBRMViewController.h"
#import "LBRMGridView.h"
#import "LBRMGridModel.h"
#import "LBRMNumPadView.h"



static double const padding = .1;
static int const sizeRelativeToPadding = 8;
static double const heightOfNumPadRelativeToGridSize = 0.12;

@interface LBRMViewController (){
    LBRMGridView* _gridView;
    LBRMNumPadView* _numPadView;
    LBRMGridModel* _gridModel;
    UIButton* _selectedCell;
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
    
    // create the num pad view.  x will be the same, y will be below the bottom
    // of grid frame, the width will be the same and the height be will be  TODO
    CGFloat numPadY = y + size + size * padding;
    CGFloat numPadHeight = size * heightOfNumPadRelativeToGridSize;
    
    CGRect numPadFrame = CGRectMake(x, numPadY, size, numPadHeight);
    
    _numPadView = [[LBRMNumPadView alloc] initWithFrame:numPadFrame];
    [_numPadView addTarget:self Action:@selector(numPadButtonPressed:)];
    [self.view addSubview:_numPadView];
    
    
    
    _gridView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_gridView];
    
    // Initialize grid model
    _gridModel = [[LBRMGridModel alloc] init];
    
    // Set the initial values of the squares in the sudoku grid.
    for (int i = 0; i < 9; ++i){
        for (int j = 0; j < 9; ++j){
            int nextValue = [_gridModel getValueAtRow:i Column:j];
            [_gridView setValueAtRow:i andColumn:j to:nextValue];
        }
    }

    
}


// Tells the model the cell that the user wants to change and what they want to
// change the value to.  If the model says yes, it tells the grid view to change
// the cell to the specified number.
- (void)numPadButtonPressed:(id) sender
{
    NSLog(@"I'm being called");
    int row = _selectedCell.tag % 10;
    int column = _selectedCell.tag / 10;
    UIButton* numPadButton = (UIButton*)sender;
    int value = [numPadButton.titleLabel.text integerValue];
    if ([_gridModel updateValueAtRow:row Column:column withNewValue:value]) {
        [_gridView setValueAtRow:row andColumn:column to:value];
    }
}

- (void)buttonPressed:(id) sender
{
    _selectedCell.backgroundColor = [UIColor whiteColor];
    UIButton* button = (UIButton*)sender;
    _selectedCell = button;
    _selectedCell.backgroundColor = [UIColor yellowColor];
    NSLog(@"Row: %d, Column: %d", button.tag % 10 + 1, button.tag / 10 + 1);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
