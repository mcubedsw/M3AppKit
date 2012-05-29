//
//  M3PreferencesSection.h
//  Code Collector
//
//  Created by Martin Pilkington on 15/01/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol M3PreferencesSection <NSObject>

- (NSString *)title;
- (NSImage *)image;
- (NSView *)view;

@optional
- (void)sectionWillDisplay;
@end
