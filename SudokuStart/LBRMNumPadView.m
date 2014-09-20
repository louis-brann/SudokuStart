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
    UIButton* _selectedButton;
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
            CGRect buttonFrame = CGRectMake(xOffset, paddingWidth, buttonSize, buttonSize);
            UIButton* button = [[UIButton alloc] initWithFrame:buttonFrame];
            
            button.backgroundColor = [UIColor whiteColor];
            [button setTitle:[NSString stringWithFormat:@"%d", (i+1)] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [_buttons insertObject:button atIndex:i];
            
            [self addSubview:button];
            
            xOffset += buttonSize + paddingWidth;
        }
    }
    return self;
}

-(void)addTarget:(id)target Action:(SEL)action
{
    for (int i = 0; i < 9; ++i){
        UIButton* button = [_buttons objectAtIndex:i];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)buttonPressed:(id) sender
{
    UIButton* button = (UIButton*) sender;
    [self changeSelectedButtonToButtonAtIndex: [button.titleLabel.text integerValue]];
}

-(void)changeSelectedButtonToButtonAtIndex:(int)value
{
    _selectedButton.backgroundColor = [UIColor whiteColor];
    _selectedButton = [_buttons objectAtIndex:(value - 1)];
    _selectedButton.backgroundColor = [UIColor yellowColor];
}


@end
