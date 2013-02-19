/*****************************************************************
 M3ConstraintStringComponentTokeniser.h
 M3AppKit
 
 Created by Martin Pilkington on 18/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Foundation/Foundation.h>

@interface M3ConstraintStringComponentTokeniser : NSObject

+ (instancetype)tokeniseString:(NSString *)aString;

- (id)initWithString:(NSString *)aString;
- (void)tokenise;

@property (readonly) NSString *string;

@property (readonly) NSString *keypathString;
@property (readonly) NSString *attributeString;
@property (readonly) NSString *multiplierString;
@property (readonly) NSString *constantString;

@end
