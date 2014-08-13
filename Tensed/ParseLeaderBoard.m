//
//  ParseLeaderBoard.m
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParseLeaderBoard.h"

@implementation ParseLeaderBoard
@synthesize Resp_Code;
@synthesize currentText;
@synthesize LocalArray;
@synthesize objLead;
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
	//currentText=nil;
	//LocalArray = [[NSMutableArray alloc]init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict 
{
	if([elementName isEqualToString:@"LeaderBoard"])
    {
        ;
    }
	
    else if([elementName isEqualToString:@"ResponseCode"])
    {
        currentElementname = elementName;
        currentText = [[NSMutableString alloc]init];
    }
	else if([elementName isEqualToString:@"Player"])
	{
		if([LocalArray count]==0)
        {
            LocalArray = [[NSMutableArray alloc] init];
        }
		objLead = [[LeaderBoardProperty alloc]init];
	}
    else if([elementName isEqualToString:@"UserName"])
    {
        currentElementname = elementName;
        currentText = [[NSMutableString alloc]init];
    }
    else if([elementName isEqualToString:@"TensionNo"])
    {
        currentElementname = elementName;
        currentText = [[NSMutableString alloc]init];
    }
    else if([elementName isEqualToString:@"Score"])
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
    if([elementName  isEqualToString:@"LeaderBoard"])
    {
        ;
    }
    if([elementName  isEqualToString:@"ResponseCode"])
    {
        Resp_Code = [currentText intValue];
    }
    else if([elementName  isEqualToString:@"Player"])
    {
        [LocalArray addObject:objLead];
    }
    else if([elementName  isEqualToString:@"UserName"])
    {
        objLead.UserName = currentText;
    }
    else if([elementName  isEqualToString:@"TensionNo"])
    {
        objLead.TensionNo = [currentText intValue];
    }
    else if([elementName  isEqualToString:@"Score"])
    {
        objLead.Score = [currentText intValue];
    }
}



@end
