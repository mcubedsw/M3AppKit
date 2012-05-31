/*****************************************************************
 M3SplitView.h
 M3AppKit
 
 Created by Martin Pilkington on 19/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

@protocol M3SplitViewDelegate;


/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3SplitView : NSView

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (assign, getter = hasVerticalDivider, nonatomic) BOOL verticalDivider;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (copy) NSString *autosaveName;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (strong) NSColor *backgroundColour;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (unsafe_unretained) IBOutlet id delegate;


/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSView *)subviewAtIndex:(NSInteger)aIndex;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSInteger)indexOfSubview:(NSView *)aView;


/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)drawDividerInRect:(NSRect)aRect vertical:(BOOL)aVertical;

@end




/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@protocol M3SplitViewDelegate <NSObject>

@optional
/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (BOOL)splitView:(M3SplitView *)aSplitView shouldFrameChangeResizeSubviewAtIndex:(NSUInteger)aIndex;

@end