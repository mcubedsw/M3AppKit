/*****************************************************************
 M3ConstraintStringComponentTokeniserTests.m
 M3AppKit
 
 Created by Martin Pilkington on 18/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3ConstraintStringComponentTokeniserTests.h"
#import "M3ConstraintStringComponentTokeniser.h"

@implementation M3ConstraintStringComponentTokeniserTests

- (void)test_storesSuppliedString {
	M3ConstraintStringComponentTokeniser *tokeniser = [[M3ConstraintStringComponentTokeniser alloc] initWithString:@"foobar"];
	
	assertThat(tokeniser.string, is(equalTo(@"foobar")));
}

- (void)test_stripsWhitespaceFromSuppliedString {
	M3ConstraintStringComponentTokeniser *tokeniser = [[M3ConstraintStringComponentTokeniser alloc] initWithString:@"foobar + baz\tpossum"];
	
	assertThat(tokeniser.string, is(equalTo(@"foobar+bazpossum")));
}

- (void)test_findsSimpleKeypathString {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"$view.attribute"];
	
	assertThat(tokeniser.keypathString, is(equalTo(@"view")));
}

- (void)test_findsComplexKeypathString {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"$view.key.path.attribute"];
	
	assertThat(tokeniser.keypathString, is(equalTo(@"view.key.path")));
}

- (void)test_findsKeypathStringInBrackets {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"($view.key.path.attribute)"];
	
	assertThat(tokeniser.keypathString, is(equalTo(@"view.key.path")));
}

- (void)test_findsAttributeString {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"$view.attribute"];
	
	assertThat(tokeniser.attributeString, is(equalTo(@"attribute")));
}

- (void)test_findsAttributeListString {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"$view.(top, bottom)"];
	
	assertThat(tokeniser.attributeString, is(equalTo(@"(top,bottom)")));
}

- (void)test_findsAttributeStringInBrackets {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"($view.attribute)"];
	
	assertThat(tokeniser.attributeString, is(equalTo(@"attribute")));
}

- (void)test_findsAttributeListStringInBrackets {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"($view.(top,bottom))"];
	
	assertThat(tokeniser.attributeString, is(equalTo(@"(top,bottom)")));
}

- (void)test_throwsExceptionIfNoClosingBracketFound {
	M3ConstraintStringComponentTokeniser *tokeniser = [[M3ConstraintStringComponentTokeniser alloc] initWithString:@"($view.key.path.attribute"];
	
	STAssertThrows([tokeniser tokenise], @"Should throw exception whne there is no closing bracket");
}

- (void)test_throwsExceptionIfClosingBracketFoundWithNoOpeningBracket {
	M3ConstraintStringComponentTokeniser *tokeniser = [[M3ConstraintStringComponentTokeniser alloc] initWithString:@"$view.key.path.attribute)"];
	
	STAssertThrows([tokeniser tokenise], @"Should throw exception whne there is a closing bracket but no opening one");
}

- (void)test_findsPrefixMultiplier {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"25($view.attribute)"];
	
	assertThat(tokeniser.multiplierString, is(equalTo(@"25")));
}

- (void)test_findsPrefixMultiplierAndViewAttributeString {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"3.14($view.attribute)"];
	
	assertThat(tokeniser.multiplierString, is(equalTo(@"3.14")));
	assertThat(tokeniser.keypathString, is(equalTo(@"view")));
}

- (void)test_findsSuffixMultiplier {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"$view.attribute * 1.23"];
	
	assertThat(tokeniser.multiplierString, is(equalTo(@"1.23")));
}

- (void)test_throwsExceptionIfSuffixMultiplierFoundAfterFindingPrefixMultiplier {
	STAssertThrows([M3ConstraintStringComponentTokeniser tokeniseString:@"42($view) * 1.23"], @"Shoulw throw exception when there are prefix and suffix multipliers");
}

- (void)test_findsSimpleConstant {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"+ 42"];
	
	assertThat(tokeniser.constantString, is(equalTo(@"42")));
}

- (void)test_findsNegativeConstant {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"- 31"];
	
	assertThat(tokeniser.constantString, is(equalTo(@"-31")));
}

- (void)test_numberWithoutPrefixIsConstantAndNotMultiplier {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"16"];
	
	assertThat(tokeniser.constantString, is(equalTo(@"16")));
	assertThat(tokeniser.multiplierString, is(equalTo(@"")));
}

- (void)test_findsConstantList {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"(1, 2, -, 3)"];
	
	assertThat(tokeniser.constantString, is(equalTo(@"(1,2,-,3)")));
	assertThat(tokeniser.keypathString, is(equalTo(@"")));
	assertThat(tokeniser.multiplierString, is(equalTo(@"")));
}

- (void)test_tokenisesFullString {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"25.5($view.attribute) + 60.2"];
	
	assertThat(tokeniser.constantString, is(equalTo(@"60.2")));
	assertThat(tokeniser.keypathString, is(equalTo(@"view")));
	assertThat(tokeniser.attributeString, is(equalTo(@"attribute")));
	assertThat(tokeniser.multiplierString, is(equalTo(@"25.5")));
}

- (void)test_tokenisesFullStringWithAttributeList {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:@"1.23($view.(top, bottom)) + 5"];
	
	assertThat(tokeniser.constantString, is(equalTo(@"5")));
	assertThat(tokeniser.keypathString, is(equalTo(@"view")));
	assertThat(tokeniser.attributeString, is(equalTo(@"(top,bottom)")));
	assertThat(tokeniser.multiplierString, is(equalTo(@"1.23")));
}

- (void)test_throwsExceptionForAnyMissingBracket {
	STAssertThrows([M3ConstraintStringComponentTokeniser tokeniseString:@"($view.(foo,bar) + 5]"], @"Should throw");
	STAssertThrows([M3ConstraintStringComponentTokeniser tokeniseString:@"$view.(foo,bar + 5]"], @"Should throw");
	STAssertThrows([M3ConstraintStringComponentTokeniser tokeniseString:@"$view.(foo,bar) + (5,4,3]"], @"Should throw");
}

@end
