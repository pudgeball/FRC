//
//  CustomCell.h
//  FRCTracker
//
//  Created by Nick McGuire on 11-02-08.
//  Copyright 2011 RND Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NMCustomCell <NSObject>

@optional
- (void)currentCellDidUpdate:(NSString *)data withTag:(NSInteger )tag;
@end


@interface CustomCell : UITableViewCell <UITextFieldDelegate> {
    UISegmentedControl *cellSegControl;
    UITextField *cellTextField;
	UISwitch *cellSwitchControl;
	
	NSObject *currentObject;
	
	id <NMCustomCell> delegate;
}

@property (nonatomic, retain) UISegmentedControl *cellSegControl;
@property (nonatomic, retain) UITextField *cellTextField;
@property (nonatomic, retain) UISwitch *cellSwitchControl;

@property (nonatomic, retain) id delegate;

- (void)setUpSegmentedControlWithTitles:(NSArray *)titles AndTag:(NSInteger )tag;
- (void)setUpTextFieldWithPlaceholder:(NSString *)placeholder AndTag:(NSInteger )tag;
- (void)setUpSwitchWithTag:(NSInteger )tag;

- (NSObject *)getCurrentObject;

- (void)segmentedControlUpdated:(id)sender;

@end