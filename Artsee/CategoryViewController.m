//
//  CategoryViewController.m
//  Artsee
//
//  Created by Yurii.B on 6/16/14.
//  Copyright (c) 2014 YuriiBogdan. All rights reserved.
//

#import "CategoryViewController.h"
#import "PPImageScrollingTableViewCell.h"
#import "ViewController.h"

@interface CategoryViewController ()<PPImageScrollingTableViewCellDelegate, UIAlertViewDelegate> {

    UIImage *selectedImg;
}

@property (strong, nonatomic) NSArray *images;

@end

@implementation CategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (void)onClickRight {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ContainerCloseNotification" object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onClickRight)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    self.title = @"Category";
    [self.tableView setBackgroundColor:[UIColor grayColor]];
    
    static NSString *CellIdentifier = @"Cell";
    [self.tableView registerClass:[PPImageScrollingTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.images = @[
                    @{ @"category": @"Paintings",
                       @"images":
                           @[
                               @{ @"name":@"painting_1.jpeg", @"title":@"$131"},
                               @{ @"name":@"painting_2.jpeg", @"title":@"$131"},
                               @{ @"name":@"painting_3.jpeg", @"title":@"$131"},
                               @{ @"name":@"painting_4.jpeg", @"title":@"$131"},
                               @{ @"name":@"painting_5.jpeg", @"title":@"$131"},
                               @{ @"name":@"painting_6.jpeg", @"title":@"$131"},
                               @{ @"name":@"painting_7.jpeg", @"title":@"$131"},
                               @{ @"name":@"painting_8.jpeg", @"title":@"$131"},
                               @{ @"name":@"painting_9.jpeg", @"title":@"$131"}
                               ]
                       },
                    @{ @"category": @"Sculpture",
                       @"images":
                           @[
                               @{ @"name":@"sculpture_1.jpeg", @"title":@"$131"},
                               @{ @"name":@"sculpture_2.jpeg", @"title":@"$131"},
                               @{ @"name":@"sculpture_3.jpeg", @"title":@"$131"},
                               @{ @"name":@"sculpture_4.jpeg", @"title":@"$131"},
                               @{ @"name":@"sculpture_5.jpeg", @"title":@"$131"},
                               @{ @"name":@"sculpture_6.jpeg", @"title":@"$131"},
                               @{ @"name":@"sculpture_7.jpeg", @"title":@"$131"},
                               @{ @"name":@"sculpture_8.jpeg", @"title":@"$131"},
                               @{ @"name":@"sculpture_9.jpeg", @"title":@"$131"},
                               ]
                       }
                    ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.images count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    NSDictionary *cellData = [self.images objectAtIndex:[indexPath section]];
    PPImageScrollingTableViewCell *customCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [customCell setBackgroundColor:[UIColor clearColor]];
    [customCell setDelegate:self];
    [customCell setImageData:cellData];
    [customCell setCategoryLabelText:[cellData objectForKey:@"category"] withColor:[UIColor whiteColor]];
    [customCell setTag:[indexPath section]];
    [customCell setImageTitleTextColor:[UIColor whiteColor] withBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [customCell setImageTitleLabelWitdh:90 withHeight:45];
    [customCell setCollectionViewBackgroundColor:[UIColor darkGrayColor]];
    
    return customCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

#pragma mark - PPImageScrollingTableViewCellDelegate

- (void)scrollingTableViewCell:(PPImageScrollingTableViewCell *)scrollingTableViewCell didSelectImageAtIndexPath:(NSIndexPath*)indexPathOfImage atCategoryRowIndex:(NSInteger)categoryRowIndex
{
    
    NSDictionary *images = [self.images objectAtIndex:categoryRowIndex];
    NSArray *imageCollection = [images objectForKey:@"images"];
    NSString *imageTitle = [[imageCollection objectAtIndex:[indexPathOfImage row]]objectForKey:@"title"];
//    NSString *categoryTitle = [[self.images objectAtIndex:categoryRowIndex] objectForKey:@"category"];
    selectedImg = [UIImage imageNamed:[[imageCollection objectAtIndex:[indexPathOfImage row]]objectForKey:@"name"]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat: @"Image %@",imageTitle]
                                                    message:[NSString stringWithFormat: @"Do you wanna use this Image?"]
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageSelectNotification" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:selectedImg, @"Image", nil]];
    }
}

@end
