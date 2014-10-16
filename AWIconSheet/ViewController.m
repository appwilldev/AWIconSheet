//
//  ViewController.m
//  AWIconSheet
//
//  Created by Narcissus on 10/26/12.
//  Copyright (c) 2012 Narcissus. All rights reserved.
//

#import "ViewController.h"
#import "AWActionSheet.h"
@interface ViewController ()
<UIActionSheetDelegate,AWActionSheetDelegate>
@property (nonatomic, retain)UILabel* TapToShowActionsheet;
@end

@implementation ViewController
@synthesize TapToShowActionsheet;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor underPageBackgroundColor];
    
    self.TapToShowActionsheet  =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 300)];
    [TapToShowActionsheet setBackgroundColor:[UIColor clearColor]];
    [TapToShowActionsheet setFont:[UIFont boldSystemFontOfSize:18]];
    [TapToShowActionsheet setTextColor:[UIColor darkGrayColor]];
    [TapToShowActionsheet setShadowColor:[UIColor blackColor]];
    [TapToShowActionsheet setShadowOffset:CGSizeMake(0, 0.5)];
    [TapToShowActionsheet setTextAlignment:NSTextAlignmentCenter];
    [TapToShowActionsheet setText:@"Tap To Show IconSheet"];
    [self.view addSubview:TapToShowActionsheet];
    
    
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAWSheet)];
    [self.view addGestureRecognizer:tap];
}

- (void)showAWSheet
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initWithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(int)numberOfItemsInActionSheet
{
    return 14;
}

-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    
    [[cell iconView] setBackgroundColor:
     [UIColor colorWithRed:rand()%255/255.0f
                     green:rand()%255/255.0f
                      blue:rand()%255/255.0f
                     alpha:1]];
    [[cell titleLabel] setText:[NSString stringWithFormat:@"item %d",(int)index]];
    cell.index = (int)index;
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    NSLog(@"tap on %d",(int)index);
    [TapToShowActionsheet setText:[NSString stringWithFormat:@"Selected Item %d",(int)index]];
}

@end
