//
//  CustomCell.h
//  FRCTracker
//
//  Created by Nick McGuire on 11-02-08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NMCustomCell <NSObject>

@optional
- (void)currentCellDidUpdate:(NSString *)data;

@end


@interface CustomCell : UITableViewCell {
    UISegmentedControl *segControl;
    UITextField *textField;
	UISwitch *switchControl;
	
	NSObject *currentObject;
	
	id <NMCustomCell> delegate;
}

@property (nonatomic, retain) UISegmentedControl *segControl;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) UISwitch *switchControl;

@property (nonatomic, retain) id delegate;

- (void)setUpSegmentedControlWithTitles:(NSArray *)titles AndTag:(NSInteger )tag;
- (void)setUpTextFieldWithPlaceholder:(NSString *)placeholder AndTag:(NSInteger )tag;
- (void)setUpSwitchWithTag:(NSInteger )tag;

- (NSObject *)getCurrentObject;

- (void)segmentedControlUpdated:(id)sender;

@end