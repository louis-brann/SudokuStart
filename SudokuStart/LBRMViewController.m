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


@interface LBRMViewController (){
    LBRMGridView* _gridView;
}

@end

@implementation LBRMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Set up the grid frame, based on a specified percentage of the frame that
    //   the grid is supposed to take up
    CGRect frame = self.view.frame;
    CGFloat pctOfFrame = 0.80;
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);
    CGFloat x = 0.1 * width;
    CGFloat y = 0.1 * height;
    CGFloat size = MIN(width,height)*pctOfFrame;
 
    CGRect gridFrame = CGRectMake(x, y, size, size);
    
    // Create grid view
    _gridView = [[LBRMGridView alloc] initWithFrame:gridFrame];
    _gridView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_gridView];
    
    for (int i = 0; i < 9; ++i){
        for (int j = 0; j < 9; ++j){
            [_gridView setValueAtRow:i andColumn:j to:initialGrid[i][j]];
        }
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
