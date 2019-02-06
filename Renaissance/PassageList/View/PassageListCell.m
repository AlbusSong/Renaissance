//
//  PassageListCell.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageListCell.h"

@implementation PassageListCell {
    UIImageView *imgv;
    UILabel *txtOfTitle;
    UILabel *txtOfStatus;
    
    UIView *grayLine;
}

- (void)resetSubviewsWithData:(ChannelItem *)data {
    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat widthOfTitle = (ScreenW - 10*3)*216/(216 + 137);
    if (txtOfTitle == nil) {
        txtOfTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:20] textColor:HexColor(@"404040") parentView:self.contentView];
//        txtOfTitle.backgroundColor = [UIColor yellowColor];
        txtOfTitle.numberOfLines = 3;
        txtOfTitle.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 10).widthIs(widthOfTitle);
    }
    txtOfTitle.text = data.title;
    NSMutableParagraphStyle* paragraphOfTitle = [[NSMutableParagraphStyle alloc] init];
    [paragraphOfTitle setLineSpacing:10];
    NSAttributedString *attrOfTitle = [[NSAttributedString alloc] initWithString:txtOfTitle.text attributes:@{NSParagraphStyleAttributeName:paragraphOfTitle}];
    txtOfTitle.attributedText = attrOfTitle;
    txtOfTitle.sd_layout.heightIs([txtOfTitle sizeThatFits:CGSizeMake(widthOfTitle, MAXFLOAT)].height);
    
    if (imgv == nil) {
        imgv = [[UIImageView alloc] init];
        imgv.contentMode = UIViewContentModeScaleAspectFill;
        imgv.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        imgv.clipsToBounds = YES;
        [self.contentView addSubview:imgv];
        imgv.sd_layout.leftSpaceToView(txtOfTitle, 10).rightSpaceToView(self.contentView, 10).topEqualToView(txtOfTitle).heightIs(92);
    }
    [imgv sd_setImageWithURL:[NSURL URLWithString:data.coverUrl]];
    
    
    if (txtOfStatus == nil) {
        txtOfStatus = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:13] textColor:HexColor(@"202020") parentView:self.contentView];
//        txtOfStatus.backgroundColor = [UIColor purpleColor];
        txtOfStatus.numberOfLines = 2;
        txtOfStatus.sd_layout.leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 10).bottomSpaceToView(self.contentView, 0).heightIs(46);
    }
    txtOfStatus.text = [NSString stringWithFormat:@"5 Feb | %@", data.summary];
    NSMutableParagraphStyle* paragraphOfStatus = [[NSMutableParagraphStyle alloc] init];
    [paragraphOfStatus setLineSpacing:2];
    NSMutableAttributedString *attrOfStatus = [[NSMutableAttributedString alloc] initWithString:txtOfStatus.text attributes:@{NSForegroundColorAttributeName:HexColor(@"202020"), NSParagraphStyleAttributeName:paragraphOfStatus}];
    [attrOfStatus addAttribute:NSForegroundColorAttributeName value:HexColor(@"a0a0a0") range:NSMakeRange(0, [@"5 Feb |" length])];
    txtOfStatus.attributedText = attrOfStatus;
    
    if (grayLine == nil) {
        grayLine = [[UIView alloc] init];
        grayLine.backgroundColor = HexColor(@"dfdfdf");
        [self.contentView addSubview:grayLine];
        grayLine.sd_layout.leftSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 0).bottomEqualToView(self.contentView).heightIs(1);
    }
}

- (void)showGrayLine:(BOOL)shouldShow {
    grayLine.hidden = !shouldShow;
}

@end
