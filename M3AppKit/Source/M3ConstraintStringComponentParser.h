/*****************************************************************
 M3ConstraintStringComponentParser.h
 M3AppKit
 
 Created by Martin Pilkington on 03/09/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

@class M3ConstraintStringComponent;

@interface M3ConstraintStringComponentParser : NSObject

- (M3ConstraintStringComponent *)componentFromString:(NSString *)aComponentString;

@end
