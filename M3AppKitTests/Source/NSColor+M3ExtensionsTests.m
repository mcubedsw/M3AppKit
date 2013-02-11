//
//  NSColor+M3ExtensionsTests.m
//  M3AppKit
//
//  Created by Martin Pilkington on 07/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "NSColor+M3ExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSColor_M3ExtensionsTests

#pragma mark -
#pragma mark +m3_colorWithHexadecimalString:

- (void)test_correctlyAccepts6CharacterString {
	NSColor *whiteHexColor = [NSColor m3_colorWithHexadecimalString:@"ffffff"];
	NSColor *redHexColor = [NSColor m3_colorWithHexadecimalString:@"ff0000"];
	NSColor *greenHexColor = [NSColor m3_colorWithHexadecimalString:@"00ff00"];
	NSColor *blueHexColor = [NSColor m3_colorWithHexadecimalString:@"0000ff"];
	NSColor *mixedHexColor = [NSColor m3_colorWithHexadecimalString:@"3fff7f"];
	
	NSColor *whiteColor = [NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1];
	NSColor *redColor = [NSColor colorWithDeviceRed:1 green:0 blue:0 alpha:1];
	NSColor *greenColor = [NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:1];
	NSColor *blueColor = [NSColor colorWithDeviceRed:0 green:0 blue:1 alpha:1];
	NSColor *mixedColor = [NSColor colorWithDeviceRed:0.25 green:1 blue:0.5 alpha:1];

	assertThat(whiteHexColor, is(equalTo(whiteColor)));
	assertThat(redHexColor, is(equalTo(redColor)));
	assertThat(greenHexColor, is(equalTo(greenColor)));
	assertThat(blueHexColor, is(equalTo(blueColor)));
	assertThat(mixedHexColor, is(equalTo(mixedColor)));
}

- (void)test_correctlyAccepts3CharacterString {
	NSColor *whiteHexColor = [NSColor m3_colorWithHexadecimalString:@"fff"];
	NSColor *redHexColor = [NSColor m3_colorWithHexadecimalString:@"f00"];
	NSColor *greenHexColor = [NSColor m3_colorWithHexadecimalString:@"0f0"];
	NSColor *blueHexColor = [NSColor m3_colorWithHexadecimalString:@"00f"];
	
	NSColor *whiteColor = [NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1];
	NSColor *redColor = [NSColor colorWithDeviceRed:1 green:0 blue:0 alpha:1];
	NSColor *greenColor = [NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:1];
	NSColor *blueColor = [NSColor colorWithDeviceRed:0 green:0 blue:1 alpha:1];
	
	assertThat(whiteHexColor, is(equalTo(whiteColor)));
	assertThat(redHexColor, is(equalTo(redColor)));
	assertThat(greenHexColor, is(equalTo(greenColor)));
	assertThat(blueHexColor, is(equalTo(blueColor)));
}

- (void)test_acceptsStringWithHashPrefix {
	NSColor *whiteHexColor = [NSColor m3_colorWithHexadecimalString:@"#ffffff"];
	NSColor *mixedHexColor = [NSColor m3_colorWithHexadecimalString:@"#3fff7f"];
	
	NSColor *whiteColor = [NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1];
	NSColor *mixedColor = [NSColor colorWithDeviceRed:0.25 green:1 blue:0.5 alpha:1];
	
	assertThat(whiteHexColor, is(equalTo(whiteColor)));
	assertThat(mixedHexColor, is(equalTo(mixedColor)));
}





#pragma mark -
#pragma mark -m3_hexadeicmalString

- (void)test_returnsCorrectHexadecimalStringForColour {
	NSColor *whiteColor = [NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1];
	NSColor *redColor = [NSColor colorWithDeviceRed:1 green:0 blue:0 alpha:1];
	NSColor *greenColor = [NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:1];
	NSColor *blueColor = [NSColor colorWithDeviceRed:0 green:0 blue:1 alpha:1];
	NSColor *mixedColor = [NSColor colorWithDeviceRed:0.25 green:1 blue:0.5 alpha:1];
	
	assertThat(whiteColor.m3_hexadecimalString, is(equalToIgnoringCase(@"ffffff")));
	assertThat(redColor.m3_hexadecimalString, is(equalToIgnoringCase(@"ff0000")));
	assertThat(greenColor.m3_hexadecimalString, is(equalToIgnoringCase(@"00ff00")));
	assertThat(blueColor.m3_hexadecimalString, is(equalToIgnoringCase(@"0000ff")));
	assertThat(mixedColor.m3_hexadecimalString, is(equalToIgnoringCase(@"3fff7f")));
}

- (void)test_returnsCorrectHexadecimalStringForNonRGBColour {
	NSColor *whiteColor = [NSColor colorWithDeviceWhite:0.5 alpha:1];
	assertThat(whiteColor.m3_hexadecimalString, is(equalToIgnoringCase(@"7f7f7f")));
}





#pragma mark -
#pragma mark -m3_colorToString

- (void)test_returnsCorrectStringFromColour {
	NSColor *whiteColor = [NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1];
	NSColor *redColor = [NSColor colorWithDeviceRed:1 green:0 blue:0 alpha:1];
	NSColor *greenColor = [NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:1];
	NSColor *blueColor = [NSColor colorWithDeviceRed:0 green:0 blue:1 alpha:1];
	NSColor *alphaColor = [NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:0.5];
	NSColor *mixedColor = [NSColor colorWithDeviceRed:0.25 green:1 blue:0.5 alpha:0.75];
	
	assertThat(whiteColor.m3_colorString, is(equalToIgnoringCase(@"1/1/1/1")));
	assertThat(redColor.m3_colorString, is(equalToIgnoringCase(@"1/0/0/1")));
	assertThat(greenColor.m3_colorString, is(equalToIgnoringCase(@"0/1/0/1")));
	assertThat(blueColor.m3_colorString, is(equalToIgnoringCase(@"0/0/1/1")));
	assertThat(alphaColor.m3_colorString, is(equalToIgnoringCase(@"0/0/0/0.5")));
	assertThat(mixedColor.m3_colorString, is(equalToIgnoringCase(@"0.25/1/0.5/0.75")));
}

- (void)test_returnsCorrectStringFromNonRGBColour {
	NSColor *whiteColor = [NSColor colorWithDeviceWhite:0.5 alpha:1];
	assertThat(whiteColor.m3_colorString, is(equalToIgnoringCase(@"0.5/0.5/0.5/1")));
}





#pragma mark -
#pragma mark +m3_colorWithString:

- (void)test_createsColourUsingString {
	NSColor *whiteStringColor = [NSColor m3_colorWithString:@"1/1/1/1"];
	NSColor *redStringColor = [NSColor m3_colorWithString:@"1/0/0/1"];
	NSColor *greenStringColor = [NSColor m3_colorWithString:@"0/1/0/1"];
	NSColor *blueStringColor = [NSColor m3_colorWithString:@"0/0/1/1"];
	NSColor *alphaStringColor = [NSColor m3_colorWithString:@"0/0/0/0.5"];
	NSColor *mixedStringColor = [NSColor m3_colorWithString:@"0.25/1/0.5/0.75"];
	
	NSColor *whiteColor = [NSColor colorWithDeviceRed:1 green:1 blue:1 alpha:1];
	NSColor *redColor = [NSColor colorWithDeviceRed:1 green:0 blue:0 alpha:1];
	NSColor *greenColor = [NSColor colorWithDeviceRed:0 green:1 blue:0 alpha:1];
	NSColor *blueColor = [NSColor colorWithDeviceRed:0 green:0 blue:1 alpha:1];
	NSColor *alphaColor = [NSColor colorWithDeviceRed:0 green:0 blue:0 alpha:0.5];
	NSColor *mixedColor = [NSColor colorWithDeviceRed:0.25 green:1 blue:0.5 alpha:0.75];
	
	assertThat(whiteStringColor, is(equalTo(whiteColor)));
	assertThat(redStringColor, is(equalTo(redColor)));
	assertThat(greenStringColor, is(equalTo(greenColor)));
	assertThat(blueStringColor, is(equalTo(blueColor)));
	assertThat(alphaStringColor, is(equalTo(alphaColor)));
	assertThat(mixedStringColor, is(equalTo(mixedColor)));
}

- (void)test_returnsNilIfStringMalformed {
	assertThat([NSColor m3_colorWithString:@""], is(nilValue()));
	assertThat([NSColor m3_colorWithString:@"1/1/1"], is(nilValue()));
	assertThat([NSColor m3_colorWithString:@"fo/o/ba/r"], is(nilValue()));
}





#pragma mark -
#pragma mark -m3_adjustBrightnessBy:

- (void)test_changingBrightnessBy0ReturnsSameColour {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.5 green:0 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingBrightness:0];
	
	assertThat(baseColor, is(equalTo(modifiedColor)));
}

- (void)test_supplyingAPositiveNumberIncreasesBrightnessByValue {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.5 green:0 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingBrightness:0.1];
	
	assertThatFloat(modifiedColor.brightnessComponent, is(equalToFloat(baseColor.brightnessComponent + 0.1)));
}

- (void)test_supplyingANegativeNumberDecreasesBrightnessByValue {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.5 green:0 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingBrightness:-0.1];
	
	assertThatFloat(modifiedColor.brightnessComponent, is(equalToFloat(baseColor.brightnessComponent - 0.1)));
}

- (void)test_supplyingAnExcessivePositiveNumberIncreasesBrightnessTo1 {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.5 green:0 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingBrightness:10.0];
	
	assertThatFloat(modifiedColor.brightnessComponent, is(equalToFloat(1.0)));
}

- (void)test_supplyingAnExcessiveNegativeNumberDecreasesBrightnessTo0 {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.5 green:0 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingBrightness:-10.0];
	
	assertThatFloat(modifiedColor.brightnessComponent, is(equalToFloat(0.0)));
}





#pragma mark -
#pragma mark -m3_adjustHueBy:

- (void)test_changingHueBy0ReturnsSameColour {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0 green:0.5 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingHue:0];
	
	assertThat(baseColor, is(equalTo(modifiedColor)));
}

- (void)test_supplyingAPositiveNumberIncreasesHueByValue {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0 green:0.5 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingHue:0.1];
	
	assertThatFloat(modifiedColor.hueComponent, is(equalToFloat(baseColor.hueComponent + 0.1)));
}

- (void)test_supplyingANegativeNumberDecreasesHueByValue {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0 green:0.5 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingHue:-0.1];
	
	assertThatFloat(modifiedColor.hueComponent, is(equalToFloat(baseColor.hueComponent - 0.1)));
}

- (void)test_supplyingAnExcessivePositiveNumberIncreasesHueTo1 {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0 green:0.5 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingHue:10.0];
	
	assertThatFloat(modifiedColor.hueComponent, is(equalToFloat(1.0)));
}

- (void)test_supplyingAnExcessiveNegativeNumberChangesHueTo1 {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0 green:0.5 blue:0 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingHue:-10.0];
	
	assertThatFloat(modifiedColor.hueComponent, is(equalToFloat(1.0)));
}





#pragma mark -
#pragma mark -m3_adjustSaturationBy:

- (void)test_changingSaturationBy0ReturnsSameColour {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.2 green:0.5 blue:0.2 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingSaturation:0];
	
	assertThat(baseColor, is(equalTo(modifiedColor)));
}

- (void)test_supplyingAPositiveNumberIncreasesSaturationByValue {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.2 green:0.5 blue:0.2 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingSaturation:0.1];
	
	assertThatFloat(modifiedColor.saturationComponent, is(equalToFloat(baseColor.saturationComponent + 0.1)));
}

- (void)test_supplyingANegativeNumberDecreasesSaturationByValue {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.2 green:0.5 blue:0.2 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingSaturation:-0.1];
	
	assertThatFloat(modifiedColor.saturationComponent, is(equalToFloat(baseColor.saturationComponent - 0.1)));
}

- (void)test_supplyingAnExcessivePositiveNumberIncreasesSaturationTo1 {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.2 green:0.5 blue:0.2 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingSaturation:10.0];
	
	assertThatFloat(modifiedColor.saturationComponent, is(equalToFloat(1.0)));
}

- (void)test_supplyingAnExcessiveNegativeNumberDecreasesSaturationTo0 {
	NSColor *baseColor = [NSColor colorWithDeviceRed:0.2 green:0.5 blue:0.2 alpha:1];
	NSColor *modifiedColor = [baseColor m3_colourByAdjustingSaturation:-10.0];
	
	assertThatFloat(modifiedColor.saturationComponent, is(equalToFloat(0.0)));
}

@end
