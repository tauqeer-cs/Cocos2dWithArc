//
//  GameState.h
//  TENSER
//
//  Created by Mac Mini 4 on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberSprite.h"
#import "GameLayer.h"
#import "AppDelegate.h"
@class Settings;

@interface GameState : NSObject
{
    NSInteger LastSavedScore;
    NSInteger LastNumberAppeared;
    NSString *LastUserName;
    NSInteger LastTension;
    NSInteger LastNumberAnimationState;
    NSInteger LastLevelPlayed;
    NSInteger LastTensionSelected;
    NSInteger ScoreByLevel;
    NSInteger NumberType;
    NSInteger ColumnPosition;
    
    NSInteger savedGame;
    
    int numberalreadyappeared[6][7];
    NSMutableArray *storedArray;
    BOOL LastSavedGameExists;
    NSInteger xValue;
    NSInteger yValue;
    NSInteger lastvalue;
    CGPoint point;
    GameLayer *objgamelayer;
    
    AppController *app;
    
    //AppController
}
@property(nonatomic,readwrite)NSInteger LastTensionSelected;
@property(nonatomic,readwrite)NSInteger LastLevelPlayed;
@property(nonatomic,readwrite)NSInteger LastNumberAnimatinState;
@property(nonatomic,readwrite)BOOL LastSavedGameExists;
//@property(nonatomic,readwrite)int *numberalreadyappeared[5][7];
@property (nonatomic,readwrite) NSInteger LastSavedScore;
@property (nonatomic,readwrite) NSInteger LastNumberAppeared;
//@property (readwrite,assign)Number_t NumberData;
@property (nonatomic,retain)NSMutableArray *storedArray;
//@property (readwrite, assign) int numberalreadyappeared;

@property (nonatomic,readwrite) NSInteger xValue;
@property (nonatomic,readwrite) NSInteger yValue;
@property (nonatomic, readwrite) NSInteger lastvalue;
@property (nonatomic,readwrite) CGPoint point;
@property (nonatomic, retain) GameLayer *objgamelayer;
@property (nonatomic, retain)NSString *LastUserName;
@property (nonatomic, readwrite)NSInteger LastTension;
@property (nonatomic, readwrite)NSInteger ScoreByLevel;
@property (nonatomic, readwrite)NSInteger NumberType;
@property (nonatomic, readwrite)NSInteger ColumnPosition;
@property (nonatomic, readwrite)NSInteger savedGame;


//-(void)CopyExistingNumbers:(id)grid;
//-(void) myfunc(int *myarg,int dim1,int dim2);
-(void)myfunc:(NumberSprite *)myarg dim1:(int)dim1 dim2:(int)dim2;
-(void)LoadSavedGame;
//-(void)AddSavedGameToGamelayer:(GameLayer *)gamelayer;

-(void)AddSavedGameToGamelayer:(GameLayer *)gamelayer grid:(__strong NumberSprite *[5][7])grid;

//-(void)SavedGame:(NumberSprite *[6][7])grid score:(NSInteger)score lastnumberappeared:(NSInteger)lastnumberappeared lastappearednumberstate:(NSInteger)lastappearednumberstate lastlevelplayed:(NSInteger)lastlevelplayed lasttensionselected:(NSInteger)lasttensionselected lastusername:(NSString *)lastusername scoreByLevel:(NSInteger)scoreByLevel numberType:(NSInteger)numberType;

-(void)SavedGame:(__strong NumberSprite *[6][7])grid score:(NSInteger)score lastnumberappeared:(NSInteger)lastnumberappeared lastappearednumberstate:(NSInteger)lastappearednumberstate lastlevelplayed:(NSInteger)lastlevelplayed lasttensionselected:(NSInteger)lasttensionselected lastusername:(NSString *)lastusername scoreByLevel:(NSInteger)scoreByLevel numberType:(NSInteger)numberType columnPosition:(NSInteger)columnPosition;

-(void)RemoveSavedGame;
-(void)SavedName:(Settings *)setting Name:(NSString *)name TensionSelected:(NSInteger)tension;
-(void)GameOver:(NSString *)UserName Tension:(NSInteger)tension;
@end
