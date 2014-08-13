//
//  LoadView.h
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LoadView : UIView
{
    UIView *ActivityView;
    UIActivityIndicatorView *indicator;
}

- (void) HideActivity;
- (UIView *) ShowActivity:(NSString*)message;

@end
