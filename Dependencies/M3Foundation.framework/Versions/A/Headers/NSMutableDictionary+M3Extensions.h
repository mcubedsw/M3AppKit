/*****************************************************************
 NSMutableDictionary+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 15/04/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 This category adds methods to safely set objects
 @since M3Foundation 1.0 or later
*/
@interface NSMutableDictionary (M3Extensions)

/**
 Adds an object to the dictionary, ignoring nil if passed in as the object
 @param aObject The object to add
 @param aKey The key to use for the object
 @since M3Foundation 1.0 or later
*/
- (void)m3_safeSetObject:(id)aObject forKey:(id)aKey;

@end
