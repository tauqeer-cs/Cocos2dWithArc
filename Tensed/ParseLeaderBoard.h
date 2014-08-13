//
//  ParseLeaderBoard.h
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LeaderBoardProperty.h"

@interface ParseLeaderBoard : NSObject<NSXMLParserDelegate>
{
    NSInteger Resp_Code;
    NSMutableString *currentText;
    NSString *currentElementname;
	NSMutableArray *LocalArray;
	LeaderBoardProperty *objLead;
    
}

@property(nonatomic,readwrite)NSInteger Resp_Code;
@property(nonatomic,retain)  NSMutableString *currentText;
@property(nonatomic,retain)	 NSMutableArray *LocalArray;
@property(nonatomic,retain)	 LeaderBoardProperty *objLead;
@property(nonatomic,retain) NSString *currentElementname;

-(void)parseXMLFileAtData:(NSMutableData *)data parseError:(NSError **)error;

@end
