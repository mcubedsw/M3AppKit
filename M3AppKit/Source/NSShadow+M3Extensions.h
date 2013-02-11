/*****************************************************************
 NSShadow+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 15/12/2009.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 Convenience methods on NSShadow
 */
@interface NSShadow (M3Extensions) 

/**
 A class method for creating a new NSShadow object
 @param aColor The color of the shadow
 @param aOffset The shadow offset
 @param aBlur The blur radius of the shadow
 @result A newly initialised NSShadow object
 @since M3AppKit 1.0 and later
 */
+ (instancetype)m3_shadowWithColor:(NSColor *)aColor offset:(NSSize)aOffset blurRadius:(CGFloat)aBlur;

@end
