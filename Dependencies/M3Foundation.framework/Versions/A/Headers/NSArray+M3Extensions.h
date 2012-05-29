/*****************************************************************
 NSArray+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 10/09/2006.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 This category adds some useful class methods for generating and accessing arrays.
 @since M3Foundation 1.0 and later
*/
@interface NSArray (M3Extensions)

/**
 Creates and returns an array with strings for 0-9 a-z.
 @result An array containing strings for 0-9, a-z.
 @since M3Foundation 1.0 and later
*/
+ (NSArray *)m3_alphaNumericArray;

/**
 Creates and returns an array or NSNumber objects from minValue to maxValue in integer steps.
 @param aMaxValue The maximum value in the array
 @param aMinValue The minimum value in the array
 @result An array containing NSNumbers for the supplied values, or nil on error.
@since M3Foundation 1.0 and later
*/
+ (NSArray *)m3_arrayWithNumbersFrom:(NSInteger)aMinValue to:(NSInteger)aMaxValue;

/**
 A safer version of objectAtIndex: which returns nil for an out of bounds index.
 @param aIndex The index of the object to retrieve 
 @result The object at the supplied index, or nil if the index is out of bounds
 @since M3Foundation 1.0 and later
*/
- (id)m3_safeObjectAtIndex:(NSUInteger)aIndex;

/**
 Returns the first object in the array that satisfies the test
 @param aTest A block to implement the test
 @return The first object matching the test
 @since M3Foundation 1.0 or later
*/
- (id)m3_objectPassingTest:(BOOL (^)(id aObject))aTest;

@end