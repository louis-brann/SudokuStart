//
//  LBRMNumPadView.m
//  SudokuStart
//
//  Created by Melissa Galonsky on 9/20/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBRMNumPadView.h"

static double const widthRelativeToButtonSize = 10.0;
static double const widthRelativeToPadding = 100.0;

@implementation LBRMNumPadView
{
    NSMutableArray* _buttons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        
        // Add the buttons to the num pad
        _buttons = [[NSMutableArray alloc] initWithCapacity:9];
        CGFloat widthOfFrame = CGRectGetWidth(frame);
        CGFloat buttonSize = widthOfFrame / widthRelativeToButtonSize;
        CGFloat paddingWidth = widthOfFrame / widthRelativeToPadding;
        CGFloat xOffset = paddingWidth;
        for (int i = 0 ; i < 9; i++) {
            CGRect buttonFrame = CGRectMake(xOffset, 0, buttonSize, buttonSize);
            UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:[NSString stringWithFormat:@"%d", (i+1)] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttons insertObject:button atIndex:i];
            [self addSubview:button];
            xOffset += buttonSize + paddingWidth;
        }
    }
    return self;
}


@end
