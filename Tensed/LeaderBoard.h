//
//  LeaderBoard.h
//  TENSER
//
//  Created by Mac Mini 4 on 02/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameState.h"
#import "LoadView.h"
#import "AppDelegate.h"
@interface LeaderBoard : CCLayer <UITableViewDelegate,UITableViewDataSource>
{
    CCSprite *backgroundLeaderboard;
    CCMenuItemImage *menuItemImage;
    CCMenu *menuLeaderBoard;
    GameState *obj_Gamestate;
    NSMutableData *webdata;
    NSMutableArray *LeaderBoardArray;
    UITableView *LeaderBoardTable;
    LoadView *act_loadingView;
    UIView *view;
    CCMenuItem *TensionMenuItem;
    NSInteger Tension;
    NSInteger TensionValueChange;
}

@property(nonatomic,retain) CCSprite *backgroundLeaderboard;
@property(nonatomic,retain)CCMenuItemImage *menuItemImage;
@property(nonatomic,retain)CCMenu *menuLeaderBoard;

@property(nonatomic,retain)CCLabelTTF *Highest_Score;
@property(nonatomic,retain)GameState *obj_Gamestate;
@property(nonatomic,retain)	NSMutableArray *LeaderBoardArray;
@property(nonatomic,retain)UITableView *LeaderBoardTable;
@property(nonatomic,retain)LoadView *act_loadingView;
@property(nonatomic,retain)UIView *view;
@property(nonatomic,readwrite)NSInteger Tension;

+(CCScene *)scene;
//+(CCScene *)sceneWithLastName:(GameState*)lastName;
//-(void)LoadSavedName;
-(void)LeaderBoardURL;
//-(void)TensionImageChange:(CCMenuItem *)sender;
//-(void)AddGesture:(CCNode *)node;
//-(void) Tap:(UIGestureRecognizer*)recognizer node:(CCNode*)node;
-(void)InitialTensionImageValue;
-(void)TensionImageChangeOnClick;


@end
