/*****************************************************************
 NSExpression+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 01/04/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 Additions to NSExpression for converting to and from XML representations
 @since M3Foundation 1.0 or later
*/
@interface NSExpression (M3Extensions)

/**
 Creates a new expression from an XML representation
 @param aElement The XML element at the root of the representation
 @return The expression generated from the XML or nil if it fails
 @since M3Foundation 1.0 or later
*/
+ (NSExpression *)m3_expressionFromXMLElement:(NSXMLElement *)aElement;

/**
 The XML representation for the expression
 @return The root element of the XML representation
 @since M3Foundation 1.0 or later
*/
- (NSXMLElement *)m3_xmlRepresentation;

@end
