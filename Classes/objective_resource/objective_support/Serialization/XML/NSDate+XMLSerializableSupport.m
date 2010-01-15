//
//  NSDate+XMLSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSDate+XMLSerializableSupport.h"
#import "NSObject+XMLSerializableSupport.h"
#import "ObjectiveResourceDateFormatter.h"

@implementation NSDate (XMLSerializableSupport)

//FIXME we should have one formatter for the entire app

- (NSString *)toXMLValue {
	return [ ObjectiveResourceDateFormatter formatDate:self]; 
}

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
						withTranslations:(NSDictionary *)keyTranslations {
	return [[self class] buildXmlElementAs:rootName withInnerXml:[self toXMLValue] andType:[[self class] xmlTypeFor:self]];
}

+ (NSDate *)fromXMLDateTimeString:(NSString *)xmlString {
	return [ ObjectiveResourceDateFormatter parseDateTime:xmlString];
}

+ (NSDate *)fromXMLDateString:(NSString *)xmlString {
	return [ ObjectiveResourceDateFormatter parseDate:xmlString];
}


@end
