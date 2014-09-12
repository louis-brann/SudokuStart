//
//  LBRMGrid.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

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

@implementation LBRMGridView {
    UIButton* _button;
    NSMutableArray* _buttons = [[NSMutableArray alloc] initWithCapacity:9];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGFloat size = MIN(frame.size.height, frame.size.width);
        
        // create buttons
        CGFloat buttonSize = size/10.0;
        CGFloat baseOffset = buttonSize/14.0;
        CGFloat xOffset = baseOffset;
        
        for (int i = 0; i < 9; ++i){
            
            CGFloat yOffset = baseOffset;
            
            if (i % 3 == 0){
                xOffset += baseOffset;
            }
            
            for (int j = 0; j < 9; ++j){
                
                if (j % 3 == 0){
                    yOffset += baseOffset;
                }
                
                CGRect buttonFrame =
                CGRectMake(xOffset,
                           yOffset,
                           buttonSize,
                           buttonSize);
                
                yOffset += buttonSize+baseOffset;
                
                _button = [[UIButton alloc] initWithFrame:buttonFrame];
                _button.backgroundColor = [UIColor whiteColor];
                [self addSubview:_button];
                
                // create target for button
                [_button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                
                // Set up title and title color
                NSString* number = [NSString stringWithFormat:@"%d",initialGrid[i][j]];
                if (![number isEqualToString:@"0"]){
                    [_button setTitle:number forState:UIControlStateNormal];
                }
                [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_button setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
                _button.titleLabel.adjustsFontSizeToFitWidth = YES;
                
                _button.tag = i*10+j;
            }
            
            xOffset += buttonSize + baseOffset;
        }

    }
    return self;
}

- (void)buttonPressed:(id)sender
{
    UIButton* button = (UIButton*)sender;
    NSLog(@"Row: %d, Column: %d", button.tag%10+1, button.tag/10+1);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
