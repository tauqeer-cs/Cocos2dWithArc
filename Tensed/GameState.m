//
//  GameState.m
//  TENSER
//
//  Created by Mac Mini 4 on 29/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameState.h"
#import "DbController.h"
//#import "GameLayer.h"
#import "Settings.h"



@implementation GameState
@synthesize LastNumberAppeared;
@synthesize LastSavedScore;
//@synthesize NumberData;
@synthesize storedArray;
//@synthesize numberalreadyappeared;
@synthesize LastSavedGameExists;
@synthesize xValue;
@synthesize yValue;
@synthesize lastvalue;
@synthesize point;
@synthesize objgamelayer;
@synthesize LastUserName;
@synthesize LastTension;
@synthesize LastNumberAnimatinState;
@synthesize LastLevelPlayed;
@synthesize LastTensionSelected;
@synthesize ScoreByLevel;
@synthesize NumberType;
@synthesize ColumnPosition;
@synthesize savedGame;


-(id)init
{
    if (self=[super init])
    {
        //app = [[UIApplication sharedApplication] delegate];
        
        
        
        self.LastNumberAppeared=-1;
        self.LastSavedScore=-1;
        self.storedArray=[[NSMutableArray alloc]init];
    }
    return self;
}

-(void)myfunc:(NumberSprite *)myarg dim1:(int)dim1 dim2:(int)dim2{
    int test[dim1][dim2],x,y;
    
    
    union Data
    {
        char  data[36];
        float f[9];
    };
    
    
    union Data data;
    data.data[0] = dim1;
    data.data[1] = dim2;
    
 //   fprintf(stdout,"float is %f\n",data.float[0]);
    
   // memcpy((void *)test,(void *)myarg,(size_t)dim1*dim2*sizeof(int));
    
    
    for(x=0;x < dim1;x++) {
        for(y=0;y < dim2;y++) {
            printf("test[%d][%d] = %d\n",x,y,test[x][y]);
        }
    }
}

-(void)LoadSavedGame
{
    self.LastSavedGameExists=NO;
    [self.storedArray removeAllObjects];
    ResultSet *rs= [[DbController database]executeQuery:@"select * from SavedGameMain"];
    while ([rs next]) 
    {
        self.LastSavedScore=[rs intForColumn:@"LastSavedScore"];
        self.LastNumberAppeared=[rs intForColumn:@"LastNumberAppeared"]; 
        self.LastUserName = [rs stringForColumn:@"UserName"];
        self.LastNumberAnimatinState=[rs intForColumn:@"LastNumberAnimationState"];
        self.LastLevelPlayed=[rs intForColumn:@"LastLevelPlayed"];
        self.LastTensionSelected = [rs intForColumn:@"Tension"];
        self.ScoreByLevel = [rs intForColumn:@"ScoreByLevel"];
        self.NumberType = [rs intForColumn:@"LastSpriteType"];
        self.ColumnPosition = [rs intForColumn:@"LastColumnPosition"];
        self.savedGame = [rs intForColumn:@"isSaved"];
        if(self.savedGame==0)
        {
           self.LastSavedGameExists=NO; 
        }
        else
        self.LastSavedGameExists=YES;
        
        NumberSprite *obj_sprite = [[NumberSprite alloc] init];
        obj_sprite.NumberValue = self.LastNumberAppeared;
        obj_sprite.digit = [CCSprite spriteWithFile:[NSString stringWithFormat:@"%d",obj_sprite.NumberValue]];
        point = CGPointMake(160, 410);
        obj_sprite.digit.position = point;
       // [obj_sprite release];   /***** Manual Release *****/
    }
    
    //SavedGameBoard
    rs= [[DbController database]executeQuery:@"select * from SavedGameBoard"];
    while ([rs next]) {
        NSInteger NumberValue=[rs intForColumn:@"NumberValue"];
        NSInteger RowNUmber=[rs intForColumn:@"RowNumber"];
        NSInteger ColumnNumber=[rs intForColumn:@"ColumnNumber"];
        NSInteger Number_Type=[rs intForColumn:@"NumberType"];
        NumberSprite *sprite=[[NumberSprite alloc]init]; //WithGameAndNumber:theGame number:NumberValue];
        sprite.NumberValue=NumberValue;                   
        sprite.currentColumn=ColumnNumber;
        sprite.rowNum=RowNUmber;
        sprite.SpriteType=Number_Type;
        CCLOG(@"%d",sprite.SpriteType);
        [self.storedArray addObject:sprite];
        //[sprite release];   /***** Manual Release *****/
    }
   

}
-(void)RemoveSavedGame{
    [[DbController database]executeUpdate:@"delete from SavedGameBoard"];
    [[DbController database]executeUpdate:@"delete from SavedGameMain"];
    
}
 //:(NumberSprite *[5][7])map Score:(NSInteger)score Number:(NSInteger)number


-(void)GameOver:(NSString *)UserName Tension:(NSInteger)tension 
{
    [self RemoveSavedGame];
    //Settings *obj_setting = [[Settings alloc] init];
    NSString *query = [NSString stringWithFormat:@"Insert into SavedGameMain(UserName,LastSavedScore,LastNumberAppeared,Tension,LastNumberAnimationState,LastLevelPlayed,ScoreByLevel,LastSpriteType,LastColumnPosition,isSaved) values('%@',%d,%d,%d,%d,%d,%d,%d,%d,%d)",UserName , 0,0,tension,1,0,0,0,0,0];
    [[DbController database]executeUpdate:query];
}

-(void)SavedName:(Settings *)setting Name:(NSString *)name TensionSelected:(NSInteger)tension

{
    [self RemoveSavedGame];
    //Settings *obj_setting = [[Settings alloc] init];
    NSString *query = [NSString stringWithFormat:@"Insert into SavedGameMain(UserName,LastSavedScore,LastNumberAppeared,Tension,LastNumberAnimationState,LastLevelPlayed,ScoreByLevel,LastSpriteType,LastColumnPosition,isSaved) values('%@',%d,%d,%d,%d,%d,%d,%d,%d,%d)",name , 0,0,tension,1,0,0,0,0,0];
    [[DbController database]executeUpdate:query];
    
    /*App Delegate Stuff*/
    app.ProfileName=name;
    app.Timer = tension;
   
    
}


-(void)SavedGame:(__strong NumberSprite *[6][7])grid score:(NSInteger)score lastnumberappeared:(NSInteger)lastnumberappeared lastappearednumberstate:(NSInteger)lastappearednumberstate lastlevelplayed:(NSInteger)lastlevelplayed lasttensionselected:(NSInteger)lasttensionselected lastusername:(NSString *)lastusername scoreByLevel:(NSInteger)scoreByLevel numberType:(NSInteger)numberType columnPosition:(NSInteger)columnPosition
{
 
    [self RemoveSavedGame];    
    self.LastSavedScore=score;
    self.LastNumberAppeared=lastnumberappeared;
    self.LastLevelPlayed=lastlevelplayed;
    self.LastTensionSelected=lasttensionselected;
    self.LastUserName=lastusername;
    self.ScoreByLevel=scoreByLevel;
    self.NumberType=numberType;
    self.ColumnPosition=columnPosition;
    //Save Score, last number etc.
    
    NSLog(@"%d",lasttensionselected);
    NSLog(@"%d",lastlevelplayed);
    NSLog(@"%@",lastusername);
    NSString *query=[NSString stringWithFormat:@"Insert into SavedGameMain(UserName,LastSavedScore,LastNumberAppeared,Tension,LastNumberAnimationState,lastLevelPlayed,ScoreByLevel,LastSpriteType,LastColumnPosition,isSaved) values('%@',%d,%d,%d,%d,%d,%d,%d,%d,1)",lastusername , score,lastnumberappeared,lasttensionselected,lastappearednumberstate,lastlevelplayed,scoreByLevel,numberType,columnPosition];
    [[DbController database]executeUpdate:query];
    //Add game board numbers
    for (int i=0; i<6; i++) 
    {
        for (int j=0; j<7; j++) 
        {
            NumberSprite *obj=grid[i][j];
            if (obj!=nil)
            {
                NSLog(@"Current Column :%d",obj.currentColumn);
                NSLog(@"Curent Row : %d",obj.NumberValue);
                
                NSString *string = [NSString stringWithFormat:@"insert into SavedGameBoard(GameID,RowNumber,ColumnNumber,NumberValue,NumberType) values (1,%d,%d,%d,%d)", obj.rowNum,obj.currentColumn,obj.NumberValue,obj.SpriteType];
                [[DbController database]executeUpdate:string];
            }
        }
    }
    [self LoadSavedGame];
}

-(void)AddSavedGameToGamelayer:(GameLayer *)gamelayer grid:(__strong NumberSprite *[5][7])grid
{
    for(int i=0;i<[self.storedArray count];i++)
    {
        NumberSprite *obj=[self.storedArray objectAtIndex:i];
        NumberSprite *newNumber = [[NumberSprite alloc]initWithGameAndNumber1:gamelayer lastsavednumber:obj.NumberValue RowNumber:obj.rowNum ColumnNumber:obj.currentColumn number_type:obj.SpriteType];
        grid[newNumber.rowNum][newNumber.currentColumn]=newNumber;
    }
}



@end

