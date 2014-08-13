//
//  AboutUs.h
//  TENSER
//
//  Created by Mac Mini 4 on 30/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AboutUs : CCLayer 
{
    CCMenuItemImage *_Menu;
    CCSprite *_backgroundAbout;
    CCMenu *menuAbout;
}

@property(nonatomic,retain)CCMenuItemImage *_Menu;
@property(nonatomic,retain)CCSprite *_backgroundAbout;
@property(nonatomic,retain)CCMenu *menuAbout;

+(CCScene *)scene;

@end
