//
//  ViewController.h
//  Artsee
//
//  Created by Yurii.B on 6/16/14.
//  Copyright (c) 2014 YuriiBogdan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BubbleViewController;
@interface ViewController : UIViewController

@property (nonatomic, strong) BubbleViewController *selectedBubble;

// Bubble Control Functions
- (void)deselectAll;
- (void)deleteCurBubble;

@end
