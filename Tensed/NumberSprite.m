//
//  NumberSprite.m
//  TENSER
//
//  Created by Mac Mini 4 on 22/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NumberSprite.h"
#import "GameLayer.h"
#import "Level.h"
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
#import "Settings.h"

#define RANDOM_NUMBER_MAX 10
#define RANDOM_NUMBER_MIN 0
#define SMILEY_RANDOM_NUMBER_MAX 11
#define SMILEY_PLUS_RANDOM_NUMBER_MAX 12
#define FROWNY_PLUS_RANDOM_NUMBER_MAX 13
#define SWIPE_ALLOWED_FOR_SPRITE 410



@implementation NumberSprite
@synthesize digit;
@synthesize NumberValue;
@synthesize theGame;
@synthesize currentColumn;
//@synthesize RowNumber;
@synthesize curHGroup;
@synthesize curVGroup;
@synthesize rowNum;

@synthesize x_Value;
@synthesize y_Value;
@synthesize isMoved;
@synthesize SpriteType;
@synthesize walkAnim;
@synthesize number;
@synthesize spriteSheet;
@synthesize replaceSpriteSheet;
@synthesize replaceDigit;
@synthesize calculateFrame;

AppController *app;

//AppDelegate *app;

Settings *mSettings;
int i;

#pragma mark Number Appeared for New Game

-(id)initWithGame:(GameLayer *)game
{
    
    if (self=[super init]) 
    {
        [self Initialize:game];
        
    }    
    return  self;    
}



-(void)Initialize:(GameLayer *)game
{
    
    app = [[UIApplication sharedApplication] delegate];
    
    calculateFrame = YES;
    self.SpriteType=SPRITE_TYPE_NUMBER;// 1=Number, 2=Smiley, 3=+, 4= Frowny
    
    self.theGame=game; 
    self.theGame.isTouchEnabled=YES;
    self.theGame.animation_State=0;
    
    if(app.LevelNumber==1)
    {
        //number = [self Testingexplosion];
        number=[self GetRandomNumber:RANDOM_NUMBER_MAX MIN:RANDOM_NUMBER_MIN EXCLUD:100];
        self.NumberValue=number;
    }
    else if(app.LevelNumber==2)
    {
        number=[self GetRandomNumber:SMILEY_RANDOM_NUMBER_MAX MIN:RANDOM_NUMBER_MIN EXCLUD:100];
        self.NumberValue=number;
    }
    else if(app.LevelNumber==3)
    {
        number=[self GetRandomNumber:SMILEY_PLUS_RANDOM_NUMBER_MAX MIN:RANDOM_NUMBER_MIN EXCLUD:100];                     
        self.NumberValue=number;
    }
    else if(app.LevelNumber==4)
    {
        number=[self GetRandomNumber:FROWNY_PLUS_RANDOM_NUMBER_MAX MIN:RANDOM_NUMBER_MIN EXCLUD:100];
        self.NumberValue=number;
    }
    
    [self NumberSpriteAnimation];
    
    if(app.LevelNumber==2)
    {
        if(number==SMILEY_TAG_VALUE)
        {
            self.SpriteType=SPRITE_TYPE_SMILEY;
            if([self.theGame IsSmileyPresentInGrid]==NO)
            {
                number=[self GetRandomNumber:10 MIN:0 EXCLUD:100];
                app.smileyValueStored = number;
                NSLog(@"%d",app.smileyValueStored);
                
            }
            self.NumberValue=app.smileyValueStored;
            self.theGame.isSmileyAppeared = YES;
            NSLog(@"smiley Number: %d",self.NumberValue);
        }
        
    }
    
    if(app.LevelNumber==3)
    {
        if(number==SMILEY_TAG_VALUE)
        {
            self.SpriteType=SPRITE_TYPE_SMILEY;
            if([self.theGame IsSmileyPresentInGrid]==NO)
            {
                number=[self GetRandomNumber:10 MIN:0 EXCLUD:100];
                app.smileyValueStored = number;
                NSLog(@"%d",app.smileyValueStored);
                
            }
            self.NumberValue=app.smileyValueStored;
            self.theGame.isSmileyAppeared = YES;
            NSLog(@"smiley Number: %d",self.NumberValue);   
        }
        else if(number==PLUS_SIGN_TAG_VALUE)
        {
            self.SpriteType=SPRITE_TYPE_PLUS;
            self.NumberValue=1;    
        }
    }
    
    if(app.LevelNumber==4)
    {
        if(number==FROWNY_TAG_VALUE)
        {
            self.SpriteType=SPRITE_TYPE_FROWNY;
            if([self.theGame IsFrownyPresentInGrid]==NO)
            {
                number=[self GetRandomNumber:10 MIN:0 EXCLUD:100];
                if(app.smileyValueStored == number)
                {
                     number=[self GetRandomNumber:10 MIN:0 EXCLUD:app.smileyValueStored];
                }
                app.frownyValueStored = number;
                NSLog(@"%d",app.frownyValueStored);
                
            }
            self.NumberValue=app.frownyValueStored;
            self.theGame.isSmileyAppeared = YES;
            NSLog(@"frwony Number: %d",self.NumberValue);    
        }
        else if(number==PLUS_SIGN_TAG_VALUE)
        {
            self.SpriteType=SPRITE_TYPE_PLUS;
            self.NumberValue=1;    
        }
        else if(number==SMILEY_TAG_VALUE)
        {
            //SMILEY
            self.SpriteType=SPRITE_TYPE_SMILEY;
            if([self.theGame IsSmileyPresentInGrid]==NO)
            {
                number=[self GetRandomNumber:10 MIN:0 EXCLUD:100];
                if(app.frownyValueStored == number)
                {
                    number=[self GetRandomNumber:10 MIN:0 EXCLUD:app.frownyValueStored];
                }
                app.smileyValueStored = number;
                NSLog(@"%d",app.smileyValueStored);
                
            }
            self.NumberValue=app.smileyValueStored;
            self.theGame.isSmileyAppeared = YES;
            NSLog(@"smiley Number: %d",self.NumberValue);                 
            
        }
    }
    
    //CGSize winsize=[[CCDirector sharedDirector]winSize];
    self.currentColumn=3;
    NSInteger xlocation = currentColumn*45 + 45/2;
    self.digit.position=ccp(xlocation,410); // winsize.height/2+170);
    
}


-(void)NumberSpriteAnimation
{
      
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
         [NSString stringWithFormat:@"Number%d.plist",number]];
        self.spriteSheet = [CCSpriteBatchNode 
                            batchNodeWithFile:[NSString stringWithFormat:@"Number%d.png",number]];
    
    [self.theGame.background addChild:self.spriteSheet];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i = 1; i <= 30; i++) {
        //CCSpriteFrame *frame = [cache spriteFrameByName:[NSString stringWithFormat:@"%d-animation-%d.png",number,i]];
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"animation%d_%d.png",number, i]]];
    }
    //NSLog(@"%d",app.Timer);
    NSLog(@"%d",app.Timer);
    app.Timer = app.TimerPlus;
    NSLog(@"%d",app.Timer);
    walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:app.Timer];
   self.digit = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"animation%d_1.png",number]]; 
    if (walkAnim!=nil) 
    {
        CCAnimate *animate = [CCAnimate actionWithDuration:app.Timer animation:walkAnim restoreOriginalFrame:NO];
        CCRepeat *repeat = [CCRepeat actionWithAction:animate times:1];
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(RedAnimationFinished:)];
        [self.digit runAction:[CCSequence actions:repeat,actionMoveDone,nil]];
    }
    [self.spriteSheet addChild:self.digit];
}

#pragma mark Number Appeared for Saved game

//-(id)initWithGameAndNumber:(GameLayer *)game lastsavednumber:(NSInteger)lastsavednumber lastNumberState:(NSInteger)lastNumberState
-(id)initWithGameAndNumber:(GameLayer *)game lastsavednumber:(NSInteger)lastsavednumber lastNumberState:(NSInteger)lastNumberState lastSpriteType:(NSInteger)lastSpriteType
{
    if (self=[super init]) { //ARIJIT
        self.SpriteType=lastSpriteType;  // 1=Number, 2=Smiley, 3=Frowny, 4= +
        self.theGame=game; 
        //number=lastsavednumber; //[self GetRandomNumber:RANDOM_NUMBER_MAX MIN:RANDOM_NUMBER_MIN];
        if (number>=10) {
            //CCLOG(@"Invalid Number");
        }
        //self.NumberValue=number;
        NSString *FileName;
        switch (self.SpriteType) {
            case 1:
                //Number
                self.number=lastsavednumber;
                FileName= [NSString stringWithFormat:@"NumberAnim%d",number];
                break;
            case 2:
                //smiley
                self.number=SMILEY_TAG_VALUE;
                FileName= [NSString stringWithFormat:@"NumberAnim%d",number];
                break;
            case 3:
                //plus
                self.number=PLUS_SIGN_TAG_VALUE;
                FileName= [NSString stringWithFormat:@"Number%d",number];
                break;
            case 4:
                //frowny
                self.number=FROWNY_TAG_VALUE;
                FileName= [NSString stringWithFormat:@"Number%d",number];
            default:
                break;
        }

        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
         [NSString stringWithFormat:@"%@.plist",FileName,number]];
        
        
        
        spriteSheet = [CCSpriteBatchNode 
                       batchNodeWithFile:[NSString stringWithFormat:@"%@.png",FileName,number]];
        [game.background addChild:spriteSheet];
        
        
        
        
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for(int i = lastNumberState; i <= 30; i++) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"animation%d_%d.png",number, i]]];
        }
        ////NSLog(@"%d",app.Timer);
        if(lastNumberState==30)
        {
            app.Timer=0;
        }
        walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:app.Timer];
        self.digit = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"animation%d_10.png",number]]; 
        if (walkAnim!=nil) {
            ////NSLog(@"%d",app.Timer);
            CCAnimate *animate = [CCAnimate actionWithDuration:app.Timer animation:walkAnim restoreOriginalFrame:NO];
            CCRepeat *repeat = [CCRepeat actionWithAction:animate times:1];
            id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(RedAnimationFinishedAfterSaved:)];
            [self.digit runAction:[CCSequence actions:repeat,actionMoveDone,nil]];
        }
        [spriteSheet addChild:self.digit];
        self.number=lastsavednumber;
        self.NumberValue=number;
        self.currentColumn=self.theGame.Last_Column_Position;
        NSInteger xlocation = currentColumn*45 + 45/2;
        self.digit.position=ccp(xlocation,410);
        calculateFrame=YES;
                        
    }    
    return  self;    
}

//-(id)initWithGameAndNumber1:(GameLayer *)game lastsavednumber:(NSInteger)lastsavednumber RowNumber:(NSInteger)RowNumber ColumnNumber:(NSInteger)ColumnNumber

-(id)initWithGameAndNumber1:(GameLayer *)game lastsavednumber:(NSInteger)lastsavednumber RowNumber:(NSInteger)RowNumber ColumnNumber:(NSInteger)ColumnNumber number_type:(NSInteger)number_type
{    
    if (self=[super init]) { //ARIJIT
       //app.isFrameAnimation=YES;
       
        //self.SpriteType=SPRITE_TYPE_NUMBER;  // 1=Number, 2=Smiley, 3=Frowny, 4= +
        self.theGame=game; 
        self.SpriteType=number_type;
        NSString *FileName;
        switch (self.SpriteType) {
            case 1:
                //Number
                self.number=lastsavednumber;
                FileName= [NSString stringWithFormat:@"NumberAnim%d",number];
                break;
            case 2:
                //smiley
                self.number=SMILEY_TAG_VALUE;
                FileName= [NSString stringWithFormat:@"NumberAnim%d",number];
                break;
            case 4:
                //frowny
                self.number=FROWNY_TAG_VALUE;
                FileName= [NSString stringWithFormat:@"Number%d",number];
                break;
            default:
                break;
        }
        
        //number=lastsavednumber; //[self GetRandomNumber:RANDOM_NUMBER_MAX MIN:RANDOM_NUMBER_MIN];
        if (number>=10) {
            //CCLOG(@"Invalid Number");
        }
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",FileName,number]];
        
        spriteSheet = [CCSpriteBatchNode 
                       batchNodeWithFile:[NSString stringWithFormat:@"%@.png",FileName,number]];

        
        
        [game.background addChild:spriteSheet];
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for(int i = 10; i <= 30; i++) {
            [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"animation%d_%d.png",number, i]]];
        }
        //NSLog(@"%d",app.Timer);
        walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:app.Timer];
        self.digit = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"animation%d_1.png",number]]; 
        if (walkAnim!=nil) {
            //NSLog(@"%d",app.Timer);
            //CCAnimate *animate = [CCAnimate actionWithDuration:4 animation:walkAnim restoreOriginalFrame:NO];
            //CCRepeat *repeat = [CCRepeat actionWithAction:animate times:1];
            //id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(RedAnimationFinished:)];
            //[self.digit runAction:[CCSequence actions:repeat,actionMoveDone,nil]];
        }
        [spriteSheet addChild:self.digit];
        //CGSize winsize=[[CCDirector sharedDirector]winSize];
        //self.digit.position=ccp(winsize.width/2, winsize.height/2+170);
        self.currentColumn=ColumnNumber;
        self.rowNum=RowNumber;
        self.number=lastsavednumber;
        self.NumberValue=number;
        [self UpdateSpritePositionInGrid];
              
    }    
    return  self;    
}

#pragma mark Sprite position for Saved the game

-(NSInteger)SpriteImagePosition
{
    return [self frameOfAnimation:walkAnim];
}
-(int)frameOfAnimation:(CCAnimation*)animation 
{
    
    NSInteger _animation;
    _animation = self.theGame.animation_State;
    
    if(calculateFrame)
    {
        CCTexture2D *tex = [self.digit displayedFrame].texture;
        CGRect rect = [self.digit displayedFrame].rect;
        //int imageIndex = 0;
        //CCLOG(@"%d",[animation.frames count]);
        int imageIndex = _animation;
        //CCLOG(@"%d",[animation.frames count]);
        
        if([animation.frames count]>0)
        {
            for (int i=0; i<=[animation.frames count]; i++) 
            {
                CCSpriteFrame *frame = [[animation frames] objectAtIndex:i];
                CCTexture2D *tex2 = frame.texture;
                CGRect rect2 = frame.rect;
                if ([tex isEqual:tex2] && CGRectEqualToRect(rect, rect2)) 
                {
                    imageIndex = imageIndex + i + 1;
                    if(imageIndex>30)
                    {
                        imageIndex = 1;
                    }
                    NSLog(@"***********%d", imageIndex);
                    break;
                }
            }
        }
        CCLOG(@"%d",imageIndex);
        return imageIndex; 
        
    }
    else
    {
        //return 1;
        return 30;
    }
}


#pragma mark Replace number After adding the + sign

-(void)ReplaceSpriteWithNewNumber:(NSInteger)newNumber newrow:(NSInteger)newrow newcolumn:(NSInteger)newcolumn addAnimationFrame:(BOOL)addAnimationFrame
{
    app = [[UIApplication sharedApplication] delegate];
    
    self.SpriteType=SPRITE_TYPE_NUMBER;  // 1=Number, 2=Smiley, 3=Frowny, 4= +
    NSLog(@"Spritetype :%d",self.SpriteType);
    [self RemoveSprite];
      //[self.theGame.background removeChild:self.digit cleanup:YES];
    number=newNumber;
    rowNum=newrow;
    currentColumn=newcolumn;
        if (number>=10) {
            //CCLOG(@"Invalid Number");
        }
        
        self.NumberValue=number;
        
   
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
         [NSString stringWithFormat:@"NumberAnim%d.plist",number]];
        
            
        self.replaceSpriteSheet = [CCSpriteBatchNode 
                            batchNodeWithFile:[NSString stringWithFormat:@"NumberAnim%d.png",number]];
    
        [self.theGame.background addChild:self.replaceSpriteSheet];
        
    if (addAnimationFrame==YES) 
    {
        
    
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 30; i++) 
        {
             [walkAnimFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"animation%d_%d.png",number, i]]];
        }
        //NSLog(@"%d",app.Timer);
        walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:app.Timer];
        
        if (walkAnim!=nil) 
        {
            //NSLog(@"%d",app.Timer);
            CCAnimate *animate = [CCAnimate actionWithDuration:app.Timer animation:walkAnim restoreOriginalFrame:NO];
            CCRepeat *repeat = [CCRepeat actionWithAction:animate times:1];
            id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(RedAnimationFinished:)];
            [self.digit runAction:[CCSequence actions:repeat,actionMoveDone,nil]];
        }
    }
    self.digit = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"animation%d_1.png",number]];
    //self.digit.position = ccp(x_Value, y_Value);
    [self UpdateSpritePositionInGrid];
    NSLog(@"X :%f",self.digit.position.x);
    NSLog(@"Y :%f",self.digit.position.y);
    NSLog(@"Row No: %d",rowNum);
    NSLog(@"Current Column: %d",currentColumn);
    [self.replaceSpriteSheet addChild:self.digit];
    
}

#pragma mark Number automatically when it turns RED

-(void)RedAnimationFinishedAfterSaved:(id)sender
{
    calculateFrame = NO;
    self.theGame.moveNumber = NO;
    self.theGame.isTouchEnabled=NO;
    [self performSelector:@selector(RedAnimationDrop) withObject:nil afterDelay:0.1];
}

-(void)RedAnimationFinished:(id)sender
{
    calculateFrame = NO;
    self.theGame.moveNumber = NO;
    self.theGame.isTouchEnabled=NO;
    [self performSelector:@selector(RedAnimationDrop) withObject:nil afterDelay:0.5];
}

-(void)RedAnimationDrop
{
    //[[SimpleAudioEngine sharedEngine] playEffect:@"PinDrop.mp3"];
    if (self.isMoved==YES) 
    {
        return;
    }
    [self.theGame UnScheduleNumberGeneration];
    [self.digit stopAllActions];
    CCSprite *currentSprite =self.digit;
    rowNum = [theGame GetRowNumberToSetSprite:currentColumn];
    if(rowNum==6 && currentSprite.position.y == SWIPE_ALLOWED_FOR_SPRITE && currentSprite.position.y<=440 && currentSprite.position.y>=380 && self.SpriteType==SPRITE_TYPE_PLUS)
    {
        self.isMoved=YES;
        y_Value = rowNum*53+46/2+30;
        switch (currentColumn) 
        {
            case 0:
                x_Value = 45/2;
                break;
                
            case 1:
                x_Value = 45+45/2;
                break;
                
            case 2:
                x_Value = 2*45+45/2;
                break;
                
            case 3:
                x_Value = 3*45+45/2;
                break;
                
            case 4:
                x_Value = 4*45+45/2;
                break;
                
            case 5:
                x_Value = 5*45+45/2;
                break;
                
            case 6:
                x_Value = 6*45+45/2;
                break;
                
            default:
                break;
        }
        
        
        //if (self.SpriteType==1) {
        CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame *frame1;
        if (self.SpriteType==SPRITE_TYPE_SMILEY) 
        {
            //Smiley
            frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",SMILEY_TAG_VALUE]];
        }
        else if(self.SpriteType==SPRITE_TYPE_PLUS)
        {
            //plus sign
            frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",PLUS_SIGN_TAG_VALUE]];
        }
        else if(self.SpriteType==SPRITE_TYPE_FROWNY)
        {
            //frowny
            frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",FROWNY_TAG_VALUE]];
        }
        else
        {
            frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",self.NumberValue]];               
        }
        NSArray *animFrames = [NSArray arrayWithObjects:frame1, nil];
        
        CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:.1f];
        [self.digit runAction:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]];
        //}
        
        
        id actionMove = [CCMoveTo actionWithDuration:.5 position:ccp(x_Value, y_Value)];
        
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(NextValueMoveFinished:)];
        [self.digit runAction:[CCSequence actions:actionMove,actionMoveDone,nil]];
    }
   else if(rowNum<6 && currentSprite.position.y == SWIPE_ALLOWED_FOR_SPRITE && currentSprite.position.y<=440 && currentSprite.position.y>=380)
    {
        self.isMoved=YES;
        y_Value = rowNum*53+46/2+30;
        switch (currentColumn) 
        {
            case 0:
                x_Value = 45/2;
                break;
                
            case 1:
                x_Value = 45+45/2;
                break;
                
            case 2:
                x_Value = 2*45+45/2;
                break;
                
            case 3:
                x_Value = 3*45+45/2;
                break;
                
            case 4:
                x_Value = 4*45+45/2;
                break;
                
            case 5:
                x_Value = 5*45+45/2;
                break;
                
            case 6:
                x_Value = 6*45+45/2;
                break;
                
            default:
                break;
        }
        
        
        //if (self.SpriteType==1) {
        CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        CCSpriteFrame *frame1;
        if (self.SpriteType==SPRITE_TYPE_SMILEY) 
        {
            //Smiley
            frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",SMILEY_TAG_VALUE]];
        }
        else if(self.SpriteType==SPRITE_TYPE_PLUS)
        {
            //plus sign
            frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",PLUS_SIGN_TAG_VALUE]];
        }
        else if(self.SpriteType==SPRITE_TYPE_FROWNY)
        {
            //frowny
            frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",FROWNY_TAG_VALUE]];
        }
        else
        {
            frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",self.NumberValue]];               
        }
        NSArray *animFrames = [NSArray arrayWithObjects:frame1, nil];
        
        CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:.1f];
        [self.digit runAction:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]];
        //}
        
        
        id actionMove = [CCMoveTo actionWithDuration:.5 position:ccp(x_Value, y_Value)];
        
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(NextValueMoveFinished:)];
        [self.digit runAction:[CCSequence actions:actionMove,actionMoveDone,nil]];
        // [theGame.background removeGestureRecognizer:swiperecognizer];
        
        
    }
    else
    {
        [theGame TimeDifferenceForScorePost];
        //[[CCDirector sharedDirector]replaceScene:[Level scene:2]];
        //[self.theGame MoveTogameOverScene];
        
#ifdef VERSION_TENSERFREE
        
        [self.theGame FreeVersion_PaidVersion];

#endif
        
#ifdef VERSION_TENSER
        
        //[self LevelIncreament];
        
        [self.theGame MoveTogameOverScene];
#endif
    }
}


#pragma mark Add gesture to Next Nember

-(void)AddGesture:(CCNode *)node
{
    ;
}

#pragma mark Swipe gesture on Next Number

-(void) Swipe:(UIGestureRecognizer*)recognizer node:(CCNode*)node
{
    ;
}

-(void)DropSprite:(BOOL)ResetImage
{
    if (self.isMoved==YES) 
    {
        return;
    }
   // [self.theGame UnScheduleNumberGeneration];
    [self.digit stopAllActions];
    CCSprite *currentSprite =self.digit;
    rowNum = [theGame GetRowNumberToSetSprite:currentColumn];
    if(rowNum==6 && currentSprite.position.y == SWIPE_ALLOWED_FOR_SPRITE && currentSprite.position.y<=440 && currentSprite.position.y>=380 && self.SpriteType==SPRITE_TYPE_PLUS)
    {
        CCLOG(@"*******************************************");
        self.isMoved=YES;
        y_Value = rowNum*53+46/2+30;
        switch (currentColumn) 
        {
            case 0:
                x_Value = 45/2;
                break;
                
            case 1:
                x_Value = 45+45/2;
                break;
                
            case 2:
                x_Value = 2*45+45/2;
                break;
                
            case 3:
                x_Value = 3*45+45/2;
                break;
                
            case 4:
                x_Value = 4*45+45/2;
                break;
                
            case 5:
                x_Value = 5*45+45/2;
                break;
                
            case 6:
                x_Value = 6*45+45/2;
                break;
                
            default:
                break;
        }
        if (ResetImage==YES) 
        {
            
            //if (self.SpriteType==1) {
            CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame *frame1;
            if (self.SpriteType==SPRITE_TYPE_SMILEY) 
            {
                //Smiley
                frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",SMILEY_TAG_VALUE]];
            }
            else if(self.SpriteType==SPRITE_TYPE_PLUS)
            {
                //plus sign
                frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",PLUS_SIGN_TAG_VALUE]];
            }
            else if(self.SpriteType==SPRITE_TYPE_FROWNY)
            {
                //frowny
                frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",FROWNY_TAG_VALUE]];
            }
            else
            {
                frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",self.NumberValue]];               
            }
            NSArray *animFrames = [NSArray arrayWithObjects:frame1, nil];
            
            CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:.1f];
            [self.digit runAction:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]];
            //}
        }    
        
        NSInteger x=currentColumn*45+45/2;
        NSInteger y=rowNum*53+46/2+30;
        //id actionMove = [CCMoveTo actionWithDuration:.5 position:ccp(x_Value, y_Value)];
        id actionMove = [CCMoveTo actionWithDuration:.5 position:ccp(x, y)];
        
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(NextValueMoveFinished:)];
        [self.digit runAction:[CCSequence actions:actionMove,actionMoveDone,nil]];
        
    }
    
    
    
    else if(rowNum<6 && currentSprite.position.y == SWIPE_ALLOWED_FOR_SPRITE && currentSprite.position.y<=440 && currentSprite.position.y>=380)
    {
        //rowNum = [theGame GetRowNumberToSetSprite:currentColumn];
        
        self.isMoved=YES;
        y_Value = rowNum*53+46/2+30;
        switch (currentColumn) 
        {
            case 0:
                x_Value = 45/2;
                break;
                
            case 1:
                x_Value = 45+45/2;
                break;
                
            case 2:
                x_Value = 2*45+45/2;
                break;
                
            case 3:
                x_Value = 3*45+45/2;
                break;
                
            case 4:
                x_Value = 4*45+45/2;
                break;
                
            case 5:
                x_Value = 5*45+45/2;
                break;
                
            case 6:
                x_Value = 6*45+45/2;
                break;
                
            default:
                break;
        }
        if (ResetImage==YES) 
        {
            
            //if (self.SpriteType==1) {
            CCSpriteFrameCache *cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame *frame1;
            if (self.SpriteType==SPRITE_TYPE_SMILEY) 
            {
                //Smiley
                frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",SMILEY_TAG_VALUE]];
            }
            else if(self.SpriteType==SPRITE_TYPE_PLUS)
            {
                //plus sign
                frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",PLUS_SIGN_TAG_VALUE]];
            }
            else if(self.SpriteType==SPRITE_TYPE_FROWNY)
            {
                //frowny
                
                frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",FROWNY_TAG_VALUE]];
                //frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"frowny face1.png"]];
            }
            else
            {
                frame1 = [cache spriteFrameByName:[NSString stringWithFormat:@"animation%d_1.png",self.NumberValue]];               
            }
            NSArray *animFrames = [NSArray arrayWithObjects:frame1, nil];
            
            CCAnimation *animation = [CCAnimation animationWithFrames:animFrames delay:.1f];
            [self.digit runAction:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]];
            //}
        }    

        NSInteger x=currentColumn*45+45/2;
        NSInteger y=rowNum*53+46/2+30;
        //id actionMove = [CCMoveTo actionWithDuration:.5 position:ccp(x_Value, y_Value)];
        id actionMove = [CCMoveTo actionWithDuration:.5 position:ccp(x, y)];
        
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(NextValueMoveFinished:)];
        [self.digit runAction:[CCSequence actions:actionMove,actionMoveDone,nil]];
        //[theGame.background removeGestureRecognizer:swiperecognizer];
        
    }
    else
    {
        [self.theGame TimeDifferenceForScorePost];
        //[[CCDirector sharedDirector]replaceScene:[Level scene:2]];
        //[self.theGame MoveTogameOverScene];
        
#ifdef VERSION_TENSERFREE
        
        [self.theGame FreeVersion_PaidVersion];

#endif
        
#ifdef VERSION_TENSER
               
        [self.theGame MoveTogameOverScene];
#endif
    }
}


-(void)NumberPositionOnSwipe
{
    
}


#pragma mark Nember add to Grid

-(void)AddNumberToGrid
{
    //CCLOG(@"Cur Column : %d",self.currentColumn);
    //CCLOG(@"Cur Row : %d",self.rowNum);
    //[self.theGame AddNumberToGrid:rowNum col:self.currentColumn number:self];
}

-(void)NextValueMoveFinished:(id)sender
{
    self.theGame.moveNumber = YES;
    [self performSelector:@selector(PerformActionAfterNumberReachedPosition) withObject:nil afterDelay:0.2];
}

-(void)PerformActionAfterNumberReachedPosition
{
    // self.theGame.moveNumber = YES;
    [self.theGame AddNumberToGrid:rowNum col:self.currentColumn number:self];
    
    [self.theGame ScoreByRowPosition:rowNum];
    [self.theGame CheckGroup]; //ARIJIT
    self.theGame.currentNumber=nil;

    [self.theGame GenerateNextNumber];
    
#ifdef VERSION_TENSERFREE
    
    if(self.theGame.Score_Sum>=FREE_VERSION_SCORE && [self.theGame isContinueFreeVersion])
    {
       [self.theGame FreeVersion_PaidVersion];
    }
    
#endif
}


#pragma mark Get random Number

-(NSInteger)GetRandomNumber:(NSInteger) MAX MIN:(NSInteger)MIN  EXCLUD:(NSInteger)exclud
{
    int rangeduration = MAX - MIN;
    NSInteger actualduration = (arc4random() % rangeduration) + MIN;
    return actualduration!= exclud ? actualduration:[self GetRandomNumber:MAX MIN:MIN EXCLUD:exclud];
}

-(NSInteger)Testingexplosion
{
    int explosion;

    explosion = [[app.testNumber objectAtIndex:i] integerValue];
    i++;
    return explosion;
}

#pragma mark Update position of Sprite after EXPLOSION

-(void)UpdateSpritePositionInGrid
{
    
    CCLOG(@"Update position : %d Row : %d Col : %d",self.NumberValue,self.rowNum,self.currentColumn);
    
    NSInteger x=currentColumn*45+45/2;
    NSInteger y=rowNum*53+46/2+30;
    self.digit.position=ccp(x, y);
    self.replaceDigit.position=ccp(x, y);
    //NSLog(@"%f %f",self.digit.position);
    NSLog(@"X: %f",self.digit.position.x);
    NSLog(@"Y: %f",self.digit.position.y);
    NSLog(@"Row No: %d",rowNum);
    NSLog(@"Current Column: %d",currentColumn);
    
    //[self.theGame CheckGroup];
   
}

-(void)RemoveSprite
{
    [self.theGame.background removeChild:self.digit cleanup:YES];
    [self.theGame.background removeChild:self.spriteSheet cleanup:YES];
    [self.theGame.background removeChild:self.replaceDigit cleanup:YES];
    [self.theGame.background removeChild:self.replaceSpriteSheet cleanup:YES];
    
    CCLOG(@"%d",[self.theGame.background.children count]);
        
}





-(void)RemoveSpriteSheet
{
    [self.theGame.background removeChild:self.spriteSheet cleanup:YES];
    //[self UpdateSpritePositionInGrid];
}


@end
