//
//  CustomCell.m
//  FRCTracker
//
//  Created by Nick McGuire on 11-02-08.
//  Copyright 2011 RND Consulting. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize cellSegControl, cellTextField, cellSwitchControl;

@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
        // Initialization code
    }
    return self;
}

- (void)setUpTextFieldWithPlaceholder:(NSString *)placeholder AndTag:(NSInteger )tag
{
	cellTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 6, 280, 31)];
	[cellTextField setFont:[UIFont systemFontOfSize:14.0]];
	[cellTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
	[cellTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
	[cellTextField setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
	[cellTextField setBorderStyle:UITextBorderStyleNone];
	[cellTextField setPlaceholder:placeholder];
	[cellTextField setTag:tag];
	
	currentObject = cellTextField;
	
	[cellTextField setDelegate:self];
	
	[[self contentView] addSubview:cellTextField];
}

- (void)setUpSegmentedControlWithTitles:(NSArray *)titles AndTag:(NSInteger )tag
{	
	cellSegControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(10, 7, 300, 30)];
	[cellSegControl setSegmentedControlStyle:UISegmentedControlStyleBar];
	[cellSegControl setSelectedSegmentIndex:1];
	[cellSegControl setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
	[cellSegControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
	[cellSegControl setTag:tag];
	
	for (int i=0;i<[titles count];i++)
        [cellSegControl insertSegmentWithTitle:[titles objectAtIndex:i] atIndex:i animated:NO];
	
	currentObject = cellSegControl;
	
	[cellSegControl addTarget:self
				   action:@selector(segmentedControlUpdated:)
		 forControlEvents:UIControlEventValueChanged];
	
	[[self contentView] addSubview:cellSegControl];
}


- (void)setUpSwitchWithTag:(NSInteger )tag
{
	cellSwitchControl = [[UISwitch alloc] init];
	[cellSwitchControl setFrame:CGRectMake(self.frame.size.width-(cellSwitchControl.frame.size.width*1.25), (self.frame.size.height-cellSwitchControl.frame.size.height)/2, 79, 27)];
	[cellSwitchControl setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
	[cellSwitchControl setOn:YES];
	[cellSwitchControl setTag:tag];
	
	currentObject = cellSwitchControl;
	
	[[self contentView] addSubview:cellSwitchControl];
}

- (NSObject *)getCurrentObject
{
	return currentObject;
}

#pragma mark - Delegate Methods

- (void)segmentedControlUpdated:(id)sender
{
	UISegmentedControl *seg = (UISegmentedControl *)sender;
	[[self delegate] currentCellDidUpdate:[seg titleForSegmentAtIndex:[seg selectedSegmentIndex]]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	[[self delegate] currentCellDidUpdate:[textField text]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:NO];

    // Configure the view for the selected state
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	//[super setEditing:editing animated:animated];
	
	NSLog(@"Cell: setEditing");
	
	[[self contentView] setNeedsDisplay];
}

@end
