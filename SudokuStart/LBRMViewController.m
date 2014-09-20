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



static double const padding = .1;
static int const sizeRelativeToPadding = 8;

@interface LBRMViewController (){
    LBRMGridView* _gridView;
    LBRMGridModel* _gridModel;
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
