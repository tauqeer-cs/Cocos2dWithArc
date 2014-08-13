//
//  SaveGameState.m
//  TENSER
//
//  Created by Subhra Da on 28/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SaveGameState.h"

@implementation SaveGameState

@synthesize saveGameLayer;

-(id)initWithCoder:(NSCoder *)decoder
{
    if( (self=[super init]))
    {
        //self.objGameLayer = [decoder decodeObjectForKey:@"Value"];
        //return self.objGameLayer;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder{
    //[coder encodeObject:self.objGameLayer forKey:@"Value"];
}

@end
