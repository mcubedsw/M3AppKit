/*****************************************************************
 NSXMLElement+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 10/05/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 This category adds some convienience methods to NSXMLElement
 @since M3Foundation 1.0 and later
*/
@interface NSXMLElement (M3Extensions)

/**
 Returns the element with the supplied name, or the first element with that name
 Equivalent to [[self elementsForName:str] objectAtIndex:0]
 @param aName The name of the element
 @result The element with the supplied name
 @since M3Foundation 1.0 and later
*/
- (NSXMLElement *)m3_elementForName:(NSString *)aName;

@end
