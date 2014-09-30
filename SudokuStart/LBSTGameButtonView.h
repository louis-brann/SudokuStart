//
//  LBSTGameButtonView.h
//  SudokuStart
//
//  Created by Sarah Trisorus on 9/29/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol StartNewGame
- (void)startNewGame;
@end

@protocol RestartGame
- (void)restartGame;
@end

@interface LBSTGameButtonView : UIView

@property (assign, nonatomic) id <StartNewGame, RestartGame> delegate;

@property (strong, nonatomic) AVAudioPlayer *SFXPlayer;

@end
