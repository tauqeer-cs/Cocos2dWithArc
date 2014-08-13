//
//  Protocol.h
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Protocol <NSObject>

//#define TenserLeaderBoardURL @"http://115.254.65.83:30102/TenserWebservice.asmx"
//#define TenserLeaderBoardURL @"http://alphaheuristix.com/indusnettenser/TenserWebservice.asmx"
#define TenserLeaderBoardURL @"http://alphaheuristix.com/TenserWebservice.asmx"
#define AlertTitle @"Tenser"
#define ConnectionUnavailable @"Internet connection not available."
#define RegistrationUnSuccessfullAlert @"Registration Unsuccessful."
#define CHANGE_BY_LEVEL 0
#define DEFAULT_TENSION_VALUE 4
#define SMILEY_TAG_VALUE 10
#define TENSION_VALUE_FOR_CHANGE_LEVEL 99
#define FROWNY_TAG_VALUE 12
#define PLUS_SIGN_TAG_VALUE 11
#define SPRITE_TYPE_NUMBER 1
#define SPRITE_TYPE_SMILEY 2
#define SPRITE_TYPE_PLUS   3
#define SPRITE_TYPE_FROWNY 4
#define FREE_VERSION_SCORE 4995
#define MAX_POINT_LIMIT_IN_FREEVERSION 5000

#define FREE_VERSION @"isFree"

#define isLITE YES






@end
