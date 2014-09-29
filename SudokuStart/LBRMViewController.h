//
//  LBRMViewController.h
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBRMGridView.h"
#import "LBSTGridModel.h"
#import "LBSTNumPadView.h"

@interface LBRMViewController : UIViewController <CellWasTapped, AlertWin, ClearCellValues, UIAlertViewDelegate>

@property (nonatomic) AVAudioPlayer *audioPlayer;

@end
