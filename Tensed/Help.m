//
//  Help.m
//  TENSER
//
//  Created by Mac Mini 4 on 30/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Help.h"
#import "Home.h"

@implementation Help
@synthesize _Menu;
@synthesize _backgroundHelp;
@synthesize menuHelp;
@synthesize helpWebview;

+(CCScene *)scene{
    CCScene *scene=[CCScene node];
    Help *help=[Help node];
    
    [scene addChild:help];
    
    return scene;
    
}

-(id)init
{
    if (self=[super init]) 
    {
        CGSize winsize=[[CCDirector sharedDirector]winSize];
        if([[CCDirector sharedDirector] winSize].height == 568)
        {
            _backgroundHelp = [CCSprite spriteWithFile:@"help-15.png"];
        }
        else{

            _backgroundHelp = [CCSprite spriteWithFile:@"help-1.png"];
        }
        
        _backgroundHelp.position=ccp([[CCDirector sharedDirector] winSize].width/2.0, [[CCDirector sharedDirector] winSize].height/2.0);

        [self addChild:_backgroundHelp];
        self.isTouchEnabled=FALSE;
        _Menu = [CCMenuItemImage itemFromNormalImage:@"menu.png" selectedImage:@"menu.png"target:self selector:@selector(goToHomeFromHelp:)];
        _Menu.position = ccp(winsize.width/2-160, winsize.height/2-420);
        menuHelp=[CCMenu menuWithItems:_Menu, nil];
        [self addChild:menuHelp];
        
        //[_Menu setIsEnabled:false];
         //[pause setIsEnabled:false];
        
        
        self.helpWebview = [[UIWebView alloc] initWithFrame:CGRectMake(40, 120, 240, 290)];
        self.helpWebview.backgroundColor = [UIColor clearColor];
        self.helpWebview.opaque = NO;
        self.helpWebview.delegate = self;
        
        [[[CCDirector sharedDirector] openGLView] addSubview:self.helpWebview];
        
        [self.helpWebview loadHTMLString:@"<html><style type=""text/css"">body {font-family:""arial""; font-size:""16""; color:""white"";</style><body><p>Challenge your spatial<br/>reasoning against your ability<br/>to add quickly.</p><p>Create horizontal or vertical<br/>sums that add up to 10,<br/>causing the digits to explode.</br>Avoid dropping a digit on top of a full column.</p><p>For more help or additional<br/>details, <a href = http://www.alphaheuristix.com/tenser/instructions.pdf>tap</a> this link.</p></body></html>" baseURL:nil];
        
    }
    return self;
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType 
{
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) 
    {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    //[_Menu setIsEnabled:true];
    self.isTouchEnabled=TRUE;
    return YES;
}

-(void)goToHomeFromHelp:(CCMenuItem *)sender
{
    [self.helpWebview removeFromSuperview];
    [[CCDirector sharedDirector] replaceScene:[Home scene]];
}

@end
