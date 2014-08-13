//
//  Settings.m
//  TENSER
//
//  Created by Arijit Da on 26/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"
#import "GameLayer.h"
#import "AppDelegate.h"

//#define CHANGE_BY_LEVEL 0
//#define DEFAULT_TENSION_VALUE 4

@implementation Settings
@synthesize back_bar;
@synthesize meter;
@synthesize tad;
@synthesize Name;
@synthesize tadmove;
@synthesize Your_name;
@synthesize objGamestate;
@synthesize tensionValue;
@synthesize alert;


AppController *app;


+(CCScene *)scene{
    CCScene *scene=[CCScene node];
    Settings *settings=[Settings node];
    [scene addChild:settings];
    return scene;
}

-(id)init
{
    if (self=[super init]) 
    {
        isTextfieldFocused = false;
       
        //app = [[UIApplication sharedApplication] delegate];
        
        
        tensionValue = DEFAULT_TENSION_VALUE;
        self.isTouchEnabled = YES;
        CCSprite *background=[CCSprite spriteWithFile:@"settings-screen.png"];
        background.position=ccp(160, 240);
        [self addChild:background];
        
        CCMenuItemImage *save=[CCMenuItemImage itemFromNormalImage:@"save-deselet-normal.png" selectedImage:@"save-selet-normal.png"target:self selector:@selector(Save:)];                
        save.position=ccp(0,-200);
        
        CCMenu *menu=[CCMenu menuWithItems:save, nil];
        
        [self addChild:menu];
        
        Your_name = [CCSprite spriteWithFile:@"your-name.png"];
        Your_name.position = ccp(165,108);
        [self addChild:Your_name];
        
        
        back_bar = [CCSprite spriteWithFile:@"back-bar-normal.png"];
        back_bar.position = ccp(110,242);
        [background addChild:back_bar];
        
        /*meter = [CCSprite spriteWithFile:@"Meter-normal.png"];
         meter.position = ccp(6, 55);
         [back_bar addChild:meter];*/
        
        tad = [CCSprite spriteWithFile:@"tad-normal.png"];
        tad.position = ccp(110, 288);
        
        lastTadTouchPosition=CGPointMake(116, 372);
        
        //[back_bar addChild:tad];
        [self addChild:tad];       
        
        CCLOG(@"%f",self.tad.position.x);
        CCLOG(@"%f",self.tad.position.y);
        CCLOG(@"%f",self.tad.contentSize.width);
        CCLOG(@"%f",self.tad.contentSize.height);
        
        CCLOG(@"%f",self.back_bar.position.x);
        CCLOG(@"%f",self.back_bar.position.y);
        CCLOG(@"%f",self.back_bar.contentSize.width);
        CCLOG(@"%f",self.back_bar.contentSize.height);
        
        
        CCLOG(@"%f",self.meter.position.x);
        CCLOG(@"%f",self.meter.position.y);
        CCLOG(@"%f",self.meter.contentSize.width);
        CCLOG(@"%f",self.meter.contentSize.height);
        
        
        Name = [[UITextField alloc] initWithFrame:CGRectMake(60, 371, 204, 31)];
        [Name setDelegate:self];
        //[Name setFont:[UIFont systemFontOfSize:15]];
        
        /*BOOL boolValue = [[NSUserDefaults standardUserDefaults]boolForKey:@"on"];
        if(boolValue == YES)
        {
            
           Name.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
        }*/
        if([[NSUserDefaults standardUserDefaults]valueForKey:@"username"])
        {
            Name.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"username"];
        }
        else
        {
            [Name setText:@""];  
        }
        //[Name setText:@""];
        [Name setFont:[UIFont fontWithName:@"Marker Felt" size:15]];
        Name.backgroundColor = [UIColor clearColor];
        [Name setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];
        [[[[CCDirector sharedDirector] openGLView] window] addSubview:Name];
        //[Name becomeFirstResponder];
        
    }
    return self;
}


//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    if(self.tad.position.y>=168 && self.tad.position.y<=258)
//    {
//        self.tad.visible = NO;
//    }
//    
//}
//
//
//-(void)animationDidStart:(CAAnimation *)anim
//{
//    if(self.tad.position.y>=168 && self.tad.position.y<=258)
//    {
//        self.tad.visible = NO;
//    }
//}
 
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    isTextfieldFocused = true;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    Name.frame=CGRectMake(60, 230, 204, 31);
    
    //Your_name.position = ccp(165, 250);
    
    id actionMove = [CCMoveTo actionWithDuration:.425 
                                        position:ccp(165, 250)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self 
                                             selector:@selector(spriteMoveFinished)];
    [self.Your_name runAction:[CCSequence actions:actionMove,actionMoveDone,nil]];
    if(self.tad.position.y>=168 && self.tad.position.y<=258)
    {
        self.tad.visible = NO;
    }

    [UIView commitAnimations];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    isTextfieldFocused = false;
    [Name resignFirstResponder];
    Name.frame = CGRectMake(60, 371, 204, 31);
    Your_name.position = ccp(165, 108);
    
    self.tad.visible = YES;
    
    return YES;
}




bool isPointerTouched;

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isPointerTouched = false;
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchlocation = [touch locationInView:[touch view]];
    //oldtouch = tad.position.y;
    //touchlocation.y = 480-touchlocation.y;
    Touch_Start = touchlocation.x;
    
    lastTadTouchPosition=touchlocation;
    CGRect correctColorSprite1 = CGRectMake(
                                            tad.position.x - tad.contentSize.width, 
                                            480-tad.position.y - tad.contentSize.height, 
                                            50+tad.contentSize.width, 
                                            50+tad.contentSize.height);
    //CGRect rectTab = [tad boundingBox];
        if (CGRectContainsPoint(correctColorSprite1, touchlocation)) {
        isPointerTouched = true;
        }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(isTextfieldFocused)
        return;
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchlocation = [touch locationInView:[touch view]];
    touchlocation.y = 480 - touchlocation.y;
    NSInteger y=(NSInteger)touchlocation.y;
    
    if (isPointerTouched) {
        if (y<168) {
            tad.position=ccp(110, 168);
        }
        else if (y>316) {
            tad.position=ccp(110, 316);
        }
        else {
            tad.position=ccp(110, touchlocation.y);
        }
    }
    
    
    
    //    CGRect rectTab = [tad boundingBox];
    //    if (CGRectContainsPoint(rectTab, touchlocation)) {
    //        if (y<168) {
    //            tad.position=ccp(110, 168);
    //        }
    //        else if (y>316) {
    //            tad.position=ccp(110, 316);
    //        }
    //        else {
    //            tad.position=ccp(110, touchlocation.y);
    //        }
    //    }
}
-(void)spriteMoveFinished{
    ;    
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    isPointerTouched = false;
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchlocation = [touch locationInView:[touch view]];
    //touchlocation.x = 320-touchlocation.x;
    touchlocation.y = 480 - touchlocation.y;
    CCLOG(@"X:%f Y:%f",self.tad.position.x,self.tad.position.y);
    CCLOG(@"Width:%f Height:%f",self.tad.contentSize.width,self.tad.contentSize.height);
    CCLOG(@"X:%f Y:%f",self.back_bar.position.x,self.back_bar.position.y);
    CCLOG(@"X:%f Y:%f",touchlocation.x,touchlocation.y);
    NSInteger upperdiff;
    NSInteger lowerdiff;
    
    if (tad.position.y>=168 && tad.position.y<=198) 
    {
        lowerdiff=abs((NSInteger)168-tad.position.y);
        upperdiff=abs((NSInteger)198-tad.position.y);
        if (lowerdiff<upperdiff) 
        {
            tad.position=ccp(110, 168);
            tensionValue=DEFAULT_TENSION_VALUE;
            app.isChangeValue=YES;
        }
        else
        {
            tad.position=ccp(110, 198);
            tensionValue=1;
            app.isChangeValue=NO;
        }
        
    }
    else if (tad.position.y>198 && tad.position.y<=228)
    {
        lowerdiff=abs((NSInteger)198-tad.position.y);
        upperdiff=abs((NSInteger)228-tad.position.y);
        if (lowerdiff<upperdiff) 
        {
            tad.position=ccp(110, 198);
            tensionValue=1;
            app.isChangeValue=NO;
        }
        else
        {
            tad.position=ccp(110, 228);
            tensionValue=2;
            app.isChangeValue=NO;
        }        
    }
    else if (tad.position.y>228 && tad.position.y<=258)
    {
        lowerdiff=abs((NSInteger)228-tad.position.y);
        upperdiff=abs((NSInteger)258-tad.position.y);
        if (lowerdiff<upperdiff) 
        {
            tad.position=ccp(110, 228);
            tensionValue=2;
            app.isChangeValue=NO;
        }
        else
        {
            tad.position=ccp(110, 258);
            tensionValue=3;
            app.isChangeValue=NO;
        }
        
    }
    else if (tad.position.y>258 && tad.position.y<=288)
    {
        lowerdiff=abs((NSInteger)258-tad.position.y);
        upperdiff=abs((NSInteger)288-tad.position.y);
        if (lowerdiff<upperdiff) 
        {
            tad.position=ccp(110, 258);
            tensionValue=3;
            app.isChangeValue=NO;
        }
        else
        {
            tad.position=ccp(110, 288);
            tensionValue=4;
            app.isChangeValue=NO;
        }
    }
    else if(tad.position.y>288 && tad.position.y<=316)
    {
        lowerdiff=abs((NSInteger)288-tad.position.y);
        upperdiff=abs((NSInteger)316-tad.position.y);
        if(lowerdiff<upperdiff)
        {
            tad.position=ccp(110, 288);
            tensionValue=4;
            app.isChangeValue=NO;
        }
        else
        {
            tad.position=ccp(110, 316);
            tensionValue=5;
            app.isChangeValue=NO;
        }
//        tensionValue=5;
//        app.isChangeValue=NO;
    }
    
    
    return; //ARIJIT
    
    if (touchlocation.x<=120 && touchlocation.x>=98 && touchlocation.y>=self.tad.contentSize.width/2 && touchlocation.y<=480-self.tad.contentSize.width/2)
    {
        CCLOG(@"Touches allowed");
        
        if((touchlocation.y) >= (self.back_bar.position.y - self.back_bar.contentSize.height/2) && (touchlocation.y) <= (self.back_bar.position.y + self.back_bar.contentSize.height/2))
        {
            
                       
            
            NSInteger lowerCorner = (self.back_bar.position.y - self.back_bar.contentSize.height/2);
            
            currentposition = ((touchlocation.y)-(self.back_bar.position.y - self.back_bar.contentSize.height/2));
            currentposition = currentposition/28;
            NSLog(@"%d",currentposition);
            NSInteger ylocation = lowerCorner + 28*currentposition +14;
            
            NSLog(@"%d",lowerCorner);
            NSLog(@"%f",(self.back_bar.position.y + self.back_bar.contentSize.height/2));
            NSLog(@"%d",ylocation);
            NSInteger tadposition = ylocation - lowerCorner;
            id actionMove = [CCMoveTo actionWithDuration:.5 
                                                position:ccp(6, tadposition)];
            NSLog(@"%d",ylocation-lowerCorner);
            id actionMoveDone = [CCCallFuncN actionWithTarget:self 
                                                     selector:@selector(spriteMoveFinished)];
            [self.tad runAction:[CCSequence actions:actionMove,actionMoveDone,nil]];
            
            tensionValue = currentposition;
            
            if(tensionValue == CHANGE_BY_LEVEL)
            {
                tensionValue = DEFAULT_TENSION_VALUE;
                NSLog(@"%d",tensionValue);
                app.isChangeValue = YES;
            }
            
            NSLog(@"%d",tensionValue);
            
        }
    }
    
    else
    {
        CCLOG(@"Touches not allowed");
    }
    
}


-(void)Save:(CCMenuItem *)sender
{
    if([Name.text isEqualToString: @""])
    {
        alert = [[UIAlertView alloc] initWithTitle:@"Tenser" message:@"Please write your name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //[alert setDelegate:self];
        [alert show];
        //[[[[CCDirector sharedDirector] openGLView] window] addSubview:alert];
        
    }
    else
    {
        [app.LastSavedGame SavedName:self Name:Name.text TensionSelected:tensionValue];
        app.Timer=tensionValue;
        app.TimerPlus=app.Timer;
        NSLog(@"%d",app.Timer);
        NSLog(@"%d",app.TimerPlus);
        
       // [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"on"];
        [[NSUserDefaults standardUserDefaults]setValue:Name.text forKey:@"username"];
        
        [Name removeFromSuperview];
        
        [self StartTime];
        
        [[CCDirector sharedDirector]replaceScene:[GameLayer scene]];

    }
}

-(void)StartTime
{
    NSDate *startdate = [NSDate date];
    NSLog(@"%@",startdate);
    app.GameStartTime = startdate;
    NSLog(@"%@",app.GameStartTime);
}

-(void)dealloc
{

}

@end
