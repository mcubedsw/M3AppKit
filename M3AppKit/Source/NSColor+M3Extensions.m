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

+ (NSColor *)colorWithHexadecimalString:(NSString *)hexCode {
	if ([hexCode rangeOfString:@"#"].location == 0) {
		hexCode = [hexCode substringFromIndex:1];
	}
	if ([hexCode length] == 3) {
		hexCode = [NSString stringWithFormat:@"%c%c%c%c%c%c", [hexCode characterAtIndex:0], [hexCode characterAtIndex:0], [hexCode characterAtIndex:1], [hexCode characterAtIndex:1], [hexCode characterAtIndex:2], [hexCode characterAtIndex:2]];
	}
	if ([hexCode length] == 6) {
		NSInteger red = [NSColor hexToInt:[hexCode substringWithRange:NSMakeRange(0, 2)]];
		NSInteger green = [NSColor hexToInt:[hexCode substringWithRange:NSMakeRange(2, 2)]];
		NSInteger blue = [NSColor hexToInt:[hexCode substringWithRange:NSMakeRange(4, 2)]];
		if (red == -1 || blue == -1 || green == -1)
			return nil;
		return [NSColor colorWithCalibratedRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
	} 
	return nil;
}

+ (NSInteger)hexToInt:(NSString *)hex {
	NSInteger returnValue = 0;
	NSInteger i;
	for (i = 0; i < [hex length]; i++) {
		NSString *letter = [[hex uppercaseString] substringWithRange:NSMakeRange(i, 1)];
		NSInteger value = [letter integerValue];
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
		if (value == 0 && ![letter isEqualToString:@"0"])
			return -1;
		
		returnValue += value * pow(16, ([hex length] - i) - 1);
	}
	return returnValue;
}

- (NSString *)hexadecimalString {
	NSInteger red = 0;
	NSInteger green = 0;
	NSInteger blue =  0;
	if ([[self colorSpace] isEqual:[NSColorSpace genericGrayColorSpace]]) {
		red = (NSInteger)(255 * [self whiteComponent]);
		green = (NSInteger)(255 * [self whiteComponent]);
		blue = (NSInteger)(255 * [self whiteComponent]);
	} else {
		red = (NSInteger)(255 * [self redComponent]);
		green = (NSInteger)(255 * [self greenComponent]);
		blue = (NSInteger)(255 * [self blueComponent]);
	}
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

- (NSString *)colorToString {
	if ([[self colorSpace] isEqual:[NSColorSpace genericGrayColorSpace]]) {
		return [NSString stringWithFormat:@"%f/%f/%f/%f", [self whiteComponent], [self whiteComponent], [self whiteComponent], [self alphaComponent]];
	} else {
		return [NSString stringWithFormat:@"%f/%f/%f/%f", [self redComponent], [self greenComponent], [self blueComponent], [self alphaComponent]];
	}
}

+ (NSColor *)colorWithString:(NSString *)string {
	NSArray *components = [string componentsSeparatedByString:@"/"];
	if ([components count] != 4)
		return [NSColor clearColor];
	
	return [NSColor colorWithCalibratedRed:[[components objectAtIndex:0] doubleValue]
									 green:[[components objectAtIndex:1] doubleValue]
									  blue:[[components objectAtIndex:2] doubleValue]
									 alpha:[[components objectAtIndex:3] doubleValue]];
}

- (NSColor *)lighterColourBy:(CGFloat)lighten {
	if (lighten < 0)
		return 0;
	
	CGFloat red = 0;
	CGFloat green = 0;
	CGFloat blue = 0;
	
	if ([[self colorSpace] isEqual:[NSColorSpace genericGrayColorSpace]]) {
		red = [self whiteComponent] + lighten;
		green = [self whiteComponent] + lighten;
		blue = [self whiteComponent] + lighten;
	} else {
		red = [self redComponent] + lighten;
		green = [self greenComponent] + lighten;
		blue = [self blueComponent] + lighten;
	}
	if (red > 1) {
		green += (red-1)/2;
		blue += (red-1)/2;
	}
	if (green > 1) {
		red += (green-1)/2;
		blue += (green-1)/2;
	}
	if (blue > 1) {
		green += (blue-1)/2;
		red += (blue-1)/2;
	}
	return [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:[self alphaComponent]];
}

- (NSColor *)darkerColourBy:(CGFloat)darken {
	if (darken < 0)
		return 0;
	
	CGFloat red = 0;
	CGFloat green = 0;
	CGFloat blue = 0;
	
	if ([[self colorSpace] isEqual:[NSColorSpace genericGrayColorSpace]]) {
		red = [self whiteComponent] - darken;
		green = [self whiteComponent] - darken;
		blue = [self whiteComponent] - darken;
	} else {
		red = [self redComponent] - darken;
		green = [self greenComponent] - darken;
		blue = [self blueComponent] - darken;
	}
	if (red < 0) {
		green += red/2;
		blue += red/2;
	}
	if (green < 0) {
		red += green/2;
		blue += green/2;
	}
	if (blue < 0) {
		green += blue/2;
		red += blue/2;
	}
	return [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:[self alphaComponent]];
}

@end
