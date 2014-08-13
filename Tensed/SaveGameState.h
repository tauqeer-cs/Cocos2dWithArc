//
//  SaveGameState.h
//  TENSER
//
//  Created by Subhra Da on 28/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameLayer.h"

@interface SaveGameState : NSObject<NSCoding>{
    
    GameLayer *saveGameLayer;
}

@property (nonatomic , retain)GameLayer *saveGameLayer;
@end
