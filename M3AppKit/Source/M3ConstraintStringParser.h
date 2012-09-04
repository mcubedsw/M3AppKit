//
//  M3ConstraintStringParser.h
//  M3AppKit
//
//  Created by Martin Pilkington on 24/07/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M3ConstraintStringParser : NSObject

+ (NSDictionary *)substitutionViewsWithCollection:(id)aCollection selfView:(NSView *)aSelfView;

- (id)initWithSubstitutionViews:(NSDictionary *)aViews;

@property (readonly) NSDictionary *substitutionViews;

- (NSArray *)constraintsFromString:(NSString *)aString;

@end
