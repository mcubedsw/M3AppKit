/*****************************************************************
 NSColor+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 20/05/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 @category NSColor(M3Extensions)
 This category adds methods for dealing with hex strings, converting to strings for saving and lightening/darkening the colour
 @since Available in M3AppKit 1.0 and later
 */
@interface NSColor (M3Extensions) 

/**
 Creates and returns a colour from the supplied 3 or 6 character hexadeicmal string
 Accepts 3 or 6 characters hexadecimal strings, with or without a hash at the beginning
 @param hexCode The hex string
 @result A newly initialised NSColor object
 @since Available in M3AppKit 1.0 and later
 */
+ (NSColor *)colorWithHexadecimalString:(NSString *)hexCode;

/**
 Returns the hexidecimal string equivalent for the colour
 @result Returns a 6 character hexadecimal string WITHOUT a hash prefixed
 @since Available in M3AppKit 1.0 and later
 */
- (NSString *)hexadecimalString;

/**
 Converts the colour to a string for saving to a plist
 Pass the result of this string to colorWithString to get the original colour back
 @result Returns a string for the current colour in the format: red/green/blue/alpha
 @since Available in M3AppKit 1.0 and later
 */
- (NSString *)colorToString;

/**
 Creates and returns a colour from the supplied string
 Accepts strings in the format red/green/blue/alpha eg white is 1.0/1.0/1.0/1.0
 @param string The colour string
 @result A newly initialised NSColor object
 @since Available in M3AppKit 1.0 and later
 */
+ (NSColor *)colorWithString:(NSString *)string;

/**
 Creates and returns a colour that is lighten units lighter than the receiver
 @param lighten A value between 0 and 1 for how much lighter you want the colour to be
 @result A newly initialised NSColor object that is lighter than the receiver
 @since Available in M3AppKit 1.0 and later
 */
- (NSColor *)lighterColourBy:(CGFloat)lighten;

/**
 Creates and returns a colour that is darken units darker than the receiver
 @param darken A value between 0 and 1 for how much lighter you want the colour to be
 @result A newly initialised NSColor object that is darker than the receiver
 @since Available in M3AppKit 1.0 and later
 */
- (NSColor *)darkerColourBy:(CGFloat)darken;

@end
