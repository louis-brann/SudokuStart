//
//  LBRMGrid.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBRMGridView.h"

static double const gridSizeRelativeToButtonSize = 10.0;
static double const gridSizeRelativeToWidthOfSpacingLine = 14.0;

@implementation LBRMGridView {
    NSMutableArray* _buttons;
    SEL _buttonPressedAction;
    id _viewControllerId;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIButton* button;
        
        // Initialize array of buttons
        _buttons = [[NSMutableArray alloc] initWithCapacity:9];
        for (int i = 0; i < 9; ++i) {
            [_buttons addObject:[[NSMutableArray alloc] initWithCapacity:9]];
        }

        // The frame is a square so the width and height are interchangeable.
        CGFloat size = CGRectGetHeight(frame);
        
        // create buttons
        CGFloat buttonSize = size / gridSizeRelativeToButtonSize;
        CGFloat baseOffset = buttonSize / gridSizeRelativeToWidthOfSpacingLine;
        CGFloat xOffset = baseOffset;
        
        // Creates all 81 buttons in the grid.
        for (int i = 0; i < 9; ++i){
            
            CGFloat yOffset = baseOffset;
            
            // Extra padding is added every three squares so it's clear where the subgrids are.
            if (i % 3 == 0){
                xOffset += baseOffset;
            }
            
            for (int j = 0; j < 9; ++j){
                
                if (j % 3 == 0){
                    yOffset += baseOffset;
                }
                
                CGRect buttonFrame = CGRectMake(xOffset, yOffset, buttonSize, buttonSize);
                
                yOffset += buttonSize + baseOffset;
                
                button = [[UIButton alloc] initWithFrame:buttonFrame];
                button.backgroundColor = [UIColor whiteColor];
                [self addSubview: button];
                
                // create target for button
                NSLog(@"%@", _viewControllerId);
                [button addTarget:_viewControllerId action:_buttonPressedAction forControlEvents:UIControlEventTouchUpInside];
                
                // Set up title and title color
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.adjustsFontSizeToFitWidth = YES;
                
                // The tag encodes the row and column in one number by multiplying the
                // column by ten and adding the row.
                button.tag = i * 10 + j;
                [[_buttons objectAtIndex:i] insertObject:button atIndex:j];
            }
            
            xOffset += buttonSize + baseOffset;
        }

    }
    return self;
}

-(void)setValueAtRow:(int)row andColumn:(int)col to:(int)value isInitial:(BOOL)isInitial
{
    UIButton* button = [[_buttons objectAtIndex:col] objectAtIndex:row];
    NSString* number = [NSString stringWithFormat:@"%d", value];
    if (![number isEqualToString:@"0"]){
        [button setTitle:number forState:UIControlStateNormal];
    }
    
    if (!isInitial) {
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}

-(void)addTarget:(id)target action:(SEL) action
{
    _viewControllerId = target;
    _buttonPressedAction = action;
}

@end
