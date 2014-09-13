//
//  LBRMGrid.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBRMGridView.h"


@implementation LBRMGridView {
    NSMutableArray* _buttons;
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
                
                button = [[UIButton alloc] initWithFrame:buttonFrame];
                button.backgroundColor = [UIColor whiteColor];
                [self addSubview: button];
                
                // create target for button
                [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                
                // Set up title and title color
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
                button.titleLabel.adjustsFontSizeToFitWidth = YES;
                
                button.tag = i*10+j;
                [[_buttons objectAtIndex:j] insertObject:button atIndex:i];
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

-(void)setValueAtRow:(int)row andColumn:(int)col to:(int)value
{
    UIButton* button = [[_buttons objectAtIndex:col] objectAtIndex:row];
    NSString* number = [NSString stringWithFormat:@"%d", value];
    if (![number isEqualToString:@"0"]){
        [button setTitle:number forState:UIControlStateNormal];
    }
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
