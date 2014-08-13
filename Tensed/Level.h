//
//  Level.h
//  TENSER
//
//  Created by Mac Mini 4 on 24/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NumberSprite.h"
#import "GameState.h"

@interface Level : CCLayerColor {
    
    CCLabelTTF *label;
    CCSprite *Background;
    CCMenuItem *nextLevelButton;
    CCMenu *changeMenu;
    CCMenuItem *homebutton;
    CCMenu *Menu;
    CCMenuItem *quitbutton;
    CCMenuItem *replaybutton;
    NumberSprite *obj_numbersprite;
    BOOL storedlevel;
    NumberSprite *grid[6][7];
    
    NSInteger LevelType;  //1= Level Change 2=Game Over
}
@property(nonatomic,readwrite)NSInteger LevelType;
@property(nonatomic,retain)CCLabelTTF *label;
@property(nonatomic,retain)CCSprite *Background;
@property(nonatomic,retain)CCMenuItem *nextLevelButton;
@property(nonatomic,retain)CCMenu *changeMenu;
@property(nonatomic,retain)CCMenuItem *homebutton;
@property(nonatomic,retain)CCMenu *Menu;
@property(nonatomic,retain)CCMenuItem *quitbutton;
@property(nonatomic,retain)CCMenuItem *replaybutton;
@property(nonatomic,retain)NumberSprite *obj_numbersprite;
@property(nonatomic,readwrite)BOOL storedlevel;

+(CCScene *) scene:(NSInteger)LevelType;
//-(id)initwithScene;
-(void)goToHome:(CCMenuItem *)sender;
-(void)goToNextLevel:(CCMenuItem *)sender;
-(void)goToHomewhenQuit:(CCMenuItem *)sender;
-(void)Replay:(CCMenuItem *)sender;
-(void)DesignLevelScreen;
@end
