//
//  HelloWorldLayer.h
//  TENSER
//
//  Created by Mac Mini 4 on 22/02/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "NumberSprite.h"
#import "AppDelegate.h"
//#import "GameState.h"
@class GameState;
// HelloWorldLayer
@interface GameLayer : CCLayer<UIAlertViewDelegate>
{
    NumberSprite *currentNumber;
    NumberSprite *grid[6][7];
    int currentColumn;
    NSMutableArray * groupings;
    CCLabelTTF *Score_label;
    CCLabelTTF *Score_Update;
    CCLabelTTF *labelname;
    NSInteger Score_Sum;
    NSInteger Count_Score;
    NSInteger Count_SpriteRemoved;
    NSInteger Count_Bonus;
    NSMutableArray *ScroeArray;
    NSMutableArray *BonusPoints;
    NSInteger StorePreviousScore;
    CCMenuItemImage *pause;
    CCMenuItemImage *play;
    CCSprite *background;
    CCMenuItemImage *continue_Image;
    CCMenuItemImage *quit_Image;
    CCSprite *pausescreen;
    CCSprite *play_game;
    CCMenuItemImage *playgame;
    GameLayer *objGameLayer;
    GameState *objGameState;
    NSString *level;
    NSString *Score;
    CGPoint firsttouch;
    CGPoint lasttouch;
    NSMutableData *webdata;
    UIActivityIndicatorView *loading;
    BOOL moveNumber;
    NSInteger TouchXPos_Start;
    NSInteger TouchXPos_End;
    BOOL IsFingerSwiped;
    UIView *LevelView;
    CCLabelTTF *NextLevel;
    BOOL isSmileyAppeared;
    CCSprite *frowny_Gameover;
    CCAnimation *imageAnimation;
    CCSpriteBatchNode *spriteSheet_forFrowny;
    //CCGestureRecognizer *swiperecognizer;
    //CCGestureRecognizer *swiperecognizerOnSprite;
    BOOL isTouch_Swipe;
    BOOL PlusSignAdd;
    NSInteger Last_Column_Position;
    NSInteger animation_State;
    UIAlertView *alertForPaidVersion;
    UIView *viewAnimation;
    UIButton *btnNO;
    UIButton *btnPlus;
    UILabel  *lblText;
    
    NSInteger Bonus;
    CGRect boundRect;
    
    BOOL isNumberMoveFromGrid;
    
    CCMenuItemImage *paidVersion;
    
    CCSprite *getPaidorNot;
    CCLabelTTF *lbltextTTF;
    CCMenuItemImage *menuNo;
    CCMenuItemImage *menuPlus;
    
    
}

@property(nonatomic,retain)NumberSprite *currentNumber;
@property(nonatomic,retain)CCLabelTTF *Score_label;
@property(nonatomic,retain)CCLabelTTF *Score_Update;
@property(nonatomic,readwrite)NSInteger Score_Sum;
@property(nonatomic,readwrite)NSInteger Count_Score;
@property(nonatomic,readwrite)NSInteger Count_SpriteRemoved;
@property(nonatomic,readwrite)NSInteger Count_Bonus;
@property(nonatomic,retain)CCSprite *background;
@property (nonatomic,retain)GameLayer *objGameLayer;
@property(nonatomic,retain)GameState *objGameState;
@property(nonatomic,retain)CCLabelTTF *labelname;
@property(nonatomic,retain)NSString *level;
@property(nonatomic,retain)NSString *Score;
@property(nonatomic,readwrite)NSInteger StorePreviousScore;
@property(nonatomic , readwrite)BOOL moveNumber;
@property(nonatomic,retain)UIView *LevelView;
@property(nonatomic,retain)CCLabelTTF *NextLevel;
@property(nonatomic,readwrite)BOOL isSmileyAppeared;
@property(nonatomic,retain)CCSprite *frowny_Gameover;
@property(nonatomic,retain)CCAnimation *imageAnimation;
@property(nonatomic,retain)CCSpriteBatchNode *spriteSheet_forFrowny;
@property(nonatomic,retain)NSMutableArray *ScroeArray;
@property(nonatomic,retain)NSMutableArray *BonusPoints;
@property(nonatomic,readwrite)BOOL PlusSignAdd;
@property(nonatomic,readwrite) NSInteger Last_Column_Position;
@property(nonatomic,readwrite) NSInteger animation_State;
@property(nonatomic,retain)UIAlertView *alertForPaidVersion;
@property(nonatomic,retain)UIView *viewAnimation;
@property(nonatomic,retain)UIButton *btnNO;
@property(nonatomic,retain)UIButton *btnPlus;
@property(nonatomic,retain)UILabel  *lblText;
@property(nonatomic,readwrite)NSInteger Bonus;

@property(nonatomic,readwrite)BOOL isNumberMoveFromGrid;

@property (nonatomic , retain) NSMutableArray * groupings;
//@property (nonatomic, retain) CCGestureRecognizer *swiperecognizer;



// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
+(CCScene *)sceneWithLastGame:(GameState*)lastgame;
-(void)AddNumberToGrid:(NSInteger)row col:(NSInteger)col number:(NumberSprite *)number;
-(NSInteger)GetRowNumberToSetSprite:(NSInteger)col;
-(void)CheckGroup;
-(void)RemoveSpritess:(NSMutableArray *)arr;
//-(void)moveNumbersDown;
-(void)CheckGrid:(NSInteger)row col:(NSInteger)col scrollType:(NSInteger)scrolltype;
-(void)ScoreByRowPosition:(NSInteger)RowCount;
-(void)Calculate_Score:(NSInteger)row;
-(void)CalCulateScoreofRemovesSprite;
-(void)GenerateNextNumber;
-(void)UnScheduleNumberGeneration;
-(void)ScheduleNumberGeneration;
-(void)Pause;
-(void)Play;
-(void)PauseScreen;
-(void)Quit:(CCMenuItem *)sender;
-(void)Continue;
-(void)PlayGameScreen;
-(void)makeGridNil;
-(void)LoadNewGame;
-(void)LoadSavedGame:(GameState*)lastGame;
-(void)SetInsertDetails:(NSString*)UserName TensionValue:(NSInteger)tensionvalue TotalScore:(NSInteger)total TimeInterval:(long)timeintervel;
//-(void)LevelwiseInsertDetails:(NSString *)Username Round1:(NSInteger)round1 TotalScore1:(NSInteger)score1 Round2:(NSInteger)round2 TotalScore2:(NSInteger)score2 Round3:(NSInteger)round3 TotalScore3:(NSInteger)score3 Round4:(NSInteger)round4 TotalScore4:(NSInteger)score4;
-(void)TimeDifferenceForScorePost;
-(void)MoveTogameOverScene;
-(void)MakeScoreLevelWhite;
-(void)ReplaceScene;
-(void)gameOverPage;
-(BOOL)IsSmileyPresentInGrid;
-(BOOL)IsFrownyPresentInGrid;
-(void)ChangeLevel;
-(void)MakeScoreLevelRed:(NSInteger) LevelNumber;
-(void)AddGesture:(CCNode *)node;
-(void) Swipe:(UIGestureRecognizer*)recognizer node:(CCNode*)node;
-(void)NumberInGrid;
-(void)FreeVersion_PaidVersion;
-(void)LevelIncreament;
-(void)URLPageReplace;
-(void)replacePos:(int)row:(int)col;
-(void)setContinueFreeVersion;
-(BOOL)isContinueFreeVersion;
-(void)ToGetPaidVersion;
-(void)SavedGamePlay;
-(void)PaidVersionButtonPosition;
-(void)btnClickPlus;
-(void)btnClickNo;
-(void)SavedGamePlayForPlus;
-(void)URLPageReplaceFprPlus;
-(void)Animation:(NumberSprite *)obj;
-(NSInteger)CheckSum:(NSMutableArray *)array lastnumber:(NumberSprite *)lastnumber;
-(NSInteger)CheckSumforRow:(NSMutableArray *)array lastnumber:(NumberSprite *)lastnumber;

@end
