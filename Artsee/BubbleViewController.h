//
//  BubbleViewController.h
//  Captastic
//
//  Created by Optiplex790 on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define BBTYPE_SPEECH		0
#define BBTYPE_THOUGHT		1
#define BBTYPE_SCREAM		2
#define BBTYPE_TEXT         3
#define BBTYPE_IMAGE        4

@class ViewController;
@interface BubbleViewController : UIViewController<UIGestureRecognizerDelegate, UITextViewDelegate>
{
	BOOL						direction;
	BOOL						selected;
}

@property (nonatomic, strong) ViewController *editor;
@property (nonatomic, strong) UIImage *bubbleImg;

@property (nonatomic, assign) int type;
@property (nonatomic, assign) int subType;;
@property (nonatomic, weak) IBOutlet UIView* viewCnt;
@property (nonatomic, weak) IBOutlet UIButton* btnDelete;
@property (nonatomic, weak) IBOutlet UIButton* btnColor;
@property (nonatomic, weak) IBOutlet UIButton* btnControl;
@property (nonatomic, weak) IBOutlet UIButton* btnFlip;
@property (nonatomic, weak) IBOutlet UIImageView	*background;

- (void)setSelected:(BOOL)select;
- (void) setBubbleImg:(UIImage *)bubbleImg;
- (BubbleViewController *) initWithImage:(UIImage *)img andEditor:(ViewController *)editorViewController;
@end
