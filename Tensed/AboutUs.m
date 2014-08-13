//
//  AboutUs.m
//  TENSER
//
//  Created by Mac Mini 4 on 30/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutUs.h"
#import "Home.h"

@implementation AboutUs
@synthesize _Menu;
@synthesize _backgroundAbout;
@synthesize menuAbout;



+(CCScene *)scene{
    CCScene *scene=[CCScene node];
    AboutUs *about=[AboutUs node];
    
    [scene addChild:about];
    
    return scene;
    
}

-(id)init
{
    if (self=[super init]) 
    {
        CGSize winsize=[[CCDirector sharedDirector]winSize];
        
        if([[CCDirector sharedDirector] winSize].height == 568){
                    _backgroundAbout = [CCSprite spriteWithFile:@"testabout5.png"];
        }
        else{
                    _backgroundAbout = [CCSprite spriteWithFile:@"testabout.png"];
        }

        
        _backgroundAbout.position=ccp([[CCDirector sharedDirector] winSize].width/2.0, [[CCDirector sharedDirector] winSize].height/2.0);
        
        [self addChild:_backgroundAbout];
        
        _Menu = [CCMenuItemImage itemFromNormalImage:@"menu.png" selectedImage:@"menu.png"target:self selector:@selector(goToHomeFromAbout:)];
        _Menu.position = ccp(winsize.width/2-160, winsize.height/2-370);
        menuAbout=[CCMenu menuWithItems:_Menu, nil];
        [self addChild:menuAbout];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"by" fontName:@"Arial" fontSize:20];
        label.position = ccp(60,280);
        label.color = ccc3(255, 255, 255);
        //[self addChild:label];
        
        CCSprite *_sprite = [CCSprite spriteWithFile:@"about-logo.png"];
        _sprite.position = ccp(180, 280);
        //[self addChild:_sprite];
        
        CCLabelTTF *Version = [CCLabelTTF labelWithString:@"Version 2.0" fontName:@"Arial" fontSize:20];
        Version.position = ccp(160, 210);
        [self addChild:Version];
    }
    return self;
}

-(void)goToHomeFromAbout:(CCMenuItem *)sender
{
    [[CCDirector sharedDirector] replaceScene:[Home scene]];
}


@end
