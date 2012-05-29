/*****************************************************************
 NSString+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 09/09/2006.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 This category adds some convienience methods to NSString
 @since M3Foundation 1.0 and later
*/
@interface NSString (M3Extensions) 

/**
 Returns a string with the specified number of characters removed from the end
 @param aNumber The number of characters to be removed from the end of the string
 @result Returns an NSString object with with the specified number of characters are removed
 @since M3Foundation 1.0 and later
*/
- (NSString *)m3_stringByRemovingCharactersFromEnd:(NSUInteger)aNumber;

/**
 Finds whether the string contains the supplied substring
 @param aSubString The string to test for
 @result Returns true if the string contains subString
 @since M3Foundation 1.0 and later
*/
- (BOOL)m3_containsString:(NSString *)aSubString;

@end
