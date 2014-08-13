//
//  NumberSprite.h
//  TENSER
//
//  Created by Mac Mini 4 on 22/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

//#import "CCGestureRecognizer.h"
@class GameLayer;
@interface NumberSprite : CCNode {
    CCSprite *digit;
    CCSprite *replaceDigit;
    NSInteger NumberValue;
    GameLayer *theGame;
    int currentColumn;
   // NSInteger RowNumber;
    NSInteger rowNum;
    NSInteger curHGroup;
    NSInteger curVGroup;
    NSInteger x_Value;
    NSInteger y_Value;
    BOOL isMoved;
    CCAnimation *walkAnim;
    id walkAction;
    NumberSprite *grid[5][7];
    CCSpriteBatchNode *spriteSheet;
    CCSpriteBatchNode *replaceSpriteSheet;
    NSInteger SpriteType;
    NSInteger number;
    BOOL calculateFrame;
   
    
}
@property(nonatomic,retain)CCSpriteBatchNode *spriteSheet;
@property(nonatomic,retain)CCAnimation *walkAnim;
@property(nonatomic,readwrite)NSInteger SpriteType;
@property(nonatomic,readwrite)BOOL isMoved;
@property(nonatomic,readwrite)NSInteger curHGroup;
@property(nonatomic,readwrite)NSInteger curVGroup;
@property(nonatomic,retain)CCSprite *digit;
@property(nonatomic,readwrite)NSInteger NumberValue;
@property(nonatomic,retain)GameLayer *theGame;
@property (nonatomic , readwrite)int currentColumn;
//@property(nonatomic, readwrite)NSInteger RowNumber;
@property(nonatomic, readwrite)NSInteger rowNum;
@property(nonatomic,readwrite)NSInteger x_Value;
@property(nonatomic,readwrite)NSInteger y_Value;
@property(nonatomic,readwrite)NSInteger number;

@property(nonatomic,retain)CCSpriteBatchNode *replaceSpriteSheet;
@property(nonatomic,retain)CCSprite *replaceDigit;
@property(nonatomic,readwrite)BOOL calculateFrame;




-(id)initWithGame:(GameLayer *)game;
//-(id)initWithGameAndNumber:(GameLayer *)game number:(NSInteger)number;
//-(id)initWithGameAndNumber:(GameLayer *)game lastsavednumber:(NSInteger)lastsavednumber lastNumberState:(NSInteger)lastNumberState;

-(id)initWithGameAndNumber:(GameLayer *)game lastsavednumber:(NSInteger)lastsavednumber lastNumberState:(NSInteger)lastNumberState lastSpriteType:(NSInteger)lastSpriteType;


-(void)AddGesture:(CCNode *)node;
-(void) Swipe:(UIGestureRecognizer*)recognizer node:(CCNode*)node;
//-(NSInteger)GetRandomNumber;
-(NSInteger)GetRandomNumber:(NSInteger) MAX MIN:(NSInteger)MIN  EXCLUD:(NSInteger)exclud;
-(void)AddNumberToGrid;
-(void)UpdateSpritePositionInGrid;
-(void)RemoveSprite;
//-(id)initWithGameAndNumber1:(GameLayer *)game number:(NSInteger)number RowNumber:(NSInteger)RowNumber ColumnNumber:(NSInteger)ColumnNumber;
//-(id)initWithGameAndNumber1:(GameLayer *)game lastsavednumber:(NSInteger)lastsavednumber RowNumber:(NSInteger)RowNumber ColumnNumber:(NSInteger)ColumnNumber;


-(id)initWithGameAndNumber1:(GameLayer *)game lastsavednumber:(NSInteger)lastsavednumber RowNumber:(NSInteger)RowNumber ColumnNumber:(NSInteger)ColumnNumber number_type:(NSInteger)number_type;

-(void)DropSprite:(BOOL)ResetImage;
-(void)RedAnimationFinished:(id)sender;
//-(void)ResetPositon;
-(void)RedAnimationDrop;
-(void)RemoveSpriteSheet;
-(void)ReplaceSpriteWithNewNumber:(NSInteger)newNumber newrow:(NSInteger)newrow newcolumn:(NSInteger)newcolumn addAnimationFrame:(BOOL)addAnimationFrame;
-(int)frameOfAnimation:(CCAnimation*)animation;
//-(void)ABCD;
-(NSInteger)SpriteImagePosition;
-(void)NumberSpriteAnimation;
-(void)PerformActionAfterNumberReachedPosition;


-(void)NumberPositionOnSwipe;
-(NSInteger)Testingexplosion;
-(void)Initialize:(GameLayer *)game;
-(void)RedAnimationFinishedAfterSaved:(id)sender;

@end
