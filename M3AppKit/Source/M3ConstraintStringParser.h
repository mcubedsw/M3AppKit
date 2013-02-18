/*****************************************************************
 M3ConstraintStringParser.h
 M3AppKit
 
 Created by Martin Pilkington on 24/07/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Foundation/Foundation.h>

@interface M3ConstraintStringParser : NSObject

- (id)initWithSubstitutionViews:(NSDictionary *)aViews;

@property (readonly) NSDictionary *substitutionViews;

- (NSArray *)constraintsFromString:(NSString *)aString;

@end

NSDictionary *M3SubstitutionViewsWithCollection(id aCollection, NSView *aSelfView);