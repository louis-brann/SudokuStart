//
//  LBRMViewController.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBRMViewController.h"
#import "LBRMGridView.h"
#import "LBSTNumPadView.h"

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


@interface LBRMViewController (){
    LBRMGridView* _gridView;
    LBSTNumPadView* _numPadView;
}

@end

@implementation LBRMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Get frame and frame dimensions
    CGRect frame = self.view.frame;
    CGFloat frameWidth = CGRectGetWidth(frame);
    CGFloat frameHeight = CGRectGetHeight(frame);
    
    // Set up the grid frame, based on a specified percentage of the frame that
    //   the grid is supposed to take up
    CGFloat gridPctOfFrame = 0.80;
    CGFloat gridXOffset = 0.1 * frameWidth;
    CGFloat gridYOffset = 0.1 * frameHeight;
    CGFloat gridSize = MIN(frameWidth,frameHeight)*gridPctOfFrame;
    CGRect gridFrame = CGRectMake(gridXOffset, gridYOffset, gridSize, gridSize);
    
    // Create grid view
    _gridView = [[LBRMGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_gridView];
    
    for (int i = 0; i < 9; ++i){
        for (int j = 0; j < 9; ++j){
            [_gridView setValueAtRow:i andColumn:j to:initialGrid[i][j]];
        }
    }
    
    // Create numPad frame
    CGFloat numPadWidth = gridSize;
    CGFloat numPadHeight = gridSize/10.0;
    CGFloat numPadYOffset = 2.0*gridYOffset + gridFrame.size.height;
    CGRect numPadFrame = CGRectMake(gridXOffset, numPadYOffset, numPadWidth, numPadHeight);
    
    // Create numPad view
    _numPadView = [[LBSTNumPadView alloc] initWithFrame:numPadFrame];
    _numPadView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_numPadView];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
