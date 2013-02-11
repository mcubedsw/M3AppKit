/*****************************************************************
 NSColor+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 20/05/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 This category adds methods for dealing with hex strings, converting to strings for saving and adjusting the colour
 @since M3AppKit 1.0 and later
 */
@interface NSColor (M3Extensions) 

/**
 Creates and returns a colour from the supplied 3 or 6 character hexadeicmal string
 Accepts 3 or 6 characters hexadecimal strings, with or without a hash at the beginning
 @param hexCode The hex string
 @result A newly initialised NSColor object
 @since M3AppKit 1.0 and later
 */
+ (instancetype)m3_colorWithHexadecimalString:(NSString *)hexCode;

/**
 Returns the hexidecimal string equivalent for the colour
 @result Returns a 6 character hexadecimal string (without a hash prefixed)
 @since M3AppKit 1.0 and later
 */
- (NSString *)m3_hexadecimalString;

/**
 Converts the colour to a string, ideal for saving to a plist
 Pass the result of this string to colorWithString to get the original colour back
 @result Returns a string for the current colour in the format: red/green/blue/alpha
 @since M3AppKit 1.0 and later
 */
- (NSString *)m3_colorString;

/**
 Creates and returns a colour from the supplied string
 Accepts strings in the format red/green/blue/alpha eg white is 1.0/1.0/1.0/1.0
 @param string The colour string
 @result A newly initialised NSColor object
 @since M3AppKit 1.0 and later
 */
+ (instancetype)m3_colorWithString:(NSString *)string;

/**
 Creates and returns a colour that is lighter or darker than the receiver
 This is effectively a convenience method modifying a colour's brightness attribute. If the brightness after adjustment is below 0.0 it will be 
 interpreted as 0.0, and if above 1.0 will be interpreted as 1.0
 @param aBrightness The amount to adjust the brightness by.
 @result An NSColor object that is lighter or darker than the receiver. If the supplied value is 0, this merely returns the receiver.
 @since M3AppKit 1.0 and later
 */
- (NSColor *)m3_colourByAdjustingBrightness:(CGFloat)aBrightness;

/**
 Creates and returns a colour with a higher or lower hue than the receiver
 This is effectively a convenience method modifying a colour's hue attribute. If the hue after adjustment is below 0.0 it will be
 interpreted as 0.0, and if above 1.0 will be interpreted as 1.0
 @param aHue The amount to adjust the hue by.
 @result An NSColor object that is lighter or darker than the receiver. If the supplied value is 0, this merely returns the receiver.
 @since M3AppKit 1.0 and later
 */
- (NSColor *)m3_colourByAdjustingHue:(CGFloat)aHue;

/**
 Creates and returns a colour that is more or less saturated than the receiver
 This is effectively a convenience method modifying a colour's saturation attribute. If the saturation after adjustment is below 0.0 it will be 
 interpreted as 0.0, and if above 1.0 will be interpreted as 1.0
 @param aSaturation The amount to adjust the saturation by.
 @result An NSColor object that is more of less saturated than the receiver. If the supplied value is 0, this merely returns the receiver.
 @since M3AppKit 1.0 and later
 */
- (NSColor *)m3_colourByAdjustingSaturation:(CGFloat)aSaturation;

@end
