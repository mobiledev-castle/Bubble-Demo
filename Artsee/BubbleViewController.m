//
//  BubbleViewController.m
//  Captastic
//
//  Created by Optiplex790 on 8/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BubbleViewController.h"
#import "ViewController.h"

@interface BubbleViewController (){
    @private CGFloat imageAngle;
    @private CGFloat imageScale;
}

@end

@implementation BubbleViewController

- (BubbleViewController *) initWithImage:(UIImage *)img andEditor:(ViewController *)editorViewController
{
    self = [self initWithNibName:@"BubbleViewController" bundle:nil];
	
	self.editor = editorViewController;
	direction = YES;
	selected = NO;
    self.bubbleImg = img;
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) makeBubbleFrame:(CGRect)rect {
    
    CGRect frame = self.background.frame;
    self.view.frame = CGRectMake(frame.origin.x-5, frame.origin.y-5, frame.size.width+10, frame.size.height+10);
    [self.btnDelete setFrame:CGRectMake(0, 0, 20, 20)];
    [self.btnColor setFrame:CGRectMake(0, self.view.frame.size.height-20, 20, 15)];
    [self.btnControl setFrame:CGRectMake(self.view.frame.size.width-20, self.view.frame.size.height-20, 20, 20)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
    [self setupBubbleWithImage:self.bubbleImg];
    
    UITapGestureRecognizer *tapGestureBtnDel =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapDel:)];
	tapGestureBtnDel.delegate = self;
	tapGestureBtnDel.delaysTouchesBegan = YES;
	tapGestureBtnDel.numberOfTouchesRequired = 1;
	tapGestureBtnDel.numberOfTapsRequired = 1;
	[self.btnDelete addGestureRecognizer:tapGestureBtnDel];
    
    UITapGestureRecognizer *tapGestureBtnColor =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapColor:)];
	tapGestureBtnColor.delegate = self;
	tapGestureBtnColor.delaysTouchesBegan = YES;
	tapGestureBtnColor.numberOfTouchesRequired = 1;
	tapGestureBtnColor.numberOfTapsRequired = 1;
	[self.btnColor addGestureRecognizer:tapGestureBtnColor];
    
    UITapGestureRecognizer *tapGestureBtnFlip =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFlip:)];
	tapGestureBtnFlip.delegate = self;
	tapGestureBtnFlip.delaysTouchesBegan = YES;
	tapGestureBtnFlip.numberOfTouchesRequired = 1;
	tapGestureBtnFlip.numberOfTapsRequired = 1;
	[self.btnFlip addGestureRecognizer:tapGestureBtnFlip];
    
	UITapGestureRecognizer *tapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
	tapGesture.delegate = self;
	tapGesture.delaysTouchesBegan = YES;
	tapGesture.numberOfTouchesRequired = 1;
	tapGesture.numberOfTapsRequired = 1;
	[self.view addGestureRecognizer:tapGesture];
	
	UIRotationGestureRecognizer *rotationGesture =  [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
	rotationGesture.delegate = self;
	[self.view addGestureRecognizer:rotationGesture];

	
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleMove:)];
	[panRecognizer setMinimumNumberOfTouches:1];
	[panRecognizer setMaximumNumberOfTouches:1];
	[panRecognizer setDelegate:self];
	[self.view addGestureRecognizer:panRecognizer];
	[panRecognizer setDelaysTouchesBegan:YES];
    
    UIPanGestureRecognizer *panCtrlRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleControl:)];
	[panCtrlRecognizer setMinimumNumberOfTouches:1];
	[panCtrlRecognizer setMaximumNumberOfTouches:1];
	[panCtrlRecognizer setDelegate:self];
    [self.btnControl addGestureRecognizer:panCtrlRecognizer];
	[panCtrlRecognizer setDelaysTouchesBegan:YES];
	
	UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleScale:)];
	[pinchRecognizer setDelegate:self];
	[self.view addGestureRecognizer:pinchRecognizer];
}



- (void) setupBubbleWithImage:(UIImage *)img {
    
    self.background.hidden = NO;
    self.background.image = img;
    CGRect frame = self.view.frame;
    frame.origin.x = ((320 - frame.size.width) / 2.0);
    frame.origin.y += 5;
    frame.size.width = 100;
    float rate = img.size.height/img.size.width;
    frame.size.height = 100*rate;
    self.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width+30, frame.size.height+30);
    [self.background setFrame:CGRectMake(5, 5, frame.size.width, frame.size.height)];
    [self.btnDelete setFrame:CGRectMake(0, 0, 20, 20)];
    [self.btnColor setFrame:CGRectMake(0, self.view.frame.size.height-20, 20, 15)];
    [self.btnControl setFrame:CGRectMake(self.view.frame.size.width-20, self.view.frame.size.height-20, 20, 20)];
    [self.btnFlip setFrame:CGRectMake(self.view.frame.size.width-20, 0, 20, 20)];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+100, self.view.frame.size.width, self.view.frame.size.height);
	self.viewCnt.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)handleTapDel:(UITapGestureRecognizer *)recognizer 
{
//    [self.editor hideColorView];
    [self.editor deleteCurBubble];
}

- (void)handleTapColor:(UITapGestureRecognizer *)recognizer 
{
//    [self.editor openColor];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer 
{
	[self.editor deselectAll];
	[self setSelected:YES];
}

- (void)handleTapFlip:(UITapGestureRecognizer *)recognizer 
{
	[self handleTap:nil];
    static int count = 0;
    if (++count % 2 == 1) 
        self.background.transform = CGAffineTransformMake(-1, 0, 0, 1, 0, 0);
    else {
        self.background.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    }
}

- (void)handleMove:(UIPanGestureRecognizer *)recognizer 
{
//    if (self.editor.nIsLocked == 1)
//        return;
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		if (!selected) {
			[self handleTap:nil];
		}
	}
	
	CGPoint translation = [recognizer translationInView:self.editor.view];
//    if (recognizer.view.frame.origin.y > 0 && recognizer.view.frame.origin.y < (460-recognizer.view.frame.size.height)) {
    NSLog(@"transition=(%f, %f), recognizer=(%f, %f)", translation.x, translation.y, recognizer.view.center.x, recognizer.view.center.y);
    self.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.editor.view];
//    }
}

- (void)handleScale:(UIPinchGestureRecognizer *)recognizer 
{	
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		if (!selected) {
			[self handleTap:nil];
		}
	}
	
	self.view.transform = CGAffineTransformScale(self.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}


- (void)handleRotate:(UIRotationGestureRecognizer *)recognizer 
{
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		if (!selected) {
			[self handleTap:nil];
		}
	}
	
	self.view.transform = CGAffineTransformRotate(self.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

CGFloat distanceBetweenPoints(CGPoint point1, CGPoint point2)
{
    CGFloat dx = point1.x - point2.x;
    CGFloat dy = point1.y - point2.y;
    return sqrt(dx*dx + dy*dy);
}

CGFloat angleBetweenLinesInDegrees(CGPoint beginLineA,
                                   CGPoint endLineA,
                                   CGPoint beginLineB,
                                   CGPoint endLineB)
{
    CGFloat a = endLineA.x - beginLineA.x;
    CGFloat b = endLineA.y - beginLineA.y;
    CGFloat c = endLineB.x - beginLineB.x;
    CGFloat d = endLineB.y - beginLineB.y;
    
    CGFloat atanA = atan2(a, b);
    CGFloat atanB = atan2(c, d);
    
    // convert radiants to degrees
    return (atanA - atanB) * 180 / M_PI;
}


- (void)handleControl:(UIPanGestureRecognizer *)recognizer 
{
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		if (!selected) {
			[self handleTap:nil];
		}
	}
    CGPoint location = [recognizer locationInView:self.editor.view];
    float midX = self.view.frame.origin.x + self.view.frame.size.width/2;
    float midY = self.view.frame.origin.y + self.view.frame.size.height/2;
    static float prevX =  0;
    static float prevY =  0;
    
    if ([recognizer state] == UIGestureRecognizerStateBegan ) {
        NSLog(@"imageAngle = %f", imageAngle);
        prevX = [recognizer locationInView:self.editor.view].x;
        prevY = [recognizer locationInView:self.editor.view].y;
    }  else if ([recognizer state] ==UIGestureRecognizerStateEnded ) {
        NSLog(@"CGRECT(%f, %f, %f, %f)", self.background.frame.origin.x, self.background.frame.origin.y, self.background.frame.size.width, self.background.frame.size.height);
        return;
    }
    
    CGFloat angle = angleBetweenLinesInDegrees(CGPointMake(midX, midY), CGPointMake(prevX, prevY), CGPointMake(midX, midY), location);
    if (angle > 180)
    {
        angle -= 360;
    }
    else if (angle < -180)
    {
        angle += 360;
    }
    static float counter = 1;
    if (counter>10)
        counter = 1;
    CGFloat distPrev = distanceBetweenPoints(CGPointMake(prevX, prevY), CGPointMake(midX, midY));
    CGFloat distCur = distanceBetweenPoints(location, CGPointMake(midX, midY));    
    if (distCur > distPrev)
        counter = counter + 0.035;
    else {
        counter = counter - 0.035;
    }
    imageAngle += angle;
    if (imageAngle > 360)
        imageAngle -= 360;
    else if (imageAngle < -360)
        imageAngle += 360;
    
    
    NSLog(@"prev=(%f, %f), mid=(%f, %f), cur=(%f, %f), angle=%f, dist=%f", prevX, prevY, midX, midY, location.x, location.y, imageAngle, distPrev);
    
	CGAffineTransform transform = CGAffineTransformMakeRotation(imageAngle *  M_PI / 180);
    CGAffineTransform scale = CGAffineTransformScale(CGAffineTransformIdentity, 1*counter, 1*counter);
    self.view.transform = CGAffineTransformConcat(transform, scale);
    
    prevX = location.x;
    prevY = location.y;
}

- (void)textViewDidChange:(UITextView *)textView {

    [textView setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.contentSize.width, textView.contentSize.height)];
    [self.viewCnt setFrame:CGRectMake(textView.frame.origin.x+10, textView.frame.origin.y+10, textView.frame.size.width, textView.frame.size.height)];
    [self.view setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width+20, textView.frame.size.height+20)];
    [self.btnDelete setFrame:CGRectMake(0, 0, 20, 20)];
    [self.btnColor setFrame:CGRectMake(0, textView.frame.size.height, 20, 20)];
    [self.btnControl setFrame:CGRectMake(textView.frame.size.width, textView.frame.size.height, 20, 20)];
    [self.btnFlip setFrame:CGRectMake(textView.frame.size.width, 0, 20, 20)];
}

- (IBAction) onClickDelete:(id)sender {

    NSLog(@"onClicked");
}

- (void)setSelected:(BOOL)select
{
	selected = select;
	if (selected) {
        self.btnDelete.hidden = NO;
//        self.btnColor.hidden = NO;
        self.btnControl.hidden = NO;
        self.btnFlip.hidden = NO;
		self.viewCnt.layer.borderWidth = 1.0;
		self.editor.selectedBubble  = self;
//		[self.editor.bubbleScene bringSubviewToFront:self.view];
	} else {
        self.btnDelete.hidden = YES;
//        self.btnColor.hidden = YES;
        self.btnControl.hidden = YES;
        self.btnFlip.hidden = YES;
		self.viewCnt.layer.borderWidth = 0;
	}
}

@end
