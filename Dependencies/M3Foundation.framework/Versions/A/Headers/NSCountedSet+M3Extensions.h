/*****************************************************************
 NSCountedSet+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 11/02/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 A category to add additional operations for working with object counts
 @since M3Foundation 1.0 and later
*/
@interface NSCountedSet (M3Extensions)

/**
 Returns the objects with a certain count
 @param aCount The object count to look for
 @return A new set containing the objects with the supplied count
 @since M3Foundation 1.0 or later
*/
- (NSSet *)m3_objectsWithCount:(NSUInteger)aCount;

/**
 The total number of objects that have been added to the set
 @since M3Foundation 1.0 or later
*/
@property (readonly) NSUInteger m3_countedObjectTotal;

@end
