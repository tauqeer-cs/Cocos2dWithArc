//
//  Help.h
//  TENSER
//
//  Created by Mac Mini 4 on 30/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Help : CCLayer <UIWebViewDelegate>
{
    CCMenuItemImage *_Menu;
    CCSprite *_backgroundHelp;
    CCMenu *menuHelp;
    
    UIWebView *helpWebview;
}

@property(nonatomic,retain)CCMenuItemImage *_Menu;
@property(nonatomic,retain)CCSprite *_backgroundHelp;
@property(nonatomic,retain)CCMenu *menuHelp;
@property(nonatomic,retain)UIWebView *helpWebview;

+(CCScene *)scene;

@end
