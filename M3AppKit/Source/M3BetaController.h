/*****************************************************************
 M3BetaController.h
 
 Created by Martin Pilkington on 24/10/2008.
 
 Copyright (c) 2006-2010 M Cubed Software
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 *****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 @class CLASS_HERE
 DESCRIPTION_HERE
 @since Available in M3AppKit 1.0 and later
 */
@interface M3BetaController : NSObject <NSCoding> {
	BOOL betaExpired;
	NSUInteger betaLength;
}

/**
 @property PROPERTY_NAME
 ABSTRACT_HERE
 @since Available in M3AppKit 1.0 and later
 */
@property (readonly) BOOL betaExpired;

/**
 @property PROPERTY_NAME
 ABSTRACT_HERE
 @since Available in M3AppKit 1.0 and later
 */
@property (assign) NSUInteger betaLength;


/**
 ABSTRACT_HERE
 DISCUSSION_HERE
 @param PARAM_HERE
 @param PARAM_HERE
 @result RESULT_HERE
 @since Available in M3AppKit 1.0 and later
 */
- (void)performBetaCheckWithDateString:(NSString *)aDateString;

@end
