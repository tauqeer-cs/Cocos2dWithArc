//
//  AppDelegate.h
//  Tensed
//
//  Created by Tauqeer Ahmed on 8/13/14.
//  Copyright Merrycode 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"
#import "NumberSprite.h"


@class RootViewController;
@class GameState;

@interface MyNavigationController : UINavigationController <CCDirectorDelegate>
@end

@interface AppController : NSObject <UIApplicationDelegate>
{
	UIWindow *window_;
	MyNavigationController *navController_;

	CCDirectorIOS	*__unsafe_unretained director_;
    RootViewController	*viewController;
    NSInteger TotalScore;
    NSInteger ScoreLimit;
    NSMutableArray *Score_Limit;
    NSInteger LevelNumber;
    //NSInteger TensionValue;
    NSInteger Timer;
    NSInteger LastScoreValue;
    NSInteger LastLevelno;
    NSInteger LastLevelScore;
    id gameLayer;
    BOOL loadSavedGame;
    BOOL isReplay;
    GameState *LastSavedGame;
    NSInteger nember_app;
    NumberSprite *obj_numbersprite;
    NSString *ProfileName;
    NSDate *GameStartTime;
    BOOL isSoap;
    BOOL isChangeValue;
    id gameLayer_obj;
    long Time_difference;
    BOOL isFrameAnimation;
    BOOL isScorePost;
    NSInteger smileyValueStored;
    NSInteger frownyValueStored;
    int countRowForHardCodeValue;
    NSInteger SceneChangeScore;
    BOOL  PlusSign;
    
    BOOL  isTenserLite;
    
    NSMutableArray *testNumber;
    
    BOOL KeepGamePaused;
    
    NSInteger TimerPlus;
    
}


@property (readonly) MyNavigationController *navController;
@property (unsafe_unretained, readonly) CCDirectorIOS *director;

@property(nonatomic,readwrite)BOOL KeepGamePaused;
@property (nonatomic , readwrite)int countRowForHardCodeValue;

//@property(nonatomic,readwrite)NSInteger TensionValue;
@property(nonatomic,retain)GameState *LastSavedGame;
@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, readwrite)NSInteger TotalScore;
@property (nonatomic, readwrite)NSInteger ScoreLimit;
@property (nonatomic, retain)NSMutableArray *Score_Limit;
@property (nonatomic, readwrite)NSInteger LevelNumber;
@property (nonatomic, readwrite)NSInteger Timer;
@property (nonatomic, readwrite)NSInteger LastScoreValue;
@property (nonatomic, readwrite)NSInteger LastLevelno;

@property (nonatomic , retain)id gameLayer;
@property (nonatomic , readwrite)BOOL loadSavedGame;
@property (nonatomic, readwrite)BOOL isReplay;
@property (nonatomic,retain)NSString *ProfileName;
@property (nonatomic,readwrite)BOOL isSoap;

@property (nonatomic , retain)id gameLayer_obj;
@property (nonatomic , readwrite)NSInteger LastLevelScore;
@property (nonatomic, readwrite)BOOL isChangeValue;
@property (nonatomic , retain) NSDate *GameStartTime;
@property (nonatomic , readwrite) long Time_difference;
@property (nonatomic , readwrite) BOOL isFrameAnimation;
@property (nonatomic , readwrite) BOOL isScorePost;
@property (nonatomic , readwrite) NSInteger smileyValueStored;
@property (nonatomic , readwrite) NSInteger SceneChangeScore;

@property (nonatomic , readwrite) BOOL  PlusSign;
@property (nonatomic , readwrite) BOOL  isTenserLite;

@property (nonatomic , retain) NSMutableArray *testNumber;

@property (nonatomic,readwrite) NSInteger frownyValueStored;

@property (nonatomic,readwrite) NSInteger TimerPlus;

//@property (nonatomic,readwrite)NSInteger nember_app;

//@property (nonatomic,retain)NumberSprite *obj_numbersprite;
-(void)SetAlive;


@end
