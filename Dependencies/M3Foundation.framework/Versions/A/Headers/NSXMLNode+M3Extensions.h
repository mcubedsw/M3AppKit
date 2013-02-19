/*****************************************************************
 NSXMLNode+M3Extensions.h
 M3Foundation
 
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

@end
