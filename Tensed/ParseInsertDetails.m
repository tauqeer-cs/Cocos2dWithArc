//
//  ParseInsertDetails.m
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParseInsertDetails.h"

@implementation ParseInsertDetails
@synthesize Resp_Code;
@synthesize currentText;
@synthesize currentElementname;


-(void)parseXMLFileAtData:(NSMutableData *)data parseError:(NSError **)error
{
	NSXMLParser *parser;
	
	parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    NSError *parseError = [parser parserError];
    if (parseError && error) 
	{
        *error = parseError;
    }
	
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    currentElementname = [[NSString alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict 
{
    if([elementName isEqualToString:@"InsertGame"])
    {
        ;
    }
	
    else if([elementName isEqualToString:@"ResponseCode"])
    {
        currentElementname = elementName;
        currentText = [[NSMutableString alloc]init];
    }

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{
	[currentText appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName 
{
    if([elementName  isEqualToString:@"InsertGame"])
    {
        ;
    }
    if([elementName  isEqualToString:@"ResponseCode"])
    {
        Resp_Code = [currentText intValue];
    }
}


@end
