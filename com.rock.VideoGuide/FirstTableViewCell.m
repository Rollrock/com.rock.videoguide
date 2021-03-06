//
//  FirstTableViewCell.m
//  com.rock.VideoGuide
//
//  Created by zhuang chaoxiao on 16/11/14.
//  Copyright © 2016年 zhuang chaoxiao. All rights reserved.
//

#import "FirstTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface FirstTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *uploadTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *hotLab;
@property (weak, nonatomic) IBOutlet UILabel *downLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@end

@implementation FirstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refresCell:(VideoModel*)model
{
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    self.nameLab.text = model.name;
    self.uploadTimeLab.text = model.uploadTime;
    self.hotLab.text = model.hot;
    self.downLab.text = model.down;
    self.timeLab.text = model.time;
}



@end
