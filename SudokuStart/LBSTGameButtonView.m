//
//  LBSTGameButtonView.m
//  SudokuStart
//
//  Created by Sarah Trisorus on 9/29/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBSTGameButtonView.h"

@implementation LBSTGameButtonView {
  AVAudioPlayer *newGamePlayer;
  AVAudioPlayer *cheerPlayer;
}

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  
  if(self)
  {
    // Set up button click audio
    NSError *error;
    NSString *soundPath =[[NSBundle mainBundle] pathForResource:@"scribble" ofType:@"mp3"];
    NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    newGamePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
    [newGamePlayer prepareToPlay];
    
    // Set up cheerleader button audio
    NSString *soundPathCheer =[[NSBundle mainBundle] pathForResource:@"yay" ofType:@"mp3"];
    NSURL *soundURLCheer = [NSURL fileURLWithPath:soundPathCheer];
    cheerPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURLCheer error:&error];
    [cheerPlayer prepareToPlay];
    
    // Set up the button sizes
    CGFloat cellSize = frame.size.width / 10.0;
    CGFloat baseOffset = cellSize / 10.0;
    
    CGFloat buttonWidth = (3 * cellSize) + (2 * baseOffset);
    CGFloat buttonHeight = cellSize + (2 * baseOffset);
    CGFloat buttonYOffset = 0;
    CGFloat buttonXOffset = 0;
    
    for (int i = 0; i < 3; ++i) {
      // Create the button and add it to the subview
      CGRect buttonFrame = CGRectMake(buttonXOffset, buttonYOffset, buttonWidth, buttonHeight);
      UIButton *gameButton = [[UIButton alloc] initWithFrame:buttonFrame];
      [self addSubview:gameButton];
      
      // Style the button
      CGFloat newGameButtonFontSize = 24;
      gameButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:newGameButtonFontSize];
      gameButton.titleLabel.textColor = [UIColor whiteColor];
      gameButton.titleLabel.textAlignment = NSTextAlignmentCenter;
      
      UIImage *gameButtonNormalImage = [UIImage imageNamed:@"bluebg-normal.png"];
      UIImage *gameButtonHighlightImage = [UIImage imageNamed:@"bluebg-highlight.png"];
      [gameButton setBackgroundImage:gameButtonNormalImage forState:UIControlStateNormal];
      [gameButton setBackgroundImage:gameButtonHighlightImage forState:UIControlStateHighlighted];
      
      // Customize title and target-action depending on which button it is
      switch (i) {
        case 0:
          [gameButton setTitle:@"Start New Game" forState:UIControlStateNormal];
          [gameButton addTarget:self action:@selector(startNewGamePressed)forControlEvents:UIControlEventTouchUpInside];
          break;
        case 1:
          [gameButton setTitle:@"Restart Game" forState:UIControlStateNormal];
          [gameButton addTarget:self action:@selector(restartGamePressed)forControlEvents:UIControlEventTouchUpInside];
          break;
        case 2:
          [gameButton setTitle:@"This is hard!" forState:UIControlStateNormal];
          [gameButton addTarget:self action:@selector(encouragePlayer)forControlEvents:UIControlEventTouchUpInside];
          break;
        default:
          break;
      }
      
      // Update the x-offset for the next button
      buttonXOffset += buttonWidth + (2 * baseOffset);
    }
  }
  
  return self;
}

- (void)startNewGamePressed
{
  // Play a sound effect!
  self.audioPlayer = newGamePlayer;
  [self.audioPlayer play];
  
  // Delegate to ViewController
  [self.delegate startNewGame];
}

- (void)restartGamePressed
{
  // Delegate to ViewController
  self.audioPlayer = newGamePlayer;
  [self.delegate restartGame];
}

- (void)encouragePlayer
{
  int numPhrases = 10;

  NSMutableArray *cheerleadingPhrases = [NSMutableArray arrayWithObjects:@"You can do it!",
                                                                         @"You've got this!",
                                                                         @"You're almost there!",
                                                                         @"Ooh! Put that number in that cell!",
                                                                         @"Keep going!",
                                                                         @"If you got through core, you can do this!",
                                                                         @"RAH RAH RAH! /waves pompoms",
                                                                         @"~*~*~*~\\o/~*~*~*~",
                                                                         @"^~~~~~~^",
                                                                         @"<(^v^<) <(^v^)> (>^v^)>",
                                                                         nil];
  
  int randomPhraseNum = arc4random_uniform(numPhrases);
  NSString *cheerleadingMessage = [cheerleadingPhrases objectAtIndex:randomPhraseNum];
  
  // Play a sound effect!
  self.audioPlayer = cheerPlayer;
  [self.audioPlayer play];
  
  UIAlertView *cheerleaderAlert = [[UIAlertView alloc] initWithTitle:@"GO GO GO GO!"
                                                             message:cheerleadingMessage
                                                            delegate:self
                                                   cancelButtonTitle:@"YEAH!"
                                                   otherButtonTitles: nil];
  [cheerleaderAlert show];
}

@end
