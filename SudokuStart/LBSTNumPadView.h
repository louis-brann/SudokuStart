//
//  LBSTNumPadView.h
//  SudokuStart
//
//  Created by Laptop 16 on 9/18/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage+LBSTColorImage.h"

@interface LBSTNumPadView : UIView

@property (assign, nonatomic) int currentNum;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end
