/*****************************************************************
 NSTextField+M3ExtensionsTests.m
 M3AppKit
 
 Created by Martin Pilkington on 11/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSTextField+M3ExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSTextField_M3ExtensionsTests

- (void)test_returnsTextFieldIsLableIfItIsNotSelectableHadNoBackgroundAndIsNotBordered {
	NSTextField *textField = [NSTextField new];
	
	[textField setSelectable:YES];
	assertThatBool(textField.m3_isLabel, is(equalToBool(NO)));
	
	[textField setSelectable:NO];
	[textField setDrawsBackground:YES];
	assertThatBool(textField.m3_isLabel, is(equalToBool(NO)));
	
	[textField setDrawsBackground:NO];
	[textField setBordered:YES];
	assertThatBool(textField.m3_isLabel, is(equalToBool(NO)));
	
	[textField setBordered:NO];
	assertThatBool(textField.m3_isLabel, is(equalToBool(YES)));
}

- (void)test_setsTextFieldToBeSelectableBorderedAndDrawBackgroundIfLabelIsNO {
	NSTextField *textField = [NSTextField new];
	[textField setSelectable:NO];
	[textField setDrawsBackground:NO];
	[textField setBordered:NO];
	
	[textField setM3_label:NO];
	
	assertThatBool(textField.isSelectable, is(equalToBool(YES)));
	assertThatBool(textField.drawsBackground, is(equalToBool(YES)));
	assertThatBool(textField.isBordered, is(equalToBool(YES)));
}

- (void)test_setsTextFieldToNotBeSelectableBorderedAndDrawBackgroundIfLabelIsYES {
	NSTextField *textField = [NSTextField new];
	[textField setSelectable:YES];
	[textField setDrawsBackground:YES];
	[textField setBordered:YES];
	
	[textField setM3_label:YES];
	
	assertThatBool(textField.isSelectable, is(equalToBool(NO)));
	assertThatBool(textField.drawsBackground, is(equalToBool(NO)));
	assertThatBool(textField.isBordered, is(equalToBool(NO)));
}

@end
