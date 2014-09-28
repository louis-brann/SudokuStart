//
//  LBRMViewController.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//


#import "LBRMViewController.h"
#import "LBRMGridView.h"
#import "LBSTGridModel.h"
#import "LBSTNumPadView.h"
#import "LBSTTimerView.h"


@interface LBRMViewController (){
  LBRMGridView *_gridView;
  LBSTNumPadView *_numPadView;
  LBSTGridModel *_gridModel;
  LBSTTimerView *_timerView;
  
  BOOL _inPlay;
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
  CGFloat gridSize = MIN(frameWidth, frameHeight) * gridPctOfFrame;
  CGRect gridFrame = CGRectMake(gridXOffset, gridYOffset, gridSize, gridSize);
  
  // Create grid view
  _gridView = [[LBRMGridView alloc] initWithFrame:gridFrame];
  _gridView.delegate = self;
  _gridView.backgroundColor = [UIColor blackColor];
  [self.view addSubview:_gridView];
  
  // Initialize GridModel and initialize grid
  _gridModel = [[LBSTGridModel alloc] init];
  _gridModel.delegate = self;

  // Create numPad frame
  CGFloat numPadWidth = gridSize;

  // Have space for 2 rows of buttons, and 3 strips of padding
  CGFloat numPadHeight = (gridSize/10.0) * (2 + 0.3);
  CGFloat numPadYOffset = (1.25 * gridYOffset) + CGRectGetHeight(gridFrame);
  CGRect numPadFrame = CGRectMake(gridXOffset, numPadYOffset, numPadWidth, numPadHeight);
  
  // Create numPad view
  _numPadView = [[LBSTNumPadView alloc] initWithFrame:numPadFrame];
  _numPadView.backgroundColor = [UIColor blackColor];
  [self.view addSubview:_numPadView];

  // New game button frame
  CGFloat cellSize = gridSize/(9.0 + 1.0);
  CGFloat newGameButtonBorder = cellSize/10.0;
  CGFloat newGameButtonWidth = (3 * cellSize) + (4 * newGameButtonBorder);
  CGFloat newGameButtonHeight = cellSize + (2 * newGameButtonBorder);
  CGFloat newGameButtonXOffset = gridXOffset + cellSize + newGameButtonBorder;
  CGFloat newGameButtonYOffset = (0.25 * gridYOffset) + numPadYOffset + numPadHeight;
  CGRect  newGameFrame = CGRectMake(newGameButtonXOffset,
                                    newGameButtonYOffset,
                                    newGameButtonWidth,
                                    newGameButtonHeight);

  // Make new game button
  UIButton *newGameButton = [[UIButton alloc] initWithFrame:newGameFrame];
  
  [self.view addSubview:newGameButton];
  
  // Style the button
  CGFloat newGameButtonFontSize = 24;
  [newGameButton setTitle:@"Start New Game" forState:UIControlStateNormal];
  newGameButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:newGameButtonFontSize];
  newGameButton.titleLabel.textColor = [UIColor whiteColor];
  newGameButton.titleLabel.textAlignment = NSTextAlignmentCenter;

  UIImage *newGameButtonNormalImage = [UIImage imageNamed:@"bluebg-normal.png"];
  UIImage *newGameButtonHighlightImage = [UIImage imageNamed:@"bluebg-highlight.png"];
  [newGameButton setBackgroundImage:newGameButtonNormalImage forState:UIControlStateNormal];
  [newGameButton setBackgroundImage:newGameButtonHighlightImage forState:UIControlStateHighlighted];

  [newGameButton addTarget:self action:@selector(startNewGame)forControlEvents:UIControlEventTouchUpInside];
  
  // Set up timer
  CGFloat timerWidth = newGameButtonWidth;
  CGFloat timerHeight = newGameButtonHeight;
  CGFloat timerXOffset = frameWidth - (newGameButtonXOffset + newGameButtonWidth);
  CGFloat timerYOffset = newGameButtonYOffset;
  CGRect  timerFrame = CGRectMake(timerXOffset, timerYOffset, timerWidth, timerHeight);
  
  _timerView = [[LBSTTimerView alloc] initWithFrame:timerFrame];
  UIColor *timerBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluebg-normal.png"]];
  [_timerView setBackgroundColor:timerBackgroundColor];
  [self.view addSubview:_timerView];
  
  [self startNewGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cellWasTapped:(id)sender
{
  if (_inPlay){
    
    UIButton *button = (UIButton*)sender;
    int row = (int)button.tag / 10;
    int col = (int)button.tag % 10;
    
    if ([_gridModel isCellMutableAtRow:row andColumn:col]){
      // Check the current input for consistency
      int currentInput = [_numPadView currentNum];
      BOOL consistentInput = [_gridModel isValueConsistent:currentInput atRow:row andColumn:col];
      
      // If it's consistent, set the value
      if (consistentInput){
        [_gridModel setValue:currentInput atRow:row andColumn:col];
        [_gridView setValue:currentInput atRow:row andColumn:col];
      }
    }
  }
}

- (void)alertWin
{
  _inPlay = NO;
  NSString *message = [NSString stringWithFormat:@"You finished in %@!", [[_timerView timerLabel] text]];
  UIAlertView *winAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"Yeah!"
                                           otherButtonTitles: nil];
  [winAlert show];
}

-(void)startNewGame
{
  [_gridModel clearGrid];
  [_gridModel initializeGrid];
  
  // For every button, find the initial value from gridModel and set it in the
  // gridView
  for (int row = 0; row < 9; ++row){
    for (int col = 0; col < 9; ++col){
      int numberToSet = [_gridModel getValueAtRow:row andColumn:col];
      [_gridView setInitialValue:numberToSet atRow:row andColumn:col];
    }
  }
  
  _inPlay = YES;
  [_timerView startTimer];
}

@end
