//
//  LBRMGrid.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import "LBRMGridView.h"
#import "UIImage+LBSTColorImage.h"


@implementation LBRMGridView {
    NSMutableArray* _buttons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // Initialize array of buttons for 9x9 sudoku
        _buttons = [[NSMutableArray alloc] initWithCapacity:9];
        for (int i = 0; i < 9; ++i) {
            [_buttons addObject:[[NSMutableArray alloc] initWithCapacity:9]];
        }

        // Setup button size and offset
        CGFloat frameSize = MIN(frame.size.height, frame.size.width);
        
        // 9 buttons, plus 1 buttonSize reserved for borders
        CGFloat buttonSize = frameSize/(9.0 + 1.0);
        
        // 10 Borders for 9 columns, + 4 to further separate subgrids
        CGFloat baseOffset = buttonSize/(10.0 + 4.0);
        
        CGFloat xOffset = baseOffset;
        UIButton* button;
        CGFloat IPAD_FONT_SIZE = 40;
        
        for (int i = 0; i < 9; ++i){
            
            // Set/reset yOffset for new column
            CGFloat yOffset = baseOffset;
            
            // Extra horizontal offset to separate 3x3 subgrids
            if (i % 3 == 0){
                xOffset += baseOffset;
            }
            
            for (int j = 0; j < 9; ++j){
                
                // Extra vertical offset to separate 3x3 subgrids
                if (j % 3 == 0){
                    yOffset += baseOffset;
                }
                
                // Setup frame and button
                CGRect buttonFrame = CGRectMake(xOffset,
                                                yOffset,
                                                buttonSize,
                                                buttonSize);
                button = [[UIButton alloc] initWithFrame:buttonFrame];
                button.backgroundColor = [UIColor whiteColor];
                [self addSubview: button];
                
                // Create target for button
                [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                
                // Set up title
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:IPAD_FONT_SIZE];
                button.titleLabel.adjustsFontSizeToFitWidth = YES;
                
                // Set up highlighted background
                [button setBackgroundImage: [UIImage imageWithColor:
                                            [UIColor yellowColor]]
                                  forState: UIControlStateHighlighted];
                
                // Make the tag such that the first digit represents the
                // row, and the second represents the column
                button.tag = i*10+j;
                
                
                [[_buttons objectAtIndex:j] insertObject:button atIndex:i];
                
                // Update column offset
                yOffset += buttonSize+baseOffset;
            }
            
            // Update row offset
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


@end
