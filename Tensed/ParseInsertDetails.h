//
//  ParseInsertDetails.h
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseInsertDetails : NSObject<NSXMLParserDelegate>
{
    NSInteger Resp_Code;
    NSMutableString *currentText;
    NSString *currentElementname;
}
@property(nonatomic,readwrite)NSInteger Resp_Code;
@property(nonatomic,retain)  NSMutableString *currentText;
@property(nonatomic,retain) NSString *currentElementname;
-(void)parseXMLFileAtData:(NSMutableData *)data parseError:(NSError **)error;
@end
