//
//  InternetValidation.m
//  UrbanChat
//
//  Created by Tamal on 09/07/11.
//  Copyright 2011 Indusnet. All rights reserved.
//

#import "InternetValidation.h"


@implementation InternetValidation

+ (BOOL) connectedToNetwork
{
	// Create zero addy
    //Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    //NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    //if (networkStatus == NotReachable)
    //{
        NSLog(@"no network");
        
        //[self alertMessageForNoNetwork];
        
      //  return NO;
    //}
    //else
	return (YES);
}

@end
