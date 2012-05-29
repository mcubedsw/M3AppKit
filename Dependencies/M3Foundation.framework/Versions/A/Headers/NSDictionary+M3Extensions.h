/*****************************************************************
 NSDictionary+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 17/01/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 This category adds some useful class methods for adding objects to a dictionary.
 @since M3Foundation 1.0 and later
 */
@interface NSDictionary (M3Extensions)

/**
 Creates a new dictionary by adding the supplied object and key
 @param aObject The object to add to the dictionary
 @param aKey The key for the object
 @return A new dictionary containing the supplied object and key
 @since M3Foundation 1.0 or later
*/
- (NSDictionary *)m3_dictionaryBySettingObject:(id)aObject forKey:(id<NSCopying>)aKey;

@end
