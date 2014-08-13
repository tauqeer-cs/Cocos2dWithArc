//
//  LeaderBoardCell.m
//  TENSER
//
//  Created by Mac Mini 4 on 12/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LeaderBoardCell.h"

@implementation LeaderBoardCell
@synthesize lblName;
@synthesize lblScore;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        lblName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150,21)];
        lblScore = [[UILabel alloc] initWithFrame:CGRectMake(150, 0, 90,21)];
        
        // Initialization code
    }
    return self;
}

-(void)setName:(NSString *)value
{
	lblName.text = value;
}

-(void)setScore:(NSString *)value
{
	lblScore.text = value;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
