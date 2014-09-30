//
//  LBRMViewController.h
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "LBRMGridView.h"
#import "LBSTGridModel.h"
#import "LBSTNumPadView.h"
#import "LBSTGameButtonView.h"
#import "LBSTTimerView.h"

@interface LBRMViewController : UIViewController <CellWasTapped, AlertWin, StartNewGame, RestartGame, UIAlertViewDelegate>

// SFX sounds acquired from FreeSound
// BGM acquired from Waterflame
@property (strong, nonatomic) AVAudioPlayer *SFXPlayer;
@property (strong, nonatomic) AVAudioPlayer *BGMPlayer;

@end
