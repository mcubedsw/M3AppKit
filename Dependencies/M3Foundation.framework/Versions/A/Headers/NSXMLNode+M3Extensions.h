/*****************************************************************
 NSXMLNode+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 19/03/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 Extensions to NSXMLNode to simplify accessing data
 @since M3Foundation 1.0 or later
*/
@interface NSXMLNode (M3Extensions)

/**
 The integer value of the node
 @since M3Foundation 1.0 or later
*/
@property (readonly) NSInteger m3_integerValue;

/**
 The float value of the node
 @since M3Foundation 1.0 or later
*/
@property (readonly) CGFloat m3_floatValue;

/**
 Return the first matching node for an xPath
 @param aXPath The XPath to use for searching
 @param aError A point to an error
 @return The first matching XML node, or nil if an error occurs
 @since M3Foundation 1.0 or later
*/
- (NSXMLNode *)m3_nodeForXPath:(NSString *)aXPath error:(NSError **)aError;

@end
