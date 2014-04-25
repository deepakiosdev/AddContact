//
//  PhoneNumber.h
//  AddContact
//
//  Created by Deepak on 16/04/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhoneNumber : NSObject {
	NSString *bareNumber_;
}

@property (nonatomic, strong) NSString *bareNumber;
+ (BOOL)validPhoneNumber:(NSString *)phoneNumber;

+ (NSString *)formatPartialPhoneNumber:(NSString *)input;
+ (PhoneNumber *)phoneNumberOrNil:(NSString *)phoneNumber;
+ (NSMutableString *)strippedString:(NSString *)input;

- (NSString *)formattedPhoneNumber;
+ (NSString *)removeCountryCodeFromPhoneNumber:(NSString *)phoneNumber;

+ (void)formatPhoneNumberInTextField:(UITextField *)textField changingCharactersInRange:(NSRange)range withString:(NSString *)string;
+ (BOOL)phoneNumberStartsWithCountryCode:(NSString *)phoneNumber;
+ (NSString *)areaCodeFromNumber:(NSString *)number;
+ (BOOL)phoneNumberContainsValidAreaCode:(NSString *)phoneNumber;
+ (NSString *)strippedPhoneNumber:(NSString *)number;

@end
