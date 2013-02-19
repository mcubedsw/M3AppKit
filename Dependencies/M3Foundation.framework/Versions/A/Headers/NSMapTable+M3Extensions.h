/*****************************************************************
 NSMapTable+M3Extensions.h
 M3Foundation
 
 Created by Martin Pilkington on 15/01/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Foundation/Foundation.h>

@interface NSMapTable (M3Extensions)

- (id)objectForKeyedSubscript:(id)aKey;
- (void)setObject:(id)aObject forKeyedSubscript:(id)aKey;

@end
