/*****************************************************************
 NSShadow+M3Extensions.m
 M3Extensions
 
 Created by Martin Pilkington on 15/12/2009.
 
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

#import "NSShadow+M3Extensions.h"


@implementation NSShadow (M3Extensions)

+ (NSShadow *)shadowWithColor:(NSColor *)color offset:(NSSize)offset blurRadius:(CGFloat)blur {
	return [self m3_shadowWithColor:color offset:offset blurRadius:blur];
}

+ (NSShadow *)m3_shadowWithColor:(NSColor *)color offset:(NSSize)offset blurRadius:(CGFloat)blur {
	NSShadow *shadow = [[NSShadow alloc] init];
	[shadow setShadowColor:color];
	[shadow setShadowOffset:offset];
	[shadow setShadowBlurRadius:blur];
	
	return [shadow autorelease];
}

@end
