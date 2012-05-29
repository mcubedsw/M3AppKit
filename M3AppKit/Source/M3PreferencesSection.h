/*****************************************************************
 M3PreferencesSection.h
 M3AppKit
 
 Created by Martin Pilkington on 15/01/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>


@protocol M3PreferencesSection <NSObject>

- (NSString *)title;
- (NSImage *)image;
- (NSView *)view;

@optional
- (void)sectionWillDisplay;
@end
