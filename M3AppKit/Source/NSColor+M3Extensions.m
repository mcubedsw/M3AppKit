/*****************************************************************
 NSColor+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 20/05/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSColor+M3Extensions.h"

@interface NSColor (M3ExtensionsPrivate)

+ (NSInteger)hexToInt:(NSString *)hex;
- (NSString *)hexForInt:(NSInteger)integer;

@end


@implementation NSColor (M3Extensions)


+ (NSColor *)m3_colorWithHexadecimalString:(NSString *)hexCode {
	if ([hexCode rangeOfString:@"#"].location == 0) {
		hexCode = [hexCode substringFromIndex:1];
	}
	if (hexCode.length == 3) {
		hexCode = [NSString stringWithFormat:@"%c%c%c%c%c%c", [hexCode characterAtIndex:0], [hexCode characterAtIndex:0], [hexCode characterAtIndex:1], [hexCode characterAtIndex:1], [hexCode characterAtIndex:2], [hexCode characterAtIndex:2]];
	}
	if (hexCode.length == 6) {
		NSInteger red = [NSColor hexToInt:[hexCode substringWithRange:NSMakeRange(0, 2)]];
		NSInteger green = [NSColor hexToInt:[hexCode substringWithRange:NSMakeRange(2, 2)]];
		NSInteger blue = [NSColor hexToInt:[hexCode substringWithRange:NSMakeRange(4, 2)]];
		if (red == -1 || blue == -1 || green == -1) {
			return nil;
		}
		//Convert to floats between 0 and 1 with 2 d.p.
		CGFloat roundedRed = roundf((red * 100)/255.0) / 100.0;
		CGFloat roundedGreen = roundf((green * 100)/255.0) / 100.0;
		CGFloat roundedBlue = roundf((blue * 100)/255.0) / 100.0;
		return [NSColor colorWithDeviceRed:roundedRed green:roundedGreen blue:roundedBlue alpha:1.0];
	} 
	return nil;
}


+ (NSInteger)hexToInt:(NSString *)hex {
	NSInteger returnValue = 0;
	NSInteger i;
	for (i = 0; i < hex.length; i++) {
		NSString *letter = [hex.uppercaseString substringWithRange:NSMakeRange(i, 1)];
		NSInteger value = letter.integerValue;
		if ([letter isEqualToString:@"A"]) {
			value = 10;
		} else if ([letter isEqualToString:@"B"]) {
			value = 11;
		} else if ([letter isEqualToString:@"C"]) {
			value = 12;
		} else if ([letter isEqualToString:@"D"]) {
			value = 13;
		} else if ([letter isEqualToString:@"E"]) {
			value = 14;
		} else if ([letter isEqualToString:@"F"]) {
			value = 15;
		}
		
		//If we have an invalid character then abort
		if (value == 0 && ![letter isEqualToString:@"0"]) {
			return -1;
		}
		
		returnValue += value * pow(16, (hex.length - i) - 1);
	}
	return returnValue;
}


- (NSString *)m3_hexadecimalString {
	NSInteger red = 0;
	NSInteger green = 0;
	NSInteger blue =  0;
	
	NSColor *color = self;
	if (![self.colorSpace isEqual:[NSColorSpace deviceRGBColorSpace]]) {
		color = [color colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
	}
	
	red = (NSInteger)(255 * color.redComponent);
	green = (NSInteger)(255 * color.greenComponent);
	blue = (NSInteger)(255 * color.blueComponent);
	
	int count = 0;
	while (red >= 16) {
		count++;
		red -= 16;
	}
	NSString *redstr = [NSString stringWithFormat:@"%@%@", [self hexForInt:count], [self hexForInt:red]];
	
	count = 0;
	while (green >= 16) {
		count++;
		green -= 16;
	}
	NSString *greenstr = [NSString stringWithFormat:@"%@%@", [self hexForInt:count], [self hexForInt:green]];
	
	count = 0;
	while (blue >= 16) {
		count++;
		blue -= 16;
	}
	NSString *bluestr = [NSString stringWithFormat:@"%@%@", [self hexForInt:count], [self hexForInt:blue]];
	
	return [NSString stringWithFormat:@"%@%@%@", redstr, greenstr, bluestr];;
}


- (NSString *)hexForInt:(NSInteger)integer {
	if (integer < 10) {
		return [NSString stringWithFormat:@"%ld", (long)integer];
	}
	switch (integer) {
		case 10:
			return @"A";
			break;
		case 11:
			return @"B";
			break;
		case 12:
			return @"C";
			break;
		case 13:
			return @"D";
			break;
		case 14:
			return @"E";
			break;
		case 15:
			return @"F";
			break;
	}
	return nil;
}


- (NSString *)m3_colorString {
	NSColor *color = self;
	if (![self.colorSpace isEqual:[NSColorSpace deviceRGBColorSpace]]) {
		color = [color colorUsingColorSpace:[NSColorSpace deviceRGBColorSpace]];
	}
	return [NSString stringWithFormat:@"%g/%g/%g/%g", color.redComponent, color.greenComponent, color.blueComponent, color.alphaComponent];
}


+ (NSColor *)m3_colorWithString:(NSString *)string {
	NSPredicate *numberOnlyPredicate = [NSPredicate predicateWithFormat:@"self matches '[0-9\\.]*'"];
	NSArray *components = [[string componentsSeparatedByString:@"/"] filteredArrayUsingPredicate:numberOnlyPredicate];
	if (components.count != 4) {
		return nil;
	}
	
	return [NSColor colorWithDeviceRed:[components[0] doubleValue]
								 green:[components[1] doubleValue]
								  blue:[components[2] doubleValue]
								 alpha:[components[3] doubleValue]];
}

- (NSColor *)m3_colourByAdjustingBrightness:(CGFloat)aBrightness {
	if (aBrightness == 0) return self;
	
	return [NSColor colorWithDeviceHue:self.hueComponent
							saturation:self.saturationComponent
							brightness:(self.brightnessComponent + aBrightness)
								 alpha:self.alphaComponent];
}

- (NSColor *)m3_colourByAdjustingHue:(CGFloat)aHue {
	if (aHue == 0) return self;
	
	return [NSColor colorWithDeviceHue:(self.hueComponent + aHue)
							saturation:self.saturationComponent
							brightness:self.brightnessComponent
								 alpha:self.alphaComponent];
}

- (NSColor *)m3_colourByAdjustingSaturation:(CGFloat)aSaturation {
	if (aSaturation == 0) return self;
	
	return [NSColor colorWithDeviceHue:self.hueComponent
							saturation:(self.saturationComponent + aSaturation)
							brightness:self.brightnessComponent
								 alpha:self.alphaComponent];
}

@end
