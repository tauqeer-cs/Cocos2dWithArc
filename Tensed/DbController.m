//
//  DbController.m
//  Pocketsure
//
//  Created by Biswabaran on 15/07/11.
// Copyright (c) 2011 Ethertricity Limited. All Rights Reserved.
//

#import "DbController.h"




@implementation DbController

DbHandler *RamsKitchenDB;

+(void) setDatabase:(DbHandler *)database{
    RamsKitchenDB = database;
}

+(DbHandler*)database{
	//return [PocketsureDB retain];
    return RamsKitchenDB;
}


+(void)OpenDatabase{
	@try {
        if ([RamsKitchenDB open]) {
            [RamsKitchenDB close];
        }
        RamsKitchenDB = [DbHandler initWithDBName:@"TENSER.sqlite"];
        if ([RamsKitchenDB open] == NO) {
            [RamsKitchenDB close];
        }
        
		
#if DEBUG
		[RamsKitchenDB setLogsErrors:YES];
#endif
	}
	@catch (NSException * e) {
		;//[ErrorLog LogError:e];
	}
}




@end
