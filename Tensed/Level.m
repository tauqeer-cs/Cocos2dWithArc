//
//  Level.m
//  TENSER
//
//  Created by Mac Mini 4 on 24/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Level.h"
#import "GameLayer.h"
#import "Home.h"
#import "AppDelegate.h"


@implementation Level
@synthesize label;
@synthesize Background;
@synthesize nextLevelButton;
@synthesize changeMenu;
@synthesize homebutton;
@synthesize Menu;
@synthesize quitbutton;
@synthesize replaybutton;
@synthesize obj_numbersprite;
@synthesize storedlevel;
@synthesize LevelType;

AppController *app;
GameLayer *obj_gamelayer;
GameState *obj_gamestate;
+(CCScene *) scene:(NSInteger)LevelType
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Level *layer = [Level node];
	layer.LevelType=LevelType;
    [layer DesignLevelScreen];    
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super initWithColor:ccc4(195, 255, 125, 255)])) 
    { 
        app = [[UIApplication sharedApplication] delegate];
        //        [self DesignLevelScreen];
        
        //[self schedule:@selector(CallSoap) interval:1];
        
    }
	return self;
}


-(void)CallSoap{
    
    GameLayer *objGame = app.gameLayer_obj;
    
    if (objGame==nil) {
        CCLOG(@"NULL POINTER");
        return;
    }
    
    //obj_gamelayer = [[GameLayer alloc] init];
    NSLog(@"%@",app.ProfileName);
    NSLog(@"%d",objGame.Score_Sum);
    NSLog(@"%d",app.Timer);
    NSLog(@"%ld",app.Time_difference);
    
    
#ifdef VERSION_TENSERFREE
    if(app.LevelNumber==2)
    {
        [objGame makeGridNil];
        [objGame TimeDifferenceForScorePost];
        [objGame SetInsertDetails:app.ProfileName TensionValue:(app.isChangeValue==YES?TENSION_VALUE_FOR_CHANGE_LEVEL: app.Timer) TotalScore:objGame.Score_Sum TimeInterval:app.Time_difference];
    }
#endif
#ifdef VERSION_TENSER
    if(app.LevelNumber==4)
    {
        [objGame makeGridNil];
        [objGame TimeDifferenceForScorePost];
        [objGame SetInsertDetails:app.ProfileName TensionValue:(app.isChangeValue==YES?TENSION_VALUE_FOR_CHANGE_LEVEL: app.Timer) TotalScore:objGame.Score_Sum TimeInterval:app.Time_difference];
    }
#endif
}

-(void)DesignLevelScreen
{
    if (self.LevelType==1) 
    {
        Background=[CCSprite spriteWithFile:@"level-clear-bg.png"];
        Background.position=ccp(160, 240);
        [self addChild:Background];
        nextLevelButton=[CCMenuItemImage itemFromNormalImage:@"gotonext-level-deselect.png" selectedImage:@"gotonext-level-select.png" target:self selector:@selector(goToNextLevel:)];
        nextLevelButton.position=ccp(Background.contentSize.width/2,Background.contentSize.height/2+30);                
        
        homebutton=[CCMenuItemImage itemFromNormalImage:@"game-over-menu-deselect.png" selectedImage:@"game-over-menu-select.png" target:self selector:@selector(goToHome:)];
        homebutton.position=ccp(Background.contentSize.width/2,Background.contentSize.height/2-40);                
        
        quitbutton = [CCMenuItemImage itemFromNormalImage:@"quit-deselect-level.png" selectedImage:@"quit-select-level.png" target:self selector:@selector(goToHomewhenQuit:)];
        quitbutton.position=ccp(Background.contentSize.width/2,Background.contentSize.height/2-110);                
        
        changeMenu=[CCMenu menuWithItems:nextLevelButton,homebutton,quitbutton,nil];
        changeMenu.position=CGPointZero;
        [Background addChild:changeMenu];        
    }
    else if (self.LevelType==2) 
    {
        
        Background=[CCSprite spriteWithFile:@"game-over-bg.png"];
        Background.position=ccp(160, 240);
        [self addChild:Background];
        replaybutton = [CCMenuItemImage itemFromNormalImage:@"reset-deselect.png" selectedImage:@"reset-select.png" target:self selector:@selector(Replay:)];
        replaybutton.position = ccp(Background.contentSize.width/2, Background.contentSize.height/2+30);
        
        homebutton=[CCMenuItemImage itemFromNormalImage:@"game-over-menu-deselect.png" selectedImage:@"game-over-menu-select.png" target:self selector:@selector(goToHome:)];
        homebutton.position=ccp(Background.contentSize.width/2,Background.contentSize.height/2-20);                
        
        //Menu=[CCMenu menuWithItems:homebutton,replaybutton,nil];
        Menu=[CCMenu menuWithItems:homebutton,nil];
        Menu.position=CGPointZero;
        [Background addChild:Menu];
        //[app.LastSavedGame RemoveSavedGame];
        
        //[self schedule:@selector(CallSoap) interval:0.1];
        [self CallSoap];
        
    }   
    
    
}

-(void)goToNextLevel:(CCMenuItem *)sender
{
    CCLOG(@"Clicked");
    /*
    obj_gamelayer = [[GameLayer alloc] init];
    NSLog(@"%@",app.ProfileName);
    NSLog(@"%d",obj_gamelayer.Score_Sum);
    [obj_gamelayer SetInsertDetails:app.ProfileName TotalScore:obj_gamelayer.Score_Sum];
    */
    [[CCDirector sharedDirector]replaceScene:[GameLayer scene]];
    
}

-(void)goToHome:(CCMenuItem *)sender
{
   /* obj_gamelayer = [[GameLayer alloc] init];
    NSLog(@"%@",app.ProfileName);
    NSLog(@"%d",obj_gamelayer.Score_Sum);
    [obj_gamelayer SetInsertDetails:app.ProfileName TotalScore:obj_gamelayer.Score_Sum];*/
    
    app.TotalScore = 0;
    app.LevelNumber = 1;
    app.LastLevelno = 1;
    app.LastScoreValue = 0; 
    app.LastLevelScore = 0;
    app.isChangeValue = NO;
    [[CCDirector sharedDirector] replaceScene:[Home scene]];
}

-(void)goToHomewhenQuit:(CCMenuItem *)sender
{
   /* app.TotalScore = 0;
    app.LevelNumber = 1;
    [app.LastSavedGame SavedGame:grid score:obj_gamelayer.Score_Sum lastnumberappeared:obj_numbersprite.NumberValue];
    [[CCDirector sharedDirector] replaceScene:[Home scene]];
    [app.LastSavedGame RemoveSavedGame];*/
    
    app.TotalScore = 0;
    app.LevelNumber = 1;
    app.LastLevelno = 1;
    app.LastScoreValue = 0; 
    app.LastLevelScore = 0;
    app.isChangeValue = NO;
    [[CCDirector sharedDirector] replaceScene:[Home scene]];
}

-(void)Replay:(CCMenuItem *)sender
{
    app.isReplay = YES;
    [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}


@end
