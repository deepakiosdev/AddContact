//
//  PhoneNumber.m
//  AddContact
//
//  Created by Deepak on 16/04/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

#import "PhoneNumber.h"
static NSString * const kUSCountryCode = @"1";


@interface PhoneNumber ()

#define kUSACountryCode @"+1"


- (id)initWithPhoneNumber:(NSString *)phoneNumber;

@end


@implementation PhoneNumber

@synthesize bareNumber = bareNumber_;

+ (NSString *)formatPartialPhoneNumber:(NSString *)input
{
	NSMutableString *formattedPhoneNumber = [PhoneNumber strippedString:input];
    
	if (formattedPhoneNumber.length > 6)
	{
		[formattedPhoneNumber insertString:@"-" atIndex:6];
	}
    
	if (formattedPhoneNumber.length > 3)
	{
		[formattedPhoneNumber insertString:@")" atIndex:3];
	}
	if (formattedPhoneNumber.length > 4)
	{
		[formattedPhoneNumber insertString:@" " atIndex:4];
	}
    
	if (formattedPhoneNumber.length > 0)
	{
		[formattedPhoneNumber insertString:@"(" atIndex:0];
	}
    
	return formattedPhoneNumber;
}

+ (PhoneNumber *)phoneNumberOrNil:(NSString *)phoneNumber
{
	if (![phoneNumber length])
	{
		// Silence warnings when constructing NSScanner with 0-length string.
		return nil;
	}
    
	NSMutableString *strippedString = [PhoneNumber strippedString:phoneNumber];
	if ([self validPhoneNumber:strippedString])
	{
		return [[PhoneNumber alloc] initWithPhoneNumber:strippedString];
	}
    
	return nil;
}

+ (NSString *)strippedString:(NSString *)input
{
	NSMutableString *strippedString = [NSMutableString stringWithCapacity:input.length];
    
	NSScanner *scanner = [NSScanner scannerWithString:input];
	NSCharacterSet *numbers = [NSCharacterSet
							   characterSetWithCharactersInString:@"0123456789"];
    
	while ([scanner isAtEnd] == NO)
	{
		NSString *buffer;
		if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
		{
			[strippedString appendString:buffer];
		}
		else
		{
			[scanner setScanLocation:([scanner scanLocation] + 1)];
		}
	}
    
	return strippedString;
}

+ (BOOL)validPhoneNumber:(NSString *)phoneNumber
{
	if (([PhoneNumber phoneNumberStartsWithCountryCode:phoneNumber] && [phoneNumber length] == 11) || ([phoneNumber length] == 10))
	{
		return YES;
	}
    
	return NO;
}

#pragma mark init method

- (id)initWithPhoneNumber:(NSString *)phoneNumber
{
	self = [super init];
    
	if (self)
	{
		self.bareNumber = phoneNumber;
	}
    
	return self;
}

- (NSString *)formattedPhoneNumber
{
    if (self.bareNumber.length >10 ) {
        self.bareNumber = [bareNumber_ substringFromIndex:1];
    }
	return [NSString stringWithFormat:@"(%@) %@-%@",
			[self.bareNumber substringToIndex:3],
			[self.bareNumber substringWithRange:NSMakeRange(3, 3)],
			[self.bareNumber substringFromIndex:6]];
}

// Remove Country code from Phone number
+ (NSString *)removeCountryCodeFromPhoneNumber:(NSString *)phoneNumber
{
	// +1 Country code for USA and Canada
	if (phoneNumber.length > 2)
	{
		NSArray *countryCodeArray = [[NSArray alloc] initWithObjects:kUSACountryCode, nil];
		for (NSString *countryCode in countryCodeArray)
		{
			NSString *countryCodeInPhone = [NSString stringWithFormat:@"%@",
											[phoneNumber substringToIndex:countryCode.length]];
            
			if ([countryCode isEqualToString:countryCodeInPhone])
			{
				phoneNumber =  [NSString stringWithFormat:@"%@", [phoneNumber substringFromIndex:countryCode.length]];
                
                
				return phoneNumber = phoneNumber.length > 6 ? [NSString stringWithFormat:@"(%@) %@-%@",
															   [phoneNumber substringWithRange:NSMakeRange(0, 3)],
															   [phoneNumber substringWithRange:NSMakeRange(3, 3)],
															   [phoneNumber substringFromIndex:6]] : phoneNumber;
                
				break;
			}
		}
	}
	return phoneNumber = phoneNumber.length > 8 ? [NSString stringWithFormat:@"%@ (%@) %@-%@",
												   [phoneNumber substringToIndex:2],
												   [phoneNumber substringWithRange:NSMakeRange(2, 3)],
												   [phoneNumber substringWithRange:NSMakeRange(5, 3)],
												   [phoneNumber substringFromIndex:8]] : phoneNumber;
}



+ (void)formatPhoneNumberInTextField:(UITextField *)textField changingCharactersInRange:(NSRange)range withString:(NSString *)string
{
    NSLog(@"textField.text:%@, \n textField.text.lenght:%d \n range.length:%d, \n range.location:%d, \n string:%@",textField.text, textField.text.length ,range.length,range.location ,string);

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"newString:%@",newString);
    if (string.length == 0)
    {
        textField.text = newString;
        return;
    }
    NSString *phoneNumber = [self strippedPhoneNumber:newString];
    NSLog(@"phoneNumber:%@",phoneNumber);

    NSInteger phoneNumberLength = [phoneNumber length];
    
    BOOL shouldAdjustTextCaret = NO;
    NSInteger caretOffset;
    
    NSMutableString *formattedPhoneNumber = [[NSMutableString alloc] init];
    NSInteger index = 0;
    
    if ([self phoneNumberStartsWithCountryCode:phoneNumber])
    {
        [formattedPhoneNumber appendString:kUSCountryCode];
        index += 1;
    }
    NSLog(@"index:%d, formattedPhoneNumber:%@",index,formattedPhoneNumber);

    if (phoneNumberLength - index >= 3)
    {
        NSString *areaCode = [phoneNumber substringWithRange:NSMakeRange(index, 3)];
        [formattedPhoneNumber appendFormat:@" (%@) ", areaCode];
        index += 3;
        NSLog(@"index:%d, formattedPhoneNumber:%@",index,formattedPhoneNumber);
    }

    else if ((phoneNumberLength - index > 0) && (phoneNumberLength - index < 3))
    {
        NSString *areaCode = [phoneNumber substringFromIndex:index];
        NSString *paddedAreaCode = [areaCode stringByPaddingToLength:3 withString:@" " startingAtIndex:0];
        [formattedPhoneNumber appendFormat:@" (%@) ", paddedAreaCode];
        index += 3;
        
        if ([string isEqualToString:@""])
        {
            caretOffset = range.location;
        }
        else if (NSLocationInRange(range.location, NSMakeRange(3, 3)))
        {
            caretOffset = range.location + 1;
        }
        else
        {
            caretOffset = range.location + 3;
        }
        
        shouldAdjustTextCaret = YES;

    }
    NSLog(@"index:%d, formattedPhoneNumber:%@",index,formattedPhoneNumber);

    if (phoneNumberLength - index > 3)
    {
        NSString *prefix = [phoneNumber substringWithRange:NSMakeRange(index, 3)];
        [formattedPhoneNumber appendFormat:@"%@-", prefix];
        index += 3;

    }
    NSLog(@"index:%d, formattedPhoneNumber:%@",index,formattedPhoneNumber);

    if (index < phoneNumberLength)
    {
        NSString *remainder = [phoneNumber substringFromIndex:index];
        [formattedPhoneNumber appendString:remainder];
    }
    NSLog(@"index:%d, formattedPhoneNumber:%@",index,formattedPhoneNumber);

    textField.text = formattedPhoneNumber;
    
    if (shouldAdjustTextCaret)
    {
        UITextPosition *start = [textField positionFromPosition:[textField beginningOfDocument] offset:caretOffset];
        UITextPosition *end = [textField positionFromPosition:start offset:0];
        UITextRange *caretRange = [textField textRangeFromPosition:start toPosition:end];
        
        textField.selectedTextRange = caretRange;
        
    }
    NSLog(@"index:%d, formattedPhoneNumber:%@",index,formattedPhoneNumber);

}

+ (BOOL)phoneNumberStartsWithCountryCode:(NSString *)phoneNumber
{
    // A 1 in the first character position indicates the country code for the US
    return ([phoneNumber length] == 0) ? NO : [[phoneNumber substringToIndex:1] isEqualToString:kUSCountryCode];
}

+ (BOOL)phoneNumberContainsValidAreaCode:(NSString *)phoneNumber
{
    NSString *areaCode = [self areaCodeFromNumber:phoneNumber];
    NSInteger firstDigit = [[areaCode substringToIndex:1] integerValue];
    
    return (firstDigit >= 2 && firstDigit <= 9);
}

+ (NSString *)areaCodeFromNumber:(NSString *)number
{
    return [number substringWithRange:NSMakeRange(1, 3)];
}

+ (NSString *)strippedPhoneNumber:(NSString *)number
{
    NSMutableString *strippedString = [NSMutableString stringWithCapacity:number.length];
    
	NSScanner *scanner = [NSScanner scannerWithString:number];
	NSCharacterSet *numbers = [NSCharacterSet
							   characterSetWithCharactersInString:@"0123456789"];
    
	while ([scanner isAtEnd] == NO)
	{
		NSString *buffer;
		if ([scanner scanCharactersFromSet:numbers intoString:&buffer])
		{
			[strippedString appendString:buffer];
		}
		else
		{
			[scanner setScanLocation:([scanner scanLocation] + 1)];
		}
	}
    
	return strippedString;
}
@end
