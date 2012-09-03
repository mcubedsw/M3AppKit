//
//  M3ConstraintStringComponentParser.h
//  M3AppKit
//
//  Created by Martin Pilkington on 03/09/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

@class M3ConstraintStringComponent;

@interface M3ConstraintStringComponentParser : NSObject

- (M3ConstraintStringComponent *)componentFromString:(NSString *)aComponentString;

@end
