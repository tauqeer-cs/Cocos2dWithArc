    //
//  ChangeLevel.m
//  TENSER
//
//  Created by Mac Mini 4 on 12/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ChangeLevel.h"
#import "GameLayer.h"

@implementation ChangeLevel

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	ChangeLevel *layer = [ChangeLevel node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    //[layer LoadNewGame];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
        [self performSelector:@selector(MoveToGameLayerScene) withObject:nil afterDelay:0.1];
    }
    return self;
}

-(void)MoveToGameLayerScene
{
    [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

@end
