//
//  LBRMGrid.m
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//                      Sarah Trisorus
//

#import "LBRMGridView.h"
#import "UIImage+LBSTColorImage.h"


@implementation LBRMGridView {
    NSMutableArray *_buttons;
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
        UIButton *button;
        CGFloat IPAD_FONT_SIZE = 40;
        
        for (int row = 0; row < 9; ++row){
            
            // Set/reset yOffset for new column
            CGFloat yOffset = baseOffset;
            
            // Extra horizontal offset to separate 3x3 subgrids
            if (row % 3 == 0){
                xOffset += baseOffset;
            }
            
            for (int col = 0; col < 9; ++col){
                
                // Extra vertical offset to separate 3x3 subgrids
                if (col % 3 == 0){
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
                [button addTarget:self action:@selector(cellSelected:) forControlEvents:UIControlEventTouchUpInside];
                
                // Set up title
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:IPAD_FONT_SIZE];
                button.titleLabel.adjustsFontSizeToFitWidth = YES;
                
                // Set up highlighted background
                [button setBackgroundImage: [UIImage imageWithColor:
                                            [UIColor yellowColor]]
                                  forState: UIControlStateHighlighted];
                
                // Make the tag such that the first digit represents the
                // row, and the second represents the column
                button.tag = row*10+col;
                
                
                [[_buttons objectAtIndex:row] insertObject:button atIndex:col];
                
                // Update column offset
                yOffset += buttonSize+baseOffset;
            }
            
            // Update row offset
            xOffset += buttonSize + baseOffset;
        }

    }
    return self;
}

- (void)cellSelected:(id)sender
{
    // Send info to ViewController
    [self.delegate cellWasTapped:sender];
}

-(void)setValue:(int)value atRow:(int)row andColumn:(int)col
{
    CGFloat IPAD_FONT_SIZE = 40;
    
    UIButton *button = [[_buttons objectAtIndex:row] objectAtIndex:col];
    NSString *number = [NSString stringWithFormat:@"%d", value];
    if (![number isEqualToString:@"0"]){
        [button setTitle:number forState:UIControlStateNormal];
        
    } else {
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:IPAD_FONT_SIZE];
    }
    
}

@end
