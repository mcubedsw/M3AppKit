//
//  M3SplitView.h
//  M3ConstraintBasedSplitView
//
//  Created by Martin Pilkington on 19/08/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <M3Foundation/M3Foundation.h>

#if MAC_OS_X_VERSION_MAX_ALLOWED >= 1070

@protocol M3SplitViewDelegate;
@interface M3SplitView : NSView

@property (assign, getter = hasVerticalDivider, nonatomic) BOOL verticalDivider;
@property (copy) NSString *autosaveName;
@property (retain) NSColor *backgroundColour;
@property (assign) IBOutlet __weak id delegate;

- (NSView *)subviewAtIndex:(NSInteger)aIndex;
- (NSInteger)indexOfSubview:(NSView *)aView;


- (void)drawDividerInRect:(NSRect)aRect vertical:(BOOL)aVertical;

@end


@protocol M3SplitViewDelegate <NSObject>

@optional
- (BOOL)splitView:(M3SplitView *)aSplitView shouldFrameChangeResizeSubviewAtIndex:(NSUInteger)aIndex;

@end

#endif