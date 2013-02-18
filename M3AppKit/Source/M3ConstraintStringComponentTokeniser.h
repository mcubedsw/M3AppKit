//
//  M3ConstraintStringComponentTokeniser.h
//  M3AppKit
//
//  Created by Martin Pilkington on 18/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M3ConstraintStringComponentTokeniser : NSObject

+ (instancetype)tokeniseString:(NSString *)aString;

- (id)initWithString:(NSString *)aString;
- (void)tokenise;

@property (readonly) NSString *string;

@property (readonly) NSString *viewAttributeString;
@property (readonly) NSString *multiplierString;
@property (readonly) NSString *constantString;

@end
