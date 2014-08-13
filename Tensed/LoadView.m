//
//  LoadView.m
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadView.h"

@implementation LoadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (UIView *) ShowActivity:(NSString*)message
{
    ActivityView =[[UIView	alloc] initWithFrame:CGRectMake(90, 200, 150, 100)];
	ActivityView.layer.cornerRadius = 10;
	ActivityView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	indicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(65, 20, 25, 25)];
	indicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
	
	UILabel *lblString=[[UILabel alloc] initWithFrame:CGRectMake(40, 50, 100, 20)];
	lblString.font =[UIFont boldSystemFontOfSize:15];
	lblString.textAlignment =UITextAlignmentLeft;
	lblString.textColor =[UIColor whiteColor];
	lblString.backgroundColor = [UIColor clearColor];
	lblString.text=message;
    [ActivityView addSubview:lblString];
    [ActivityView addSubview:indicator];
    
    [indicator startAnimating];
	ActivityView.backgroundColor=[UIColor blackColor];
    ActivityView.alpha=0.7;
	[UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    return ActivityView;
}
- (void) HideActivity{
	//[[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
	[indicator stopAnimating];
	[indicator removeFromSuperview];
	[ActivityView removeFromSuperview];
	ActivityView = nil;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
