//
//  Settings.h
//  TENSER
//
//  Created by Arijit Da on 26/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AppDelegate.h"
#import "GameState.h"

@interface Settings : CCLayer<UITextFieldDelegate,UIAlertViewDelegate> {
    
    CCSprite *back_bar;
    CCSprite *meter;
    CCSprite *tad;
    UITextField *Name;
    float oldtouch;
    int tadmove;
    CCSprite *Your_name;
    GameState *objGamestate;
    NSInteger currentposition;
    float oldposition;
    NSInteger tensionValue;
    UIAlertView *alert;
    NSInteger Touch_Start;
    NSInteger Touch_End;
    BOOL isTouchSwipe;
    
    BOOL isTextfieldFocused;
    
    CGPoint lastTadTouchPosition;
}

@property(nonatomic,retain)CCSprite *back_bar;
@property(nonatomic,retain)CCSprite *meter;
@property(nonatomic,retain)CCSprite *tad;
@property(nonatomic,retain)UITextField *Name;
@property(nonatomic,readwrite)int tadmove;
@property(nonatomic,retain)CCSprite *Your_name;
@property(nonatomic,retain)GameState *objGamestate;
@property(nonatomic,readwrite)NSInteger tensionValue;
@property(nonatomic,retain)UIAlertView *alert;



+(CCScene *)scene;
-(void)StartTime;

@end

