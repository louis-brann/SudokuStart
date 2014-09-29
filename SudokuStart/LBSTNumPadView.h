//
//  LBSTNumPadView.h
//  SudokuStart
//
//  Created by Laptop 16 on 9/18/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ClearCellValues
- (void)clearCellValues;
@end

@interface LBSTNumPadView : UIView

@property (nonatomic, assign) id <ClearCellValues> delegate;

@property (nonatomic) int currentNum;
@property (nonatomic) AVAudioPlayer *audioPlayer;

@end
