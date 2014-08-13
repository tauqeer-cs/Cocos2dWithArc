          //
//  HelloWorldLayer.m
//  TENSER
//
//  Created by Mac Mini 4 on 22/02/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"
#import "Level.h"
#import "Home.h"
#import "GameState.h"
#import "InternetValidation.h"
#import "ParseInsertDetails.h"
#import "SimpleAudioEngine.h"
#import "Settings.h"
#import "ChangeLevel.h"

// HelloWorldLayer implementation
#define TOUCH_ALLOWED_MAX_Y 440
#define TOUCH_ALLOWED_MIN_Y 380
#define GRID_ROW 6
#define GRID_COLS 7
#define GRID_CELL_WIDTH 45
#define FIXED_Y 410

@implementation GameLayer
@synthesize currentNumber;
@synthesize Score_Sum;
@synthesize Score_Update;
@synthesize Score_label;
@synthesize Count_Score;
@synthesize Count_SpriteRemoved;
@synthesize Count_Bonus;
@synthesize background;
@synthesize objGameLayer;
@synthesize objGameState;
@synthesize labelname;
@synthesize level;
@synthesize Score;
@synthesize StorePreviousScore;
@synthesize moveNumber;
@synthesize LevelView;
@synthesize NextLevel;
@synthesize isSmileyAppeared;
@synthesize frowny_Gameover;
@synthesize imageAnimation;
@synthesize spriteSheet_forFrowny;
@synthesize ScroeArray;
@synthesize BonusPoints;
@synthesize PlusSignAdd;
@synthesize Last_Column_Position;
@synthesize animation_State;
@synthesize alertForPaidVersion;
@synthesize viewAnimation;
@synthesize btnNO;
@synthesize btnPlus;
@synthesize lblText;
@synthesize Bonus;
@synthesize isNumberMoveFromGrid;

@synthesize groupings;

//@synthesize swiperecognizer;



AppController *app;
Level *obj_level;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    [layer LoadNewGame];
	
	// return the scene
	return scene;
}

+(CCScene *)sceneWithLastGame:(GameState*)lastgame
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    [layer LoadSavedGame:lastgame];
	
	// return the scene
	return scene;
    
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
        
        //if(!app.loadSavedGame)
        //{
        // [self PlayGameScreen];
        boundRect = CGRectMake(0, 440, 320, 60);
        self.isTouchEnabled=YES;
        self.moveNumber = YES;
        isTouch_Swipe=YES;
        //self.currentNumber.calculateFrame=YES;
        app = [[UIApplication sharedApplication] delegate];
        
        app.gameLayer_obj = self;
        
        CGSize winsize=[[CCDirector sharedDirector]winSize];
        
        background=[CCSprite spriteWithFile:@"game-play-bg.png"];
        background.position=ccp(160, 240);
        [self addChild:background];
        
        
        self.Score_label=[CCLabelTTF labelWithString:@"Score :" fontName:@"Marker Felt" fontSize:20];
        self.Score_label.position=ccp(winsize.width/2-30,winsize.height/2+210);
        self.Score_label.color=ccc3(255, 255, 255);
        // [self addChild:self.Score_label];
        
        
        if(app.isReplay==YES)
        {

            level=[NSString stringWithFormat:@"Level %d",app.LastLevelno];
            Score_Sum = app.LastScoreValue;
            Score = [NSString stringWithFormat:@"%d",Score_Sum];
             //Score = [NSString stringWithFormat:@"%d",[[NSUserDefaults standardUserDefaults]valueForKey:@"score"]];
            //Score = [[NSUserDefaults standardUserDefaults] objectForKey:@"score"];
            self.Score_Update=[CCLabelTTF labelWithString:Score fontName:@"Marker Felt" fontSize:20];
            self.Score_Update.position=ccp(winsize.width/2-10,winsize.height/2+210);
            self.Score_Update.color=ccc3(255, 255, 255);

        }
        else 
        {
            level=[NSString stringWithFormat:@"Level %d",app.LevelNumber];
            Score_Sum = app.TotalScore;
            Score = [NSString stringWithFormat:@"%d",Score_Sum];
            self.Score_Update=[CCLabelTTF labelWithString:Score fontName:@"Marker Felt" fontSize:20];
            self.Score_Update.position=ccp(winsize.width/2-10,winsize.height/2+210);
            self.Score_Update.color=ccc3(255, 255, 255);

        }
        
        [self addChild:self.Score_Update];
        
        
        labelname = [CCLabelTTF labelWithString:level fontName:@"Marker Felt" fontSize:20];                
        labelname.position=ccp(background.contentSize.width/2-100, background.contentSize.height/2+210);
        labelname.color=ccc3(255, 255, 255);        
        [background addChild:labelname];

        [self Pause];
        
        
        /* ScroeArray = [[NSMutableArray alloc] initWithObjects:@"5",@"10",@"50",@"100",@"500",@"550", nil];
         BonusPoints = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"10",@"25", nil];
         */
        
        //--------New Score------
        
        ScroeArray = [[NSMutableArray alloc] initWithObjects:@"5",@"10",@"20",@"50",@"100",@"250",@"0", nil]; 
        //ScroeArray = [[NSMutableArray alloc] initWithObjects:@"50",@"100",@"120",@"150",@"200",@"500",@"0", nil]; 
        BonusPoints = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"5",@"10", nil];
        
        
        [self AddGesture:self.background];
        
    }
	return self;
}

-(void)ChangeLevel
{
    labelname = [CCLabelTTF labelWithString:level fontName:@"Marker Felt" fontSize:20];                
    labelname.position=ccp(background.contentSize.width/2-100, background.contentSize.height/2+210);

    if(app.LevelNumber==1)
    {
       labelname.color=ccc3(255, 255, 255);         
    }
       
    else
    {
        labelname.color = ccc3(255, 0, 0);
        [self performSelector:@selector(MakeScoreLevelWhite) withObject:nil afterDelay:3.0];
    }
    [background addChild:labelname];
}

#pragma mark For New game

-(void)LoadNewGame
{
    isSmileyAppeared = NO;
    isTouch_Swipe=NO;
    
    NumberSprite *sprt=[[NumberSprite alloc]initWithGame:self];
    self.currentNumber=sprt;
    //[sprt release];  /****** Manual Relese********/
}




#pragma mark For Saved Game
-(void)LoadSavedGame:(GameState*)lastGame
{
    //isTouch_Swipe=NO;
    [background removeChild:labelname cleanup:YES];
    [self.Score_Update setString:[NSString stringWithFormat:@"%d",lastGame.LastSavedScore]];
    app.LevelNumber=lastGame.LastLevelPlayed;
    app.LastLevelno= lastGame.LastLevelPlayed;
    NSLog(@"levelno :%d",app.LastLevelno);
    app.Timer = lastGame.LastTensionSelected;
    app.ProfileName = lastGame.LastUserName;    
    Last_Column_Position=lastGame.ColumnPosition;
    NSLog(@"Column Position: %d",Last_Column_Position);
    
    animation_State= lastGame.LastNumberAnimatinState;
    CCLOG(@"%d",animation_State);
    
    NumberSprite *lastNumberAppeared = [[NumberSprite alloc]initWithGameAndNumber:self lastsavednumber:lastGame.LastNumberAppeared lastNumberState:lastGame.LastNumberAnimatinState lastSpriteType:lastGame.NumberType];
    
    
    self.currentNumber=lastNumberAppeared;
    self.Score_Sum=lastGame.LastSavedScore;
    //app.LastLevelScore=lastGame.LastSavedScore;
    app.LastScoreValue = lastGame.ScoreByLevel;
    NSLog(@"%d",app.LastScoreValue);
    
#ifdef VERSION_TENSERFREE

    if(self.Score_Sum>=FREE_VERSION_SCORE)
    {
        [self PaidVersionButtonPosition];
    }
    
#endif
    
    
    level = [NSString stringWithFormat:@"Level %d",lastGame.LastLevelPlayed];
    labelname = [CCLabelTTF labelWithString:level fontName:@"Marker Felt" fontSize:20];                
    labelname.position=ccp(background.contentSize.width/2-100, background.contentSize.height/2+210);
    labelname.color=ccc3(255, 255, 255);        
    [background addChild:labelname];
    [lastGame AddSavedGameToGamelayer:self grid:grid];
    
}




#pragma mark PauseScreen,Continue,PauseButton,PlaygameScreen and Quit

-(void)PlayGameScreen
{
    playgame = [CCMenuItemImage itemFromNormalImage:@"play-game.png" selectedImage:@"play-game.png"target:self selector:@selector(Play)];                
    playgame.position=ccp(100,100);
    CCMenu *menu=[CCMenu menuWithItems:playgame, nil];       
    [background addChild:menu]; 
        
}

-(void)Play
{
     app.KeepGamePaused=YES;
    [pause setVisible:false];
    [self PauseScreen];
    play=[CCMenuItemImage itemFromNormalImage:@"play-button.png" selectedImage:@"play-button.png"target:self selector:nil];                
    play.position=ccp(110,210);
    CCMenu *menu=[CCMenu menuWithItems:play, nil];       
    [background addChild:menu];
}

-(void)Pause
{
   
    [background removeChild:play cleanup:YES];
    pause=[CCMenuItemImage itemFromNormalImage:@"pause-button.png" selectedImage:@"pause-button.png"target:self selector:@selector(Play)];                
    pause.position=ccp(110,210);
    CCMenu *menu=[CCMenu menuWithItems:pause, nil];       
    [background addChild:menu];
}

-(void)PauseScreen
{
    self.isTouchEnabled=NO;
    if (pause.tag==1) 
    {
        return;
    }
    
    pause.tag=1;
    
    [[CCDirector sharedDirector] pause];
    
    pausescreen = [CCSprite spriteWithFile:@"pause-bg.png"];
    pausescreen.position = ccp(160,240);
    [background addChild:pausescreen]; 
    
    continue_Image=[CCMenuItemImage itemFromNormalImage:@"continue-deselect.png" selectedImage:@"continue-deselect.png"target:self selector:@selector(Continue)];                
    continue_Image.position=ccp(0,5);
    
    quit_Image=[CCMenuItemImage itemFromNormalImage:@"quit-deselect.png" selectedImage:@"quit-deselect.png"target:self selector:@selector(Quit:)];                
    quit_Image.position=ccp(0,-68);
    
    CCMenu *menu=[CCMenu menuWithItems:continue_Image,quit_Image, nil];       
    [pausescreen addChild:menu];
}

-(void)Quit:(CCMenuItem *)sender
{
    [self SavedGamePlay];
}

-(void)Continue
{
    app.KeepGamePaused=NO;
    self.isTouchEnabled=YES;
    [background removeChild:pausescreen cleanup:YES];
    [background removeChild:play cleanup:YES];
    [[CCDirector sharedDirector] resume];
    pause=[CCMenuItemImage itemFromNormalImage:@"pause-button.png" selectedImage:@"pause-button.png"target:self selector:@selector(Play)];                
    pause.position=ccp(110,210);
    CCMenu *menu=[CCMenu menuWithItems:pause, nil];       
    [background addChild:menu];
    pause.tag=0;
}

#pragma mark Score Post in Webservice

-(void)SetInsertDetails:(NSString*)UserName TensionValue:(NSInteger)tensionvalue TotalScore:(NSInteger)total TimeInterval:(long)timeintervel
{
    if([InternetValidation connectedToNetwork]==YES)
    {
        NSString *version;
#ifdef VERSION_TENSERFREE
        
        version = [NSString stringWithFormat:@"%d",0];
#endif
        
#ifdef VERSION_TENSER
        
        version = [NSString stringWithFormat:@"%d",1];
#endif
        
        NSString *str = [NSString stringWithFormat:@"&lt;?xml version=\"1.0\"?&gt;&lt;InsertGame&gt;&lt;UserName&gt;%@&lt;/UserName&gt;&lt;TensionNo&gt;%d&lt;/TensionNo&gt;&lt;TotalScore&gt;%d&lt;/TotalScore&gt;&lt;TimeDuration&gt;%ld&lt;/TimeDuration&gt;&lt;Version&gt;%@&lt;/Version&gt;&lt;/InsertGame&gt;"
                         ,UserName,tensionvalue,total,timeintervel,version];
        
        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 "<soap:Body>"
                                 "<InsertGame xmlns=\"http://alphaheuristix.com/indusnettenser/\">"
                                 "<xmlString>%@</xmlString>"
                                 "</InsertGame>"
                                 "</soap:Body>"
                                 "</soap:Envelope>",str];
        
        NSURL *url = [NSURL URLWithString:TenserLeaderBoardURL];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
        //NSLog(@"%@",msgLength);
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://alphaheuristix.com/indusnettenser/InsertGame" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];

        if( theConnection )
        {
            webdata = [NSMutableData data];
        }
        else
        {
            //NSLog(@"theConnection is NULL");
        }

    }
    
    else
    {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:AlertTitle message:ConnectionUnavailable delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alt show];
        
    }
}

#pragma mark HTTPResponseDelegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webdata setLength: 0];
    
}       


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webdata appendData:data];
    NSString *d = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",d);

}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    NSLog(@"ERROR with theConenction");
//    [activityindicator HideActivity];
//    [Vw removeFromSuperview];
//    self.view.userInteractionEnabled=YES;
    
    
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:AlertTitle message:ConnectionUnavailable delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alt show];

}



-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSString *value=[[NSString alloc]initWithData:webdata encoding:NSUTF8StringEncoding];

    
    ParseInsertDetails *obj = [[ParseInsertDetails alloc] init];
    [obj parseXMLFileAtData:webdata parseError:nil];

    if(obj.Resp_Code==0)
    {

    }
    
    else if(obj.Resp_Code==1)
    {
        UIAlertView *alt_UnSuccScorePost = [[UIAlertView alloc]initWithTitle:AlertTitle message:@"Score does not successfully uploaded to web" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alt_UnSuccScorePost.tag=2;
		[alt_UnSuccScorePost show];
    }
    
}

#pragma mark Calculation of Score

-(void)ScoreByRowPosition:(NSInteger)RowCount
{
    
    Count_Score = [[ScroeArray objectAtIndex:RowCount] integerValue];
    [self Calculate_Score:Count_Score];
}

-(void)Calculate_Score:(NSInteger)row
{
    Score_Sum = Score_Sum + row;
    [Score_Update setString:[NSString stringWithFormat:@"%d",Score_Sum]];
}

-(void)CalCulateScoreofRemovesSprite
{
    if((Count_Bonus==[BonusPoints count]) || (Count_Bonus>[BonusPoints count]))
    {
        //Count_Bonus=[BonusPoints count];
        Bonus = 1;
    }
    else
    {
        Bonus = [[BonusPoints objectAtIndex:Count_Bonus-1] intValue];
    }
    
    NSMutableArray *uniqueItems = [[NSMutableArray alloc]init];
    
    for(int i=0;i<[groupings count];i++)
    {
        id obj = [groupings objectAtIndex:i];
        if(![uniqueItems containsObject:obj])
        {
            [uniqueItems addObject:obj];
        }
    }
    
    //CCLOG(@"Uni-%d",[uniqueItems count]);
    //CCLOG(@"Groupings-%d",[groupings count]);
    
    if([uniqueItems count] == 2)
    {
        //Count_SpriteRemoved = 5*Bonus;
        Count_SpriteRemoved = 10*Bonus;
        Count_SpriteRemoved = Count_SpriteRemoved - Count_Score;
    }
    else if([uniqueItems count] == 3)
    {
        //Count_SpriteRemoved = 10*Bonus;
        Count_SpriteRemoved = 20*Bonus;
        Count_SpriteRemoved = Count_SpriteRemoved - Count_Score;
    }    
    else if([uniqueItems count] == 4)
    {
        //Count_SpriteRemoved = 20*Bonus;
        Count_SpriteRemoved = 50*Bonus;
        Count_SpriteRemoved = Count_SpriteRemoved - Count_Score;
    }
    else if([uniqueItems count] == 5)
    {
        //Count_SpriteRemoved = 50*Bonus;
        Count_SpriteRemoved = 100*Bonus;
        Count_SpriteRemoved = Count_SpriteRemoved - Count_Score;
    }
    else if([uniqueItems count] >5 && [uniqueItems count] <9)
    {
        //Count_SpriteRemoved = 100*Bonus;
        Count_SpriteRemoved = 500*Bonus;
        Count_SpriteRemoved = Count_SpriteRemoved - Count_Score;
    }
    else if([uniqueItems count] >8 && [uniqueItems count] <11)
    {
        Count_SpriteRemoved = 1000*Bonus;
        Count_SpriteRemoved = Count_SpriteRemoved - Count_Score;
    }

    else if([uniqueItems count] >10 && [uniqueItems count] <13)
    {
        Count_SpriteRemoved = 5000*Bonus;
        Count_SpriteRemoved = Count_SpriteRemoved - Count_Score;
    }
    [self Calculate_Score:Count_SpriteRemoved];
    Count_Bonus = 0;

}

#pragma mark Digit dragging and Tapping

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    //location.y = 480-location.y;
    
    //NSLog(@"X: %f",location.x);
    //NSLog(@"Y: %f",location.y);
    
    TouchXPos_Start=location.x;
    IsFingerSwiped=NO;
}
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CCLOG(@"Finger moved");
    IsFingerSwiped=YES;   
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    isTouch_Swipe=YES;
    
    if (self.currentNumber==nil) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location.y = 480-location.y;
    
    
    if (location.y<=TOUCH_ALLOWED_MAX_Y && location.y>=TOUCH_ALLOWED_MIN_Y && location.x>=0 && self.moveNumber)
    {

        
        ////NSLog(@"X: %f",location.x);
        ////NSLog(@"Y: %f",location.y);
        CCLOG(@"Touch Allowed");
        if (IsFingerSwiped==YES) 
        {
            TouchXPos_End=location.x;
            if ((TouchXPos_End-TouchXPos_Start)>0 && self.currentNumber.currentColumn<6) 
            {
                CCLOG(@"Move to right");
                self.currentNumber.currentColumn = self.currentNumber.currentColumn+1;
                if (currentColumn>6) 
                {
                    CCLOG(@"WRONG COL NO");
                    currentColumn=6;
                }
            }
            else if ((TouchXPos_End-TouchXPos_Start)<0 && self.currentNumber.currentColumn>0) 
            {
                CCLOG(@"Move to left");
                self.currentNumber.currentColumn = self.currentNumber.currentColumn-1;
            }
            currentColumn=self.currentNumber.currentColumn;
            
            if (currentColumn>6) {
                CCLOG(@"WRONG COL NO");
                currentColumn=6;
            }
            
            NSInteger xlocation = currentColumn*GRID_CELL_WIDTH + GRID_CELL_WIDTH/2;
            if (xlocation>=320) 
            {
                CCLOG(@"BEYOND AREA");
            }
            id actionMove = [CCMoveTo actionWithDuration:.001 
                                                position:ccp(xlocation, FIXED_Y)];
            id actionMoveDone = [CCCallFuncN actionWithTarget:self 
                                                     selector:@selector(spriteMoveFinished)];
            [self.currentNumber.digit runAction:[CCSequence actions:actionMove,actionMoveDone,nil]];
            IsFingerSwiped=NO;
            //return;
            
        }
        else
        {
            currentColumn = location.x/GRID_CELL_WIDTH;
            if (currentColumn>6) 
            {
                CCLOG(@"WRONG COL NO");
                currentColumn=6;
            }
            self.currentNumber.currentColumn = currentColumn;
            NSInteger xlocation = currentColumn*GRID_CELL_WIDTH + GRID_CELL_WIDTH/2;
            //self.currentNumber.digit.position = ccp(location.x, location.y);
            id actionMove = [CCMoveTo actionWithDuration:.001 
                                                position:ccp(xlocation, FIXED_Y)];
            id actionMoveDone = [CCCallFuncN actionWithTarget:self 
                                                     selector:@selector(spriteMoveFinished)];
            [self.currentNumber.digit runAction:[CCSequence actions:actionMove,actionMoveDone,nil]];
            //CCLOG(@"Column No: %d",self.currentNumber.currentColumn);
        }
        
        CCLOG(@"Column No: %d",self.currentNumber.currentColumn);
    }
}

-(void)spriteMoveFinished
{   
    ;    
}


#pragma mark Position of Number in grid

-(void)AddNumberToGrid:(NSInteger)row col:(NSInteger)col number:(NumberSprite *)number
{
    NSInteger RowToAdd=[self GetRowNumberToSetSprite:col];
    if(number.SpriteType==SPRITE_TYPE_PLUS && RowToAdd>0)
    {
        NumberSprite *objNewNumber;
       
        objNewNumber = grid[RowToAdd-1][col];
        
        grid[RowToAdd-1][col]= nil;
        
        objNewNumber.NumberValue++;
        if (objNewNumber.NumberValue==10) 
        {
            objNewNumber.NumberValue=0;
        }

        if(objNewNumber.SpriteType == SPRITE_TYPE_NUMBER)
        {
            NSLog(@"%d",objNewNumber.NumberValue);
            if (objNewNumber.NumberValue==10) 
            {
                objNewNumber.NumberValue=0;
            }
            [objNewNumber ReplaceSpriteWithNewNumber:objNewNumber.NumberValue newrow:RowToAdd-1 newcolumn:col addAnimationFrame:NO];
        }
        grid[RowToAdd-1][col]=objNewNumber;
        [number RemoveSprite];
        
    }
    else if(number.SpriteType==SPRITE_TYPE_PLUS && RowToAdd==0)
    {
        NumberSprite *objSprite;
        objSprite = grid[RowToAdd][col];
        grid[RowToAdd][col]=nil;
        //grid[RowToAdd][col]=number;
        [number RemoveSprite];
        
    }
    else
    {
       
        self.isTouchEnabled=NO;
        grid[RowToAdd][col]=number;
        [self NumberInGrid];
    }
}

-(NSInteger)GetRowNumberToSetSprite:(NSInteger)col
{
    int j;
    for (j=0; j<GRID_ROW;j++) 
    {
        if (grid[j][col]==nil) 
        {
            return j;
        }
        if (j==GRID_ROW-1) 
        {
            
            //[self makeGridNil];
            return GRID_ROW;
        }
    }
    return 0;
}

-(void)makeGridNil{
    
    for (int col=0; col<GRID_COLS; col++) {
        for (int row=0; row<GRID_ROW;row++ ) {
            NumberSprite *obj=grid[row][col];
            if (obj!=nil) {
                [obj RemoveSprite];
            }
            grid[row][col] = nil;
        }
    }

}


-(void)arrangeNumberGrid{
    self.isSmileyAppeared=NO;    
    for (int col=0; col<GRID_COLS; col++) 
    {
        [self replacePos:0:col];
    }
}


-(void)replacePos:(int)row:(int)col{
    
    int rowIndex=-1;
    if(row >= GRID_ROW) return;
    
    for (; row<GRID_ROW; row++) {
        if (grid[row][col]==nil && rowIndex==-1) {
            rowIndex = row;
        }
        else if (grid[row][col]!=nil && rowIndex!=-1) {
            grid[rowIndex][col] = grid[row][col];
            grid[row][col] = nil;
            grid[rowIndex][col].rowNum = rowIndex;
            [grid[rowIndex][col] UpdateSpritePositionInGrid];
            [self replacePos:rowIndex+1:col];
            rowIndex=-1;
        }
    }
}



-(void)checkGridForMatch{
    groupings = [[NSMutableArray alloc]init];
    [self CheckGrid:GRID_ROW col:GRID_COLS scrollType:1];
    [self CheckGrid:GRID_COLS col:GRID_ROW scrollType:2];
}

-(void)releaseBlastedSprites{
    if (groupings!=nil && [groupings count]>0) 
    {
        [self CalCulateScoreofRemovesSprite];
        
        for (int k=0; k<[groupings count]; k++) 
        {
            NumberSprite *obj=[groupings objectAtIndex:k];
            
            CCLOG(@"%d",obj.NumberValue);
            CCLOG(@"%d",obj.rowNum);
            CCLOG(@"%d",obj.currentColumn);        
            //obj.digit.opacity=0;
            [obj RemoveSprite];
            
            grid[obj.rowNum][obj.currentColumn]=nil;
            if(grid[obj.rowNum][obj.currentColumn]!=nil)
            {
                CCLOG(@"UNABLE TO SET NIL");
            }

        }        
    } 
}

-(void)CheckGroup
{
        groupings = nil;
        do {        
            [self checkGridForMatch];
            [self releaseBlastedSprites];
            [self arrangeNumberGrid];
            groupings = nil;
            [self checkGridForMatch];
        } while (groupings!=nil && [groupings count]>0);
    
    
    if(app.LevelNumber<4)
    {
        if(Score_Sum>=[[app.Score_Limit objectAtIndex:app.LevelNumber-1] intValue])
        {
            NSLog(@"Score: %d",Score_Sum);
#ifdef VERSION_TENSERFREE
            
            if(Score_Sum>=FREE_VERSION_SCORE)
            {
                [background removeChild:pause cleanup:YES];
              //  [self FreeVersion_PaidVersion];
//                if([self isContinueFreeVersion]){
//                    [background removeChild:pause cleanup:YES];
//                    NumberSprite *sprt=[[NumberSprite alloc]initWithGame:self];
//                    self.currentNumber=sprt;
//                    [self FreeVersion_PaidVersion];
//                     CCLOG(@"%d",self.currentNumber.SpriteType);
//                }
            }
            else
            {
                [self LevelIncreament];
            }
#endif
            
#ifdef VERSION_TENSER
            
            [self LevelIncreament];
#endif
        }
    }
}
    
-(void)LevelIncreament
{
    app.LevelNumber++;
    app.TotalScore = Score_Sum;
    app.LastLevelno = app.LevelNumber;
    app.LastScoreValue = app.TotalScore;
    //[[NSUserDefaults standardUserDefaults]setValue:Score forKey:@"score"];
    NSLog(@"%d",app.LastScoreValue);
    
    Settings *obj_setting = [[Settings alloc] init];
    if(app.isChangeValue == YES)
    {
        app.Timer--;
        app.TimerPlus=app.Timer;
    }
    [obj_setting.Name removeFromSuperview];
    
    [self MakeScoreLevelRed:app.LevelNumber];
}

-(void)FreeVersion_PaidVersion
{
    self.isTouchEnabled = NO;
    [pause setIsEnabled:false];
    
    //[self.background removeGestureRecognizer:swiperecognizer];
    
    getPaidorNot = [CCSprite spriteWithFile:@"tenser-glass-screen test.png"];
    getPaidorNot.position=ccp(162, 240);
    getPaidorNot.scale = 0.0;
    [background addChild:getPaidorNot];

    lbltextTTF=[CCLabelTTF labelWithString:@"Download the full version for $0.99" fontName:@"Marker Felt" fontSize:16];
    lbltextTTF.position=ccp(145,100);
    self.Score_label.color=ccc3(255, 255, 255);
    [getPaidorNot addChild:lbltextTTF];

    menuNo = [CCMenuItemImage itemFromNormalImage:@"plus-button-test.png" selectedImage:@"plus-button-test.png"target:self selector:@selector(btnClickPlus)];                
    menuNo.position=ccp(78,50);
    
    menuPlus = [CCMenuItemImage itemFromNormalImage:@"no-button-test.png" selectedImage:@"no-button-test.png" target:self selector:@selector(btnClickNo)];
    menuPlus.position = ccp(215, 50);
    menuPlus.tag = 95;

    CCMenu *menu=[CCMenu menuWithItems:menuNo, menuPlus, nil];   
    menu.position = CGPointZero;
    [getPaidorNot addChild:menu]; 

    //[getPaidorNot runAction:[CCScaleTo actionWithDuration:0.8 scale:1.0]];
    [getPaidorNot runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.8 scale:1.0],[CCCallFunc actionWithTarget:self selector:@selector(Test)], nil]];
}

-(void)Test
{
   [[CCDirector sharedDirector] pause];
}

-(void)btnClickPlus
{
    [self AddGesture:self.background];
    if(Score_Sum>=FREE_VERSION_SCORE)
    {
        
       [self setContinueFreeVersion];

    }

     CCLOG(@"%d",self.currentNumber.SpriteType);
    
    [getPaidorNot runAction:[CCSequence actions:
                         [CCScaleTo actionWithDuration:0.8 scale:0.0],
                         [CCCallFunc actionWithTarget:self selector:@selector(Removepaid)],
                         nil
                         ]];
     CCLOG(@"%d",self.currentNumber.SpriteType);
    if(self.currentNumber.rowNum>5)
    {
        [self URLPageReplaceFprPlus];
    }
    else
    {
        [self URLPageReplace];       
    }
}

-(void)Removepaid
{
    [background removeChild:getPaidorNot cleanup:YES];
}

-(void)btnClickNo
{
    self.isTouchEnabled=YES;
    [pause setIsEnabled:true];
    [self AddGesture:self.background];
    [[CCDirector sharedDirector] resume];
    if(Score_Sum>=FREE_VERSION_SCORE)
    {
        if(self.currentNumber.rowNum>5)
        {
            [self MoveTogameOverScene];
        }
        else
        {
            [self setContinueFreeVersion];
            CCLOG(@"Unlimited Score");
        }
        
        [self PaidVersionButtonPosition];
    }
    else
    {
        [self MoveTogameOverScene];
    }
    
    [getPaidorNot runAction:[CCSequence actions:
                             [CCScaleTo actionWithDuration:0.8 scale:0.0],
                             [CCCallFunc actionWithTarget:self selector:@selector(Removepaid)],
                             nil
                             ]];
}

-(void)PaidVersionButtonPosition
{
    paidVersion = [CCMenuItemImage itemFromNormalImage:@"TestVersion.png" selectedImage:@"TestVersion.png"target:self selector:@selector(ToGetPaidVersion)];                
    paidVersion.position=ccp(10,-225);
    paidVersion.tag = 96;
    CCMenu *menu=[CCMenu menuWithItems:paidVersion, nil];       
    [background addChild:menu]; 
}

-(void)ToGetPaidVersion
{
    [self URLPageReplace];
}


-(void)URLPageReplace
{
    [self SavedGamePlay];
    [self performSelector:@selector(ForURL) withObject:nil afterDelay:0.1];
}

-(void)URLPageReplaceFprPlus
{
    [self SavedGamePlayForPlus];
    [self performSelector:@selector(ForURL) withObject:nil afterDelay:0.1];
}

-(void)ForURL
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/tenser/id537545910?ls=1&mt=8"]];
}

-(void)SavedGamePlayForPlus
{
    //[self.background removeGestureRecognizer:swiperecognizer];
    
    app.KeepGamePaused=NO;
    NSInteger currentNumberAnimatinState = 1;
    
    //currentNumberAnimatinState = animation_State;
    NSInteger LevelNumberStoredfroContinue = app.LevelNumber;
    NSInteger tensionValueStoredForContinue = app.Timer;
    NSLog(@"%d",tensionValueStoredForContinue);
    NSString *LastsavedProfilename = app.ProfileName;
    NSInteger ScoreForByLevel = app.LastScoreValue;
    NSLog(@"%d",ScoreForByLevel);
    
    NSInteger numberType = self.currentNumber.SpriteType;
    
    NSLog(@"%d",numberType);
    //NSInteger Last_Column_Position;
    
    if(!isTouch_Swipe)
    {
        Last_Column_Position = 3;
        CCLOG(@"********************Column No: %d",Last_Column_Position);
    }
    else
    {
        Last_Column_Position = self.currentNumber.currentColumn;
        CCLOG(@"-----------------Column No: %d",Last_Column_Position);
    }
    
    [app.LastSavedGame SavedGame:grid score:self.Score_Sum lastnumberappeared:self.currentNumber.NumberValue lastappearednumberstate:currentNumberAnimatinState lastlevelplayed:LevelNumberStoredfroContinue lasttensionselected:tensionValueStoredForContinue lastusername:LastsavedProfilename scoreByLevel:ScoreForByLevel numberType:numberType columnPosition:Last_Column_Position];
    
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[Home scene]];

}

-(void)SavedGamePlay
{
    
    //[self.background removeGestureRecognizer:swiperecognizer];
    
    app.KeepGamePaused=NO;
    //self.currentNumber.calculateFrame=YES;
    
     NSInteger currentNumberAnimatinState = [self.currentNumber SpriteImagePosition];
    NSLog(@"%d",currentNumberAnimatinState);
    //currentNumberAnimatinState = animation_State;
    NSInteger LevelNumberStoredfroContinue = app.LevelNumber;
    NSInteger tensionValueStoredForContinue = app.Timer;
    NSLog(@"%d",tensionValueStoredForContinue);
    NSString *LastsavedProfilename = app.ProfileName;
    NSInteger ScoreForByLevel = app.LastScoreValue;
    NSLog(@"%d",ScoreForByLevel);
    NSInteger numberType = self.currentNumber.SpriteType;
    NSLog(@"%d",numberType);
    //NSInteger Last_Column_Position;
    
    if(!isTouch_Swipe)
    {
        Last_Column_Position = 3;
        CCLOG(@"********************Column No: %d",Last_Column_Position);
    }
    else
    {
        Last_Column_Position = self.currentNumber.currentColumn;
        CCLOG(@"-----------------Column No: %d",Last_Column_Position);
    }
    
    [app.LastSavedGame SavedGame:grid score:self.Score_Sum lastnumberappeared:self.currentNumber.NumberValue lastappearednumberstate:currentNumberAnimatinState lastlevelplayed:LevelNumberStoredfroContinue lasttensionselected:tensionValueStoredForContinue lastusername:LastsavedProfilename scoreByLevel:ScoreForByLevel numberType:numberType columnPosition:Last_Column_Position];
    
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[Home scene]];
}


-(void)CheckGrid:(NSInteger)row col:(NSInteger)col scrollType:(NSInteger)scrolltype{
    
    isNumberMoveFromGrid=TRUE;
    for(int i =0; i< row ; i++)
    {  
        if(i==3)
        {
            CCLOG(@"jjkdfjg");
        }
        NSInteger lastHValue=0;
        
        NSMutableArray *arrSet=[[NSMutableArray alloc]initWithCapacity:(scrolltype==1?GRID_COLS:GRID_ROW)];        
        for(int j =0; j< col ; j++)
        {                        
            NumberSprite * d ;
            if (scrolltype==1) 
            {
                d= (NumberSprite *)grid[i][j];                
            }
            else
                d= (NumberSprite *)grid[j][i];            
            
            if (d!=nil) 
            {                
                CCLOG(@"%d",d.NumberValue);
                if (lastHValue+d.NumberValue==10) 
                {
                    
                    lastHValue=0;
                    NumberSprite *objFirst=[arrSet objectAtIndex:0];
                    // change added
                    BOOL IsLastNumberProcessed;
                    IsLastNumberProcessed=NO;
                    //****
                    
                    if (objFirst!=nil) 
                    {
                        if (scrolltype==1) 
                        {
                            while (j<col-1) {
                                
                                NumberSprite *checkZero = (NumberSprite *)grid[i][j+1];
                                if(checkZero != nil)
                                {
                                    if(checkZero.NumberValue == 0)
                                    {
                                        [arrSet addObject:checkZero];
                                        // change added
                                        if (j==(col-2)) {
                                            IsLastNumberProcessed=YES;
                                        }
                                        //******
                                        //[checkZero release];
                                    }
                                    else{
                                        //[checkZero release];
                                        // change added
//                                        
//                                        if (j==(col-2)) {
//                                            IsLastNumberProcessed=YES;
//                                        }
                                        
                                        //******
                                        break;
                                    }
                                }
                                else
                                {
                                    //proces to skip
                                    if (j==(col-2)) {
                                        IsLastNumberProcessed=YES;
                                    }
                                    
                                    break;
                                }
                                j++;
                            }

                            
                            j=objFirst.currentColumn;
                        }
                        else
                            j=objFirst.rowNum;
                        
                    }
                    [arrSet addObject:d];
                    NSLog(@"%d",d.currentColumn);
                    if(scrolltype==1)
                    {
                        NSInteger kk=[self CheckSum:arrSet lastnumber:d];
                        if (kk==-1) {
                            ;//j=objFirst.currentColumn;
                        }
                        else
                            j=kk;
                    
                        if (IsLastNumberProcessed==NO) {
                            if(d.currentColumn==(col-1))
                            {
                                IsLastNumberProcessed=YES;
                            }
                            else
                            {
                                IsLastNumberProcessed=NO;
                            }
                        }
                    }
                    else if(scrolltype==2)
                    {
                        NSInteger jj = [self CheckSumforRow:arrSet lastnumber:d];
                        if(jj==-1)
                        {
                            ;
                        }
                        else
                            j=jj;
                    }
                    //[d release];           
                    [self RemoveSpritess:arrSet];
                    [arrSet removeAllObjects];
                    if(scrolltype==1)
                    {
                        if (IsLastNumberProcessed==YES) 
                        {
                            NSLog(@"Skip Row");
                            break;
                        }
                    }
                }
                else if(lastHValue+d.NumberValue>10)
                {
                    lastHValue=0;
                    NumberSprite *objFirst=[arrSet objectAtIndex:0];
                    if (objFirst!=nil) 
                    {
                        if (scrolltype==1) 
                        {
                            j=objFirst.currentColumn;
                        }
                        else
                            j=objFirst.rowNum;
                        
                    }                
                    [arrSet removeAllObjects];
                }
                else
                {
                    lastHValue+=d.NumberValue;
                    [arrSet addObject:d];
                    //[d release];
                }
                CCLOG(@"LastValue : %d",lastHValue);
            
            }
            
            else
            {
                lastHValue=0;
                [arrSet removeAllObjects];
            }
        }

        isNumberMoveFromGrid=FALSE;
        
    }
    
}

-(NSInteger)CheckSum:(NSMutableArray *)array lastnumber:(NumberSprite *)lastnumber
{
    int count=0;
    int col=-1;
    for(int i = 0; i < [array count]; i++)
    {
        NumberSprite *obj = [array objectAtIndex:i];
        int total = obj.NumberValue;
        if (obj.currentColumn>col) {
            col=obj.currentColumn;
        }
        for(int j  = i+1; j<[array count]; j++)
        {
            NumberSprite *temp = [array objectAtIndex:j];
            if (temp.currentColumn>col) {
                col=temp.currentColumn;
            }
            if(total + temp.NumberValue == 10)
            {
                count++;
                total = 0;
            }
            else
            {
                total+=temp.NumberValue;
            }
        }
        
        col = obj.currentColumn;
    }
//    if (lastnumber.currentColumn>col) {
//        col=lastnumber.currentColumn;
//    }
    if (count==1) {
        return -1;
    }
    else
        return col-1;
}

-(NSInteger)CheckSumforRow:(NSMutableArray *)array lastnumber:(NumberSprite *)lastnumber
{
    int countrow = 0;
    int row = -1;
    for(int a = 0; a<[array count]; a++)
    {
        NumberSprite *obj = [array objectAtIndex:a];
        int totalforRow = obj.NumberValue;
        if(obj.rowNum>row)
        {
            row = obj.rowNum;
        }
        for(int b = a+1; b<[array count]; b++)
        {
            NumberSprite *tempRow = [array objectAtIndex:b];
            if(tempRow.rowNum>row)
            {
                row=tempRow.rowNum;
            }
            if(totalforRow + tempRow.NumberValue == 10)
            {
                countrow++;
                totalforRow=0;
            }
            else
            {
                totalforRow+=tempRow.NumberValue;
            }
        }
        row = obj.rowNum;
    }
    if(countrow==1)
    {
        return -1;
    }
    else
    return row - 1;
}

-(void)RemoveSpritess:(NSMutableArray *)arr
{
    for (int i=0; i<[arr count]; i++) 
    {        
        NumberSprite *obj=[arr objectAtIndex:i];
        if (obj!=nil) 
        {
            [groupings addObject:obj];
            //[obj release];
            
            obj.position = currentNumber.digit.position;
            //[self performSelector:@selector(Animation:) withObject:obj afterDelay:0.5];
            [[SimpleAudioEngine sharedEngine] playEffect:@"loud_big_explosion.mp3"];
            CCParticleExplosion *fireWorks=[[CCParticleExplosion alloc]initWithTotalParticles:25];
            fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"animation11_1.png"];
            fireWorks.position=obj.position;
            fireWorks.startSize=10.0;
            fireWorks.duration=1.0;
            fireWorks.endSize=0;
            [fireWorks setAutoRemoveOnFinish:YES];

            [self addChild:fireWorks];
        }
    }
    Count_Bonus++;
}

-(void)Animation:(NumberSprite *)obj
{
    CCParticleExplosion *fireWorks=[[CCParticleExplosion alloc]initWithTotalParticles:25];
    fireWorks.texture=[[CCTextureCache sharedTextureCache]addImage:@"animation11_1.png"];
    fireWorks.position=obj.position;
    fireWorks.startSize=10.0;
    fireWorks.duration=0.5;
    fireWorks.endSize=0;
 
    [self addChild:fireWorks z:1];
}

-(void)GenerateNextNumber
{

    NumberSprite *sprt=[[NumberSprite alloc]initWithGame:self];
    self.currentNumber=sprt;
    return;
}

-(BOOL)IsSmileyPresentInGrid
{
    for (int col=0; col<7; col++) 
    {
        for (int row=0; row<6;row++ ) 
        {            
            NumberSprite * obj1=grid[row][col];
            if (obj1!=nil) 
            {
                CCLOG(@"%d",obj1.NumberValue);
                if (obj1.SpriteType == SPRITE_TYPE_SMILEY) 
                {
                    return YES;
                }
            }
        }        
    }
    return NO;
}

-(BOOL)IsFrownyPresentInGrid
{
    for (int col=0; col<7; col++) 
    {
        for (int row=0; row<6;row++ ) 
        {            
            NumberSprite * obj1=grid[row][col];
            if (obj1!=nil) 
            {
                CCLOG(@"%d",obj1.NumberValue);
                if (obj1.SpriteType == SPRITE_TYPE_FROWNY)
                {
                    return YES;
                }
            }
        }        
    }
    return NO;
}

-(void)NumberInGrid
{
    for (int col=0; col<7; col++) 
    {
        for (int row=0; row<6;row++ ) 
        {            
            NumberSprite * obj1=grid[row][col];
            if (obj1!=nil) 
            {
                CCLOG(@"%d",obj1.NumberValue);
                if(obj1.SpriteType == SPRITE_TYPE_NUMBER)
                {
                    CCLOG(@"NUMBER"); 
                }
                if (obj1.SpriteType == SPRITE_TYPE_SMILEY) 
                {
                    CCLOG(@"SMILEY");
                    //return YES;
                }
                if (obj1.SpriteType == SPRITE_TYPE_FROWNY)
                {
                    CCLOG(@"FROWNY");
                    //return YES;
                }
            }
        }        
    }
}

#pragma mark Level Change

-(void)MakeScoreLevelRed:(NSInteger) LevelNumber{
    labelname.color = ccc3(255, 0, 0);
    [labelname setString:[NSString stringWithFormat:@"Level %d",LevelNumber]];
    [self performSelector:@selector(MakeScoreLevelWhite) withObject:nil afterDelay:3.0];
}


-(void)MakeScoreLevelWhite
{
    labelname.color=ccc3(255, 255, 255);        
}

-(void)ReplaceScene
{
    [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

-(void)gameOverPage;
{   
    [app.LastSavedGame GameOver:app.ProfileName Tension:app.Timer];
    app.LastSavedGame.LastSavedGameExists = NO;
    
    [[CCDirector sharedDirector]replaceScene:[Level scene:2]];
}

-(void)MoveTogameOverScene
{

    self.isTouchEnabled = NO;
    [pause setIsEnabled:false];
    
    
    //[self.background removeGestureRecognizer:swiperecognizer];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
     [NSString stringWithFormat:@"GreenFrowny.plist"]];
    self.spriteSheet_forFrowny = [CCSpriteBatchNode 
                        batchNodeWithFile:[NSString stringWithFormat:@"GreenFrowny.png"]];
    [self.background addChild:self.spriteSheet_forFrowny];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for(int i = 1; i <= 23; i++) {
        //CCSpriteFrame *frame = [cache spriteFrameByName:[NSString stringWithFormat:@"%d-animation-%d.png",number,i]];
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"greenfrowny_%d.png",i]]];
    }
    imageAnimation = [CCAnimation animationWithFrames:walkAnimFrames delay:3];
    self.frowny_Gameover = [CCSprite spriteWithSpriteFrameName:@"greenfrowny_1.png"]; 
    if (imageAnimation!=nil) 
    {
        CCAnimate *animate = [CCAnimate actionWithDuration:3 animation:imageAnimation restoreOriginalFrame:NO];
        CCRepeat *repeat = [CCRepeat actionWithAction:animate times:1];
        id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(gameOverPage)];
        [self.frowny_Gameover runAction:[CCSequence actions:repeat,actionMoveDone,nil]];
    }
    [self.spriteSheet_forFrowny addChild:self.frowny_Gameover];
    self.frowny_Gameover.position = ccp(160, 240);
}

-(void)TimeDifferenceForScorePost
{
    NSDate *Endtime = [NSDate date];
    NSTimeInterval timeDifference = [Endtime timeIntervalSinceDate:app.GameStartTime];
    timeDifference = timeDifference * 1000;
    //NSLog(@"%f",timeDifference);
    long double_timedifference = timeDifference;
    //NSLog(@"%ld",double_timedifference);
    app.Time_difference = double_timedifference;
}


-(void)UnScheduleNumberGeneration
{
    [self unschedule:@selector(GenerateNextNumber)];
}
-(void)ScheduleNumberGeneration
{
    [self schedule:@selector(GenerateNextNumber) interval:app.Timer];
}

-(void)AddGesture:(CCNode *)node
{
    
    //self.background.isTouchEnabled_Check = YES;
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]init];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionDown;
    
    //swiperecognizer = [CCGestureRecognizer CCRecognizerWithRecognizerTargetAction:swipeGesture target:self action:@selector(Swipe:node:)];
    
    //[self.background addGestureRecognizer:swiperecognizer];
    
}


-(void) Swipe:(UIGestureRecognizer*)recognizer node:(CCNode*)node
{
     self.isTouchEnabled=NO;
     CCLOG(@"Swipe Called");
     self.moveNumber = NO;
     [self.currentNumber DropSprite:YES];
}


//////////////////////////////
-(void)setContinueFreeVersion{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"GameContinue"];
}

-(BOOL)isContinueFreeVersion{
    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:@"GameContinue"];
    return  flag;
}

@end
