//
//  LBRMViewController.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//


#import "LBRMViewController.h"
//#import "LBRMGridView.h"
//#import "LBSTGridModel.h"
//#import "LBSTNumPadView.h"
//#import "LBSTGameButtonView.h"
//#import "LBSTTimerView.h"


@interface LBRMViewController (){
  LBRMGridView *_gridView;
  LBSTNumPadView *_numPadView;
  LBSTGridModel *_gridModel;
  LBSTGameButtonView *_gameButtonView;
  LBSTTimerView *_timerView;
  
  BOOL _inPlay;
}

@end

@implementation LBRMViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Set up button click audio
  NSError *error;
  NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"boom" ofType:@"mp3"];
  NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
  AVAudioPlayer *setValuePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
  [setValuePlayer prepareToPlay];
  
  self.audioPlayer = setValuePlayer;
  
  // Initialize GridModel and initialize grid
  _gridModel = [[LBSTGridModel alloc] init];
  _gridModel.delegate = self;
  
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

  // Create numPad frame
  CGFloat numPadWidth = gridSize;

  // Have space for 1 row of buttons, and a delete button 75% of the height of a
  //   normal button, and 3 strips of padding
  CGFloat numPadHeight = (gridSize/10.0) * (1.75 + 0.3);
  CGFloat numPadYOffset = (1.15 * gridYOffset) + CGRectGetHeight(gridFrame);
  CGRect numPadFrame = CGRectMake(gridXOffset, numPadYOffset, numPadWidth, numPadHeight);
  
  // Create numPad view
  _numPadView = [[LBSTNumPadView alloc] initWithFrame:numPadFrame];
  _numPadView.backgroundColor = [UIColor blackColor];
  [self.view addSubview:_numPadView];
  
  CGFloat cellSize = gridSize / 10.0;
  CGFloat baseOffset = cellSize / (10.0 + 4.0);
  
  // Set up timer
  CGFloat timerWidth = (3 * cellSize) + (2 * (baseOffset));
  CGFloat timerHeight = 0.04 * frameHeight;
  CGFloat timerXOffset = gridXOffset + (3 * cellSize) + (6 * baseOffset);
  CGFloat timerYOffset = 0.05 * frameHeight;
  CGRect  timerFrame = CGRectMake(timerXOffset, timerYOffset, timerWidth, timerHeight);
  
  _timerView = [[LBSTTimerView alloc] initWithFrame:timerFrame];
  UIColor *timerBackgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluebg-normal.png"]];
  [_timerView setBackgroundColor:timerBackgroundColor];
  [self.view addSubview:_timerView];
  
  // Set up gameButton view
  CGFloat gameButtonXOffset = gridXOffset;
  CGFloat gameButtonYOffset = numPadYOffset + numPadHeight + (0.15 * gridYOffset);
  CGFloat gameButtonHeight = cellSize + (2.0 * baseOffset);
  CGFloat gameButtonWidth = gridSize;
  CGRect  gameButtonFrame = CGRectMake(gameButtonXOffset, gameButtonYOffset, gameButtonWidth, gameButtonHeight);
  
  // Create gameButton view
  _gameButtonView = [[LBSTGameButtonView alloc] initWithFrame:gameButtonFrame];
  _gameButtonView.delegate = self;
  [self.view addSubview:_gameButtonView];
  
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
        // Play a sound effect
        [self.audioPlayer play];
        [_gridModel setValue:currentInput atRow:row andColumn:col];
        [_gridView setValue:currentInput atRow:row andColumn:col];
      }
    }
  }
}

- (void)restartGame
{
  if (_inPlay){
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Restart Game"
                                                    message:@"Are you sure you want to restart this game?"
                                                   delegate:self
                                          cancelButtonTitle:@"NO!"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
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

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  
  // If the user clicked the second button (OK on ClearGrid, doesn't exist on
  //    win alert), clear the value from every mutable cell in the grid
  if (buttonIndex == 1) {
    // Play a sound effect!
    [[_gameButtonView audioPlayer] play];

    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if ([_gridModel isCellMutableAtRow:row andColumn:col]) {
          [_gridModel setValue:0 atRow:row andColumn:col];
          [_gridView setValue:0 atRow:row andColumn:col];
        }
      }
    }
  }
}

@end
