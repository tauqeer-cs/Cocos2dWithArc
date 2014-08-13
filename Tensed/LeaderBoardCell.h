//
//  LeaderBoardCell.h
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardCell : UITableViewCell
{
     UILabel *lblName;
	 UILabel *lblScore;
}

@property(nonatomic,retain)UILabel *lblName;
@property(nonatomic,retain)UILabel *lblScore;

- (void)setName:(NSString *)value;
- (void)setScore:(NSString *)value;

@end
