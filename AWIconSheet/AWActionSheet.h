//
//  AWActionSheet.h
//  AWIconSheet
//
//  Created by Narcissus on 10/26/12.
//  Copyright (c) 2012 Narcissus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AWActionSheetCell;

@protocol AWActionSheetDelegate <NSObject>

- (int)numberOfItemsInActionSheet;
- (AWActionSheetCell*)cellForActionAtIndex:(NSInteger)index;
- (void)DidTapOnItemAtIndex:(NSInteger)index;

@end

@interface AWActionSheet : UIActionSheet
@property (nonatomic, assign)id<AWActionSheetDelegate> IconDelegate;
@end


@interface AWActionSheetCell : UIView
@property (nonatomic,retain)UIButton*    iconView;
@property (nonatomic,retain)UILabel*     titleLabel;
@property (nonatomic,assign)int          index;
@end