//
//  LeaderBoardProperty.h
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeaderBoardProperty : NSObject
{
    //NSInteger  ResponseCode;
    NSString  *UserName;
    NSInteger TensionNo;
    NSInteger  Score;
}

//@property(nonatomic,readwrite) NSInteger ResponseCode;
@property(nonatomic,retain) NSString  *UserName;
@property(nonatomic,readwrite)NSInteger TensionNo;
@property(nonatomic,readwrite) NSInteger Score;

@end
