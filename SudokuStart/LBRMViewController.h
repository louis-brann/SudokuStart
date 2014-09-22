//
//  LBRMViewController.h
//  SudokuStart
//
//  Created by Laptop 16 on 9/11/14.
//  Copyright (c) 2014 Louis Brann, Rachel Macfarlane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBRMViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton* checkSolutionButton;
@property (weak, nonatomic) IBOutlet UILabel* hasWonLabel;

- (IBAction)checkSolutionButtonPressed:(id)sender;

@end
