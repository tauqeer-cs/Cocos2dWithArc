//
//  DbController.h
//  Pocketsure
//
//  Created by Biswabaran on 15/07/11.
// Copyright (c) 2011 Ethertricity Limited. All Rights Reserved.
//

#import <Foundation/Foundation.h>
#import "DbHandler.h"

@interface DbController : NSObject {
}
+(void)OpenDatabase;
+(DbHandler*)database;
+(void) setDatabase:(DbHandler *)database;
@end
