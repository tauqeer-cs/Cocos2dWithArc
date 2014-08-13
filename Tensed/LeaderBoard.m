//
//  LeaderBoard.m
//  TENSER
//
//  Created by Mac Mini 4 on 02/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LeaderBoard.h"
#import "Home.h"
#import "InternetValidation.h"
#import "ParseLeaderBoard.h"
//#import "InternetValidation.h"
//#import "LeaderBoardCell.h"

@implementation LeaderBoard
@synthesize backgroundLeaderboard;
@synthesize menuItemImage;
@synthesize menuLeaderBoard;
@synthesize Highest_Score;

@synthesize obj_Gamestate;
@synthesize LeaderBoardArray;
@synthesize LeaderBoardTable;
@synthesize act_loadingView;
@synthesize view;
@synthesize Tension;

AppController *app;

+(CCScene *)scene{
    CCScene *scene=[CCScene node];
    LeaderBoard *leaderboard=[LeaderBoard node];
    
    [scene addChild:leaderboard];
    //[leaderboard LoadSavedName];
    return scene;
    
}

/*+(CCScene *)sceneWithLastName:(GameState*)lastName
{
    CCScene *scene=[CCScene node];
    LeaderBoard *leaderboard=[LeaderBoard node];
    
    [scene addChild:leaderboard];
    [leaderboard LoadSavedName:lastName];
    
    return scene;
}*/

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
        CGSize winsize=[[CCDirector sharedDirector]winSize];
        
        app = [[UIApplication sharedApplication] delegate];
        
        backgroundLeaderboard=[CCSprite spriteWithFile:@"LeaderScreen-board.png"];
        backgroundLeaderboard.position=ccp(160, 240);
        [self addChild:backgroundLeaderboard];
        
        menuItemImage = [CCMenuItemImage itemFromNormalImage:@"menu-deselect.png" selectedImage:@"menu-select.png"target:self selector:@selector(goToHomeFromLeaderBoard:)];
        menuItemImage.position = ccp(winsize.width/2-200, winsize.height/2-445);
        
        Tension = 4;
         [self InitialTensionImageValue];     
        
        menuLeaderBoard=[CCMenu menuWithItems:menuItemImage, nil];
        [self addChild:menuLeaderBoard];
        LeaderBoardTable = [[UITableView alloc] initWithFrame:CGRectMake(40, 145, 245, 280)];
        LeaderBoardTable.delegate = self;
        LeaderBoardTable.dataSource = self;
        LeaderBoardTable.backgroundColor = [UIColor clearColor];
        [[[[CCDirector sharedDirector] openGLView] window] addSubview:LeaderBoardTable];
        [self LeaderBoardURL];
        
    }
    return self;
}

#pragma mark Initial Tension value

-(void)InitialTensionImageValue
{
    CGSize winsize=[[CCDirector sharedDirector]winSize];
    TensionValueChange = 4;
    TensionMenuItem = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"tension-%d.png",TensionValueChange] selectedImage:[NSString stringWithFormat:@"tension-%d.png",TensionValueChange] target:self selector:@selector(TensionImageChangeOnClick)];
    TensionMenuItem.position=ccp(winsize.width/2-120, winsize.height/2-75);
    CCMenu *menu=[CCMenu menuWithItems:TensionMenuItem, nil];       
    [backgroundLeaderboard addChild:menu];
}

#pragma mark Tension value chnage on click the tension button

-(void)TensionImageChangeOnClick
{
    CGSize winsize=[[CCDirector sharedDirector]winSize];

    if(TensionValueChange<6)
    {
        NSLog(@"Tension Value: %d",TensionValueChange);
        TensionValueChange++;
        if (TensionValueChange==6) {
            TensionValueChange=TENSION_VALUE_FOR_CHANGE_LEVEL;
        }
        NSLog(@"Tension Value: %d",TensionValueChange);
    }
    else if(TensionValueChange==TENSION_VALUE_FOR_CHANGE_LEVEL)
    {
        NSLog(@"Tension Value: %d",TensionValueChange);
        TensionValueChange=1;
        NSLog(@"Tension Value: %d",TensionValueChange);
    }
    
    /*if (TensionValueChange==6) {
        TensionValueChange=TENSION_VALUE_FOR_CHANGE_LEVEL;
    }*/
    
    TensionMenuItem = [CCMenuItemImage itemFromNormalImage:[NSString stringWithFormat:@"tension-%d.png",TensionValueChange] selectedImage:[NSString stringWithFormat:@"tension-%d.png",TensionValueChange] target:self selector:@selector(TensionImageChangeOnClick)];
    TensionMenuItem.position=ccp(winsize.width/2-120, winsize.height/2-75);
    CCMenu *menu=[CCMenu menuWithItems:TensionMenuItem, nil];       
    [backgroundLeaderboard addChild:menu];
    [self LeaderBoardURL];
}


#pragma mark To show the top 10 players SCORE and NAME for each TENSION

-(void)LeaderBoardURL
{
//    if(view!=nil)
//    {
//        [view removeFromSuperview];
//    }
    
    if([InternetValidation connectedToNetwork]==YES)
    {
        if(view)
        {
            [view removeFromSuperview];
            view = NULL;
            act_loadingView = NULL;
        }
        
        act_loadingView = [[LoadView alloc] init];
        view = [act_loadingView ShowActivity:@"Loading...."];
        [[[[CCDirector sharedDirector] openGLView] window] addSubview:view];
        NSString *version;
#ifdef VERSION_TENSERFREE
        
        version = [NSString stringWithFormat:@"%d",0];
#endif
        
#ifdef VERSION_TENSER
        
        version = [NSString stringWithFormat:@"%d",1];
#endif
        NSString *strtenservalue = [NSString stringWithFormat:@"%d",TensionValueChange];
        NSString *soapMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                                 "<soap:Body>"
                                 "<GetLeaderBoard xmlns=\"http://alphaheuristix.com/indusnettenser/\">"
                                 "<TensionNo>%@</TensionNo>"
                                 "<Version>%@</Version>"
                                 "</GetLeaderBoard>"
                                 "</soap:Body>"
                                 "</soap:Envelope>",strtenservalue,version];
        
        NSURL *url = [NSURL URLWithString:TenserLeaderBoardURL];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        NSString *msgLength = [NSString stringWithFormat:@"%d",[soapMessage length]];
        [theRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue:@"http://alphaheuristix.com/indusnettenser/GetLeaderBoard" forHTTPHeaderField:@"SOAPAction"];
        [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
        
        if( theConnection )
		{
			webdata = [NSMutableData data];
		}
		else
		{
			NSLog(@"theConnection is NULL");
		}
        //[theConnection release]; /***** Manual Release *****/
        
        
    }
    
    else
    {
		UIAlertView *alt_LeaderBoardNoConn = [[UIAlertView alloc]initWithTitle:AlertTitle message:ConnectionUnavailable delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
		[alt_LeaderBoardNoConn show];
        [self performSelector:@selector(CloseAlert:) withObject:alt_LeaderBoardNoConn afterDelay:3.0];
	}
     
}


#pragma mark -
#pragma mark HTTPResponseDelegate Methods
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webdata setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webdata appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [act_loadingView HideActivity];
    [view removeFromSuperview];
        
    UIAlertView *altVw_LBRegSucc= [[UIAlertView alloc]initWithTitle:AlertTitle message:ConnectionUnavailable delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];	
    [altVw_LBRegSucc show];
    [self performSelector:@selector(CloseAlert:) withObject:altVw_LBRegSucc afterDelay:3.0];
}

-(void)CloseAlert:(UIAlertView *)alertview
{
    [alertview dismissWithClickedButtonIndex:0 animated:YES];
    //[alertview removeFromSuperview];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSString *value = [[NSString alloc]initWithData:webdata encoding:NSUTF8StringEncoding];

	ParseLeaderBoard *obj = [[ParseLeaderBoard alloc]init];
    
    [obj parseXMLFileAtData:webdata parseError:nil];
    LeaderBoardArray = obj.LocalArray;
    NSLog(@"%d",[LeaderBoardArray count]);
    
    [act_loadingView HideActivity];
    [view removeFromSuperview];
    
    if(obj.Resp_Code==0)
    {
        [LeaderBoardTable reloadData];
    }
    else if(obj.Resp_Code==1)
    {
        UIAlertView *altVw_LBRegSucc= [[UIAlertView alloc]initWithTitle:AlertTitle message:RegistrationUnSuccessfullAlert delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];	
        [altVw_LBRegSucc show];

    }
}

#pragma mark tableViewDelegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [LeaderBoardArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UILabel *Name = nil;
    UILabel *Score = nil;
    
    
    
    static NSString *CellIdentifier = @"Cell";
    
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier"];
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        LeaderBoardProperty *obj = [LeaderBoardArray objectAtIndex:indexPath.row];
        
        Name = [[UILabel alloc] initWithFrame:CGRectZero];
        
       
        Name.textAlignment=UITextAlignmentLeft;
        Name.backgroundColor=[UIColor clearColor];
        [Name setFont:[UIFont fontWithName:@"Marker Felt" size:15]];
        [Name setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];
        
        Score = [[UILabel alloc] initWithFrame:CGRectZero];
        //[Score setLineBreakMode:UILineBreakModeWordWrap];
        
        //[Score setNumberOfLines:0];
        //[labelText setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        Score.textAlignment = UITextAlignmentCenter;
        Score.backgroundColor=[UIColor clearColor];
        [Score setFont:[UIFont fontWithName:@"Marker Felt" size:15]];
        [Score setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];
        
        [Name setText:obj.UserName];
        //[Name setText:app.ProfileName];
        [Score setText:[NSString stringWithFormat:@"%d",obj.Score]];
        
        [[cell contentView] addSubview:Name];
        [[cell contentView] addSubview:Score];
    }
    //[labelName setText:obj.UserName];
//    [Name setText:@"Matt Damon"];
    [Name setFrame:CGRectMake(10, 5, 150,21)];
//    [Score setText:[NSString stringWithFormat:@"%d",1000]];
    [Score setFrame:CGRectMake(150, 5, 90,21)];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}

/*-(void)LoadSavedName
{
    [self.Highest_Score setString:[NSString stringWithFormat:@"%d",obj_Gamestate.LastSavedScore]];
    [self.User_Name setString:[NSString stringWithFormat:obj_Gamestate.LastUserName]];
    
}*/

#pragma mark LeaderBoard Button

-(void)goToHomeFromLeaderBoard:(CCMenuItem *)sender
{
    [LeaderBoardTable removeFromSuperview];
    [act_loadingView HideActivity];
    [view removeFromSuperview];
    [[CCDirector sharedDirector] replaceScene:[Home scene]];
}


@end
