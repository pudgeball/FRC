//
//  CustomCell.m
//  FRCTracker
//
//  Created by Nick McGuire on 11-02-08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize segControl, textField, switchControl;

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
	textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 6, 280, 31)];
	[textField setFont:[UIFont systemFontOfSize:14.0]];
	[textField setClearButtonMode:UITextFieldViewModeWhileEditing];
	[textField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
	[textField setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
	[textField setBorderStyle:UITextBorderStyleNone];
	[textField setPlaceholder:placeholder];
	[textField setTag:tag];
	
	currentObject = textField;
	
	[[self contentView] addSubview:textField];
}

- (void)setUpSegmentedControlWithTitles:(NSArray *)titles AndTag:(NSInteger )tag
{	
	segControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(10, 7, 300, 30)];
	[segControl setSegmentedControlStyle:UISegmentedControlStyleBar];
	[segControl setSelectedSegmentIndex:1];
	[segControl setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
	[segControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
	[segControl setTag:tag];
	
	for (int i=0;i<[titles count];i++)
        [segControl insertSegmentWithTitle:[titles objectAtIndex:i] atIndex:i animated:NO];
	
	currentObject = segControl;
	
	[segControl addTarget:self 
				   action:@selector(segmentedControlUpdated:) 
		 forControlEvents:UIControlEventValueChanged];
	
	[[self contentView] addSubview:segControl];
}


- (void)setUpSwitchWithTag:(NSInteger )tag
{
	switchControl = [[UISwitch alloc] init];
	[switchControl setFrame:CGRectMake(self.frame.size.width-(switchControl.frame.size.width*1.25), (self.frame.size.height-switchControl.frame.size.height)/2, 79, 27)];
	[switchControl setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
	[switchControl setOn:YES];
	[switchControl setTag:tag];
	
	currentObject = switchControl;
	
	[[self contentView] addSubview:switchControl];
}

- (NSObject *)getCurrentObject
{
	return currentObject;
}

- (void)segmentedControlUpdated:(id)sender
{
	UISegmentedControl *seg = (UISegmentedControl *)sender;
	[[self delegate] currentCellDidUpdate:[seg titleForSegmentAtIndex:[seg selectedSegmentIndex]]];
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
