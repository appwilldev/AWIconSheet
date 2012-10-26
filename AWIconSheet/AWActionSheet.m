//
//  AWActionSheet.m
//  AWIconSheet
//
//  Created by Narcissus on 10/26/12.
//  Copyright (c) 2012 Narcissus. All rights reserved.
//

#import "AWActionSheet.h"
#import <QuartzCore/QuartzCore.h>
#define itemPerPage 9

@interface AWActionSheet()<UIScrollViewDelegate>
@property (nonatomic, retain)UIScrollView* scrollView;
@property (nonatomic, retain)UIPageControl* pageControl;
@property (nonatomic, retain)NSMutableArray* items;
@end
@implementation AWActionSheet
@synthesize scrollView;
@synthesize pageControl;
@synthesize items;
@synthesize IconDelegate;
-(void)dealloc
{
    IconDelegate= nil;
    [scrollView release];
    [pageControl release];
    [items release];
    [super dealloc];
}

-(id)initWithTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    self = [super initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                      delegate:delegate
             cancelButtonTitle:@"Cancel"
        destructiveButtonTitle:nil
             otherButtonTitles:nil];
    if (self) {
//        IconDelegate = (AWActionSheetDelegate)delegate;
        [self setActionSheetStyle:UIActionSheetStyleBlackTranslucent];

        self.scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 10, 320, 320)] autorelease];
        [scrollView setPagingEnabled:YES];
        [scrollView setBackgroundColor:[UIColor clearColor]];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setDelegate:self];
        [scrollView setScrollEnabled:YES];
        [scrollView setBounces:NO];
        
        [self addSubview:scrollView];
        
        
        self.pageControl = [[[UIPageControl alloc] initWithFrame:CGRectMake(0, 320, 0, 20)] autorelease];
        [pageControl setNumberOfPages:0];
        [pageControl setCurrentPage:0];
        [pageControl addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
        
        self.items = [[[NSMutableArray alloc] init] autorelease];
        
//        [self reloadData];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)showInView:(UIView *)view
{
    [super showInView:view];
    [self reloadData];
}

- (void)reloadData
{
    for (AWActionSheetCell* cell in items) {
        [cell removeFromSuperview];
        [items removeObject:cell];
    }
    
//    if (!IconDelegate) {
//        return;
//    }
    
    int count = [IconDelegate numberOfItemsInActionSheet];
    
    if (count <= 0) {
        return;
    }
    [scrollView setContentSize:CGSizeMake(320*(count/itemPerPage+1), scrollView.frame.size.height)];
    [pageControl setNumberOfPages:count/itemPerPage+1];
    [pageControl setCurrentPage:0];
    
    
    for (int i = 0; i< count; i++) {
        AWActionSheetCell* cell = [IconDelegate cellForActionAtIndex:i];
        int PageNo = i/itemPerPage;
//        NSLog(@"page %d",PageNo);
        int index  = i%itemPerPage;
        
        if (itemPerPage == 9) {
            
            int row = index/3;
            int column = index%3;
            
//            NSLog(@"%d %d %d",index,row,column);
            
            float centerY = (1+row*2)*self.scrollView.frame.size.height/6;
            float centerX = (1+column*2)*self.scrollView.frame.size.width/6;
            
//            NSLog(@"%f %f",centerX+320*PageNo,centerY);
            
            [cell setCenter:CGPointMake(centerX+320*PageNo, centerY)];
            [self.scrollView addSubview:cell];
            [cell.iconView addTarget:self action:@selector(actionForItem:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        [items addObject:cell];
    }
    
}

- (void)actionForItem:(UIButton*)sender
{
    AWActionSheetCell* cell = (AWActionSheetCell*)[sender superview];
    [IconDelegate DidTapOnItemAtIndex:cell.index];
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    [scrollView setContentOffset:CGPointMake(320 * page, 0)];
}
#pragma mark -
#pragma scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    int page = scrollView.contentOffset.x /320;
    pageControl.currentPage = page;
}


@end

#pragma mark - AWActionSheetCell
@interface AWActionSheetCell ()
@end
@implementation AWActionSheetCell
@synthesize iconView;
@synthesize titleLabel;

- (void)dealloc
{
    [iconView release];
    [titleLabel release];
    
    [super dealloc];
}

-(id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 70, 70)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconView = [[[UIButton alloc] initWithFrame:CGRectMake(6.5, 0, 57, 57)] autorelease];
        [iconView setBackgroundColor:[UIColor clearColor]];
        [[iconView layer] setCornerRadius:8.0f];
        
        [self addSubview:iconView];
        
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, 63, 70, 13)] autorelease];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setTextAlignment:UITextAlignmentCenter];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setShadowColor:[UIColor blackColor]];
        [titleLabel setShadowOffset:CGSizeMake(0, 0.5)];
        [titleLabel setText:@""];
        [self addSubview:titleLabel];
    }
    return self;
}

@end


