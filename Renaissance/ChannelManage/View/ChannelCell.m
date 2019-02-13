//
//  ChannelCell.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ChannelCell.h"

@implementation ChannelCell {
    UIImageView *imgv;
    UILabel *txtOfTitle;
    UILabel *txtOfStatus;
    
    UIView *grayLine;
}

- (void)resetSubviewsWithData:(Channel *)data {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    if (imgv == nil) {
        imgv = [[UIImageView alloc] init];
        imgv.contentMode = UIViewContentModeScaleAspectFill;
        imgv.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        imgv.clipsToBounds = YES;
        [self.contentView addSubview:imgv];
        imgv.sd_layout.leftSpaceToView(self.contentView, 20).centerYEqualToView(self.contentView).widthIs(72).heightEqualToWidth();
    }
    [imgv sd_setImageWithURL:[NSURL URLWithString:data.logoUrl]];
    
    if (txtOfTitle == nil) {
        txtOfTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:20] textColor:HexColor(@"404040") parentView:self.contentView];
        txtOfTitle.numberOfLines = 2;
        txtOfTitle.sd_layout.leftSpaceToView(imgv, 10).topEqualToView(imgv).widthIs(ScreenW - 20 - 72 - 10 - 30);
    }
    txtOfTitle.text = data.title;
    txtOfTitle.sd_layout.heightIs([txtOfTitle sizeThatFits:CGSizeMake(ScreenW - 20 - 72 - 10 - 30, MAXFLOAT)].height);
    
    
    if (txtOfStatus == nil) {
        txtOfStatus = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:12] textColor:HexColor(@"2e2e2e2") parentView:self.contentView];
        txtOfStatus.numberOfLines = 1;
        txtOfStatus.sd_layout.leftSpaceToView(imgv, 10).rightSpaceToView(self.contentView, 0).bottomEqualToView(imgv).heightIs(14);
    }
    txtOfStatus.text = @"2 unread | 5 Feb 2019 latest";
    NSMutableAttributedString *attrOfStatus = [[NSMutableAttributedString alloc] initWithString:txtOfStatus.text attributes:@{NSForegroundColorAttributeName:HexColor(@"2e2e2e2")}];
    [attrOfStatus addAttribute:NSForegroundColorAttributeName value:HexColor(@"A62A2A") range:NSMakeRange(0, [@"2 unread |" length])];
    txtOfStatus.attributedText = attrOfStatus;
    
    if (grayLine == nil) {
        grayLine = [[UIView alloc] init];
        grayLine.backgroundColor = HexColor(@"dfdfdf");
        grayLine.hidden = YES;
        [self.contentView addSubview:grayLine];
        grayLine.sd_layout.leftSpaceToView(self.contentView, 20).rightSpaceToView(self.contentView, 0).bottomEqualToView(self.contentView).heightIs(1);
    }
}

- (void)showGrayLine:(BOOL)shouldShow {
    grayLine.hidden = !shouldShow;
}

@end
