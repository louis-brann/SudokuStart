//
//  LBRMViewController.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//


#import "LBRMViewController.h"

@interface LBRMViewController (){
  LBRMGridView *_gridView;
  LBSTNumPadView *_numPadView;
  LBSTGridModel *_gridModel;
  LBSTGameButtonView *_gameButtonView;
  LBSTTimerView *_timerView;
  
  BOOL _inPlay;
  
  AVAudioPlayer *_setValuePlayer;
  AVAudioPlayer *_winPlayer;
}

@end

@implementation LBRMViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSError *error;

  // Set up background game audio
  NSString *bgMusicPath =[[NSBundle mainBundle] pathForResource:@"jumper"
                                                         ofType:@"mp3"];
  AVAudioPlayer *bgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:
                           [NSURL fileURLWithPath:bgMusicPath] error:&error];
  
  bgPlayer.numberOfLoops = -1;
  bgPlayer.currentTime = 0;
  bgPlayer.volume = 1.0;
  
  [bgPlayer prepareToPlay];
  self.BGMPlayer = bgPlayer;
  [self.BGMPlayer play];
  
  // Set up button click audio
  NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"boom"
                                                       ofType:@"mp3"];
  NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
  _setValuePlayer = [[AVAudioPlayer alloc]
                                   initWithContentsOfURL:soundURL error:&error];
  [_setValuePlayer prepareToPlay];
  
  // Set up winning sound audio
  NSString *winPath =[[NSBundle mainBundle] pathForResource:@"win"
                                                       ofType:@"mp3"];
  NSURL *winURL = [NSURL fileURLWithPath:winPath];
  _winPlayer = [[AVAudioPlayer alloc]
                 initWithContentsOfURL:winURL error:&error];
  [_winPlayer prepareToPlay];
  
  
  // Initialize GridModel and initialize grid
  _gridModel = [[LBSTGridModel alloc] init];
  _gridModel.delegate = self;
  
  // Get frame and frame dimensions
  CGRect frame = self.view.frame;
  CGFloat frameWidth = CGRectGetWidth(frame);
  CGFloat frameHeight = CGRectGetHeight(frame);

  // Set up the grid frame, based on a specified percentage of the frame that
  // the grid is supposed to take up
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
  
  // Specify constants for rest of buttons
  CGFloat cellSize = gridSize / 10.0;
  CGFloat baseOffset = cellSize / (10.0 + 4.0);
  CGFloat marginBetweenViews = (0.15 * gridYOffset);

  // Create numPad frame
  CGFloat numPadWidth = gridSize;

  // Have space for 1 row of buttons, and a delete button 75% of the height of a
  // normal button, and 3 strips of padding
  CGFloat numPadHeight = (1.75 * cellSize) + (3 * baseOffset);
  CGFloat numPadYOffset = gridYOffset + CGRectGetHeight(gridFrame) +
    marginBetweenViews;
  CGRect  numPadFrame = CGRectMake(gridXOffset, numPadYOffset, numPadWidth,
                                   numPadHeight);
  
  // Create numPad view
  _numPadView = [[LBSTNumPadView alloc] initWithFrame:numPadFrame];
  _numPadView.backgroundColor = [UIColor blackColor];
  [self.view addSubview:_numPadView];
  
  // Set up timer
  // Create a frame for the timer that is 40% the height of the whitespace
  // between the top of the frame and the grid
  CGFloat timerWidth = (3 * cellSize) + (2 * (baseOffset));
  CGFloat timerHeight = 0.4 * gridYOffset;
  CGFloat timerXOffset = gridXOffset + (3 * cellSize) + (6 * baseOffset);
  CGFloat timerYOffset = gridYOffset - marginBetweenViews - timerHeight;
  CGRect  timerFrame = CGRectMake(timerXOffset, timerYOffset, timerWidth,
                                  timerHeight);
  
  // Create and style the timer
  _timerView = [[LBSTTimerView alloc] initWithFrame:timerFrame];
  UIColor *timerBackgroundColor = [UIColor colorWithPatternImage:
                                   [UIImage imageNamed:@"bluebg-normal.png"]];
  [_timerView setBackgroundColor:timerBackgroundColor];
  
  // Add the timer to the view
  [self.view addSubview:_timerView];
  
  // Set up gameButton view
  CGFloat gameButtonXOffset = gridXOffset;
  CGFloat gameButtonYOffset = numPadYOffset + numPadHeight +
    (0.15 * gridYOffset);
  CGFloat gameButtonHeight = cellSize + (2.0 * baseOffset);
  CGFloat gameButtonWidth = gridSize;
  CGRect  gameButtonFrame = CGRectMake(gameButtonXOffset, gameButtonYOffset,
                                       gameButtonWidth, gameButtonHeight);
  
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
  if (!_inPlay){
    return;
  }
  
  UIButton *button = (UIButton*)sender;
  int row = (int)button.tag / 10;
  int col = (int)button.tag % 10;
  
  if ([_gridModel isCellMutableAtRow:row andColumn:col]){
    // Check the current input for consistency
    int currentInput = [_numPadView currentNum];
    BOOL consistentInput = [_gridModel isValueConsistent:currentInput
                                                   atRow:row andColumn:col];
    
    // If it's consistent, set the value
    if (consistentInput){
      // Play a sound effect
      self.SFXPlayer = _setValuePlayer;
      [self.SFXPlayer play];
      
      [_gridModel setValue:currentInput atRow:row andColumn:col];
      [_gridView setValue:currentInput atRow:row andColumn:col];
    }
  }
}

- (void)restartGame
{
  if (!_inPlay){
    return;
  }
  
  UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Restart Game"
                        message:@"Are you sure you want to restart this game?"
                        delegate:self
                        cancelButtonTitle:@"NO!"
                        otherButtonTitles:@"Yes", nil];
  [alert show];
}

- (void)alertWin
{
  _inPlay = NO;
  
  self.SFXPlayer = _winPlayer;
  [self.SFXPlayer play];
  
  NSString *message = [NSString stringWithFormat:@"You finished in %@!",
                       [[_timerView timerLabel] text]];
  UIAlertView *winAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations!"
                                                     message:message
                                                    delegate:self
                                           cancelButtonTitle:@"Yeah!"
                                           otherButtonTitles: nil];
  [winAlert show];
}

- (void)startNewGame
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

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:
    (NSInteger)buttonIndex {
  
  // If the user clicked the second button (OK on ClearGrid, doesn't exist on
  // win alert), clear the value from every mutable cell in the grid
  if (buttonIndex == 1) {
    // Play a sound effect!
    [[_gameButtonView SFXPlayer] play];

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
