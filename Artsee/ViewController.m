//
//  ViewController.m
//  Artsee
//
//  Created by Yurii.B on 6/16/14.
//  Copyright (c) 2014 YuriiBogdan. All rights reserved.
//

#import "ViewController.h"

#import "SHStripeMenuExecuter.h"
#import "SHStripeMenuActionDelegate.h"

#import "CategoryViewController.h"
#import "BubbleViewController.h"

@interface ViewController () <SHStripeMenuActionDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) SHStripeMenuExecuter * executer;
@property (nonatomic, strong) CategoryViewController *categoryVC;
@property (weak, nonatomic) IBOutlet UIView *categoryContainer;
@property (nonatomic, strong) NSMutableArray *bubbleArray;
@property (weak, nonatomic) IBOutlet UIView *bubbleSceneView;
@property (weak, nonatomic) IBOutlet UIImageView *bacgroundImgview;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UITapGestureRecognizer *tapGesture =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
	tapGesture.delegate = self;
	tapGesture.delaysTouchesBegan = YES;
	tapGesture.numberOfTouchesRequired = 1;
	tapGesture.numberOfTapsRequired = 1;
	[self.bubbleSceneView addGestureRecognizer:tapGesture];
    
    if (_executer == nil)
		_executer = [[SHStripeMenuExecuter alloc] init];
	[_executer setupToParentView:self];
    self.categoryContainer.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(onImageSelected:)
												 name:@"ImageSelectNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(onCloseContainer:)
												 name:@"ContainerCloseNotification" object:nil];
    self.bubbleArray = [[NSMutableArray alloc] init];
}

- (void) handleTap:(NSNotification *)noti {

    [self deselectAll];
}

#pragma mark - Bubble Control Functions
/////////////////////////////////////////////////

- (void)deselectAll
{
	for (BubbleViewController *bubble in self.bubbleArray) {
		[bubble setSelected:NO];
	}
	self.selectedBubble = nil;
}


- (void) deleteCurBubble {
    
    [self.selectedBubble.view removeFromSuperview];
    [self.bubbleArray removeObject:self.selectedBubble];
    self.selectedBubble = nil;
}

/////////////////////////////////////////////////

- (void)onImageSelected:(NSNotification *) notification {

    NSDictionary *userInfo = notification.userInfo;
    NSLog(@"%@", userInfo);
    BubbleViewController *bbl = [[BubbleViewController alloc] initWithImage:[userInfo objectForKey:@"Image"] andEditor:self];
    NSLog(@"%@", NSStringFromCGRect(bbl.view.frame));
    [self.bubbleSceneView addSubview:bbl.view];
	[self.bubbleArray addObject:bbl];
}

- (void)onCloseContainer:(id)object {
    self.categoryContainer.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)switchToView:(NSString*)name
{
    if ([name isEqualToString:@"BubbleShop"]) {
//        self.categoryContainer.
        self.categoryContainer.hidden = NO;
    }
//    else {
//        if (_socialViewController==nil) {
//            _socialViewController = [[SocialViewController alloc] initWithNibName:@"SocialViewController" bundle:nil];
//            [self.view addSubview:_socialViewController.view];
//        }
//        [self.view bringSubviewToFront:_socialViewController.view];
//    }
    
}

// SHStripeMenu code
- (void)stripeMenuItemSelected:(NSString *)menuName
{
	if ([menuName isEqualToString:@"BubbleShop"])
	{
		[self switchToView:@"BubbleShop"];
	}
	else if ([menuName isEqualToString:@"Background"]) {
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"Take Background Image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take a Photo", @"Take from library",  nil];
        actionsheet.tag = 0;
        [actionsheet showInView:self.view];
    } else
	{
		UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", @"Instagram", @"Email",  nil];
        actionsheet.tag = 1;
        [actionsheet showInView:self.view];
	}
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.bacgroundImgview.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (actionSheet.tag == 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;

        if (buttonIndex == 0) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:NULL];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This device doesn't support camera." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        } else if (buttonIndex == 1) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:YES completion:NULL];
            }
        }
    } else {
    
        }
}

@end
