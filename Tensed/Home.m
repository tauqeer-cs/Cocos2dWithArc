//
//  Home.m
//  TENSER
//
//  Created by Arijit Da on 26/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Home.h"
//#import "Settings.h"
//#import "GameLayer.h"
//#import "GameState.h"
//#import "AppDelegate.h"
//#import "LeaderBoard.h"
//#import "NumberSprite.h"
//#import "Help.h"
//#import "AboutUs.h"


@implementation Home

//AppDelegate *appDelegate;
//GameLayer *obj_GameLayer;

+(CCScene *)scene{
    CCScene *scene=[CCScene node];
    Home *home=[Home node];
    
    [scene addChild:home];
    
    return scene;
    
}

-(id)init{
    if (self=[super init]) {
        
        //Add Background
        
        //appDelegate = [[UIApplication sharedApplication] delegate];
        CCSprite *background;
        
        if([[CCDirector sharedDirector] winSize].height == 568){
            background=[CCSprite spriteWithFile:@"menu-page5.png"];
        }
        else{
        background=[CCSprite spriteWithFile:@"menu-page.png"];//-568h
        }
            

     
        background.position=ccp([[CCDirector sharedDirector] winSize].width/2.0, [[CCDirector sharedDirector] winSize].height/2.0);
        
        [self addChild:background];
        CGSize winsize=[[CCDirector sharedDirector]winSize];
#ifdef VERSION_TENSERFREE
        Version=[CCLabelTTF labelWithString:@"Ver:2.3F" fontName:@"Marker Felt" fontSize:20];
#endif
#ifdef VERSION_TENSER
        Version=[CCLabelTTF labelWithString:@"Ver:2.3" fontName:@"Marker Felt" fontSize:20];
#endif
        
        Version.position=ccp(winsize.width/2-30,winsize.height/2+160);
        Version.color=ccc3(255, 255, 255);
        //[background addChild:Version];
        
        //Add Menu
        CCMenuItem *ContinueGame=[CCMenuItemImage itemFromNormalImage:@"test.png" selectedImage:@"test.png" target:self selector:@selector(ContinueGame:)];
        
        
        CCMenuItem *NewGame=[CCMenuItemImage itemFromNormalImage:@"new-game  deselect.png" selectedImage:@"new-game-select.png" target:self selector:@selector(NewGame:)];
        
        
        CCMenuItem *LeaderBoard=[CCMenuItemImage itemFromNormalImage:@"leader-board.png" selectedImage:@"leader-board-select.png" target:self selector:@selector(LeaderBoard:)];
        
        
        CCMenuItem *About=[CCMenuItemImage itemFromNormalImage:@"about-deselect.png" selectedImage:@"about-select.png" target:self selector:@selector(About:)];
        
        
        CCMenuItem *Help=[CCMenuItemImage itemFromNormalImage:@"help-deselect.png" selectedImage:@"help-select.png" target:self selector:@selector(Help:)];
        
        
        CCMenu *menu;
        
        //if (appDelegate.LastSavedGame.LastSavedGameExists==YES) {
        if (1 == 1){
            NewGame.position=ccp(10, 210);
            ContinueGame.position=ccp(10, 155);
            
            LeaderBoard.position=ccp(10, 95);
            About.position=ccp(10, -20);
            Help.position=ccp(10, 38);
            menu=[CCMenu menuWithItems:NewGame,ContinueGame,LeaderBoard,About,Help, nil];
        }
        else{
            NewGame.position=ccp(10, 210);
            LeaderBoard.position=ccp(10, 155);
            About.position=ccp(10, 38);
            Help.position=ccp(10, 95);
            menu=[CCMenu menuWithItems:NewGame,LeaderBoard,About,Help, nil];

        }
        menu.position=ccp(150, 100);
        [self addChild:menu];
        
        
    }
    return self;
    
}

-(void)ContinueGame:(CCMenuItem *)sender
{
    NSLog(@"Tapped");
    //AppDelegate *app=[[UIApplication sharedApplication ]delegate];
    
    /*
    if (app.LastSavedGame.LastSavedGameExists==YES)
    {
        Settings *obj_Settings = [[Settings alloc] init];
        //app.Timer = obj_Settings.tensionValue;
        //NSLog(@"%d",app.Timer);
        [obj_Settings.Name removeFromSuperview];
        //[[CCDirector sharedDirector] resume];
        [[CCDirector sharedDirector]replaceScene:[GameLayer sceneWithLastGame:app.LastSavedGame]];
        //[obj_Settings release];
    }
*/

}

-(void)NewGame:(CCMenuItem *)sender
{
    /*
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GameContinue"];
    appDelegate.loadSavedGame = NO;
    appDelegate.TotalScore = 0;
    appDelegate.LevelNumber = 1;
    appDelegate.LastLevelScore = 0;
    appDelegate.isReplay=NO;
    [[CCDirector sharedDirector]replaceScene:[Settings scene]];
    */
    
}

-(void)LeaderBoard:(CCMenuItem *)sender{
    
    /*
    [[CCDirector sharedDirector]replaceScene:[LeaderBoard scene]];
     */
    
}

-(void)About:(CCMenuItem *)sender
{
    /*
    [[CCDirector sharedDirector] replaceScene:[AboutUs scene]];
     */
   
}

-(void)Help:(CCMenuItem *)sender{
    /*
    
     [[CCDirector sharedDirector] replaceScene:[Help scene]];
     
     */
    
}
@end
