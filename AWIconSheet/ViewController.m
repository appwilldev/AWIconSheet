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

-(void)dealloc
{
    [TapToShowActionsheet release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor underPageBackgroundColor];
    
    self.TapToShowActionsheet  =[[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 300)] autorelease];
    [TapToShowActionsheet setBackgroundColor:[UIColor clearColor]];
    [TapToShowActionsheet setFont:[UIFont boldSystemFontOfSize:18]];
    [TapToShowActionsheet setTextColor:[UIColor darkGrayColor]];
    [TapToShowActionsheet setShadowColor:[UIColor blackColor]];
    [TapToShowActionsheet setShadowOffset:CGSizeMake(0, 0.5)];
    [TapToShowActionsheet setTextAlignment:UITextAlignmentCenter];
    [TapToShowActionsheet setText:@"Tap To Show IconSheet"];
    [self.view addSubview:TapToShowActionsheet];
    
    
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAWSheet)];
    [self.view addGestureRecognizer:tap];
    [tap release];
    

    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)showAWSheet
{
    AWActionSheet *sheet = [[AWActionSheet alloc] initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
    [sheet showInView:self.view];
    [sheet release];
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
    AWActionSheetCell* cell = [[[AWActionSheetCell alloc] init] autorelease];
    
    [[cell iconView] setBackgroundColor:
     [UIColor colorWithRed:rand()%255/255.0f
                     green:rand()%255/255.0f
                      blue:rand()%255/255.0f
                     alpha:1]];
    [[cell titleLabel] setText:[NSString stringWithFormat:@"item %d",index]];
    cell.index = index;
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    NSLog(@"tap on %d",index);
    [TapToShowActionsheet setText:[NSString stringWithFormat:@"Selected Item %d",index]];
}

@end
