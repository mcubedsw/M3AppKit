/*****************************************************************
 NSPredicate+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 31/03/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 Additions to NSPredicate for converting to and from XML representations
 @since M3Foundation 1.0 or later
*/
@interface NSPredicate (M3Extensions)

/**
 Creates a new predicate from an XML representation
 @param aElement The XML element at the root of the representation
 @return The predicate generated from the XML or nil if it fails
 @since M3Foundation 1.0 or later
*/
+ (NSPredicate *)m3_predicateWithXMLElement:(NSXMLElement *)aElement;

/**
 The XML representation for the predicate
 @return The root element of the XML representation
 @since M3Foundation 1.0 or later
*/
- (NSXMLElement *)m3_xmlRepresentation;

@end
