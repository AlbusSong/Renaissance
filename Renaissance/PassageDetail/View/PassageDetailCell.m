//
//  PassageDetailCell.m
//  Renaissance
//
//  Created by Albus on 2019/2/7.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageDetailCell.h"

@interface PassageDetailCell ()

@property (nonatomic, strong) UILabel *txt;
@property (nonatomic, strong) UIView *verticalGrayLine;

@end

@implementation PassageDetailCell {
    
}

- (void)resetSubviewsWithAttributeString:(NSAttributedString *)attributeString {
    self.txt.attributedText = attributeString;
    self.verticalGrayLine.hidden = YES;
}

- (void)resetInsets:(UIEdgeInsets)insets {
    self.txt.sd_resetNewLayout.leftSpaceToView(self.contentView, insets.left).topSpaceToView(self.contentView, insets.top).bottomSpaceToView(self.contentView, insets.bottom).rightSpaceToView(self.contentView, insets.right);
}

- (void)showVerticalGrayLine {
    self.verticalGrayLine.hidden = NO;
}

#pragma mark getter

- (UILabel *)txt {
    if (_txt == nil) {
        _txt = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:16] textColor:HexColor(@"202020") parentView:self.contentView];
        _txt.sd_resetLayout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 10);
    }
    return _txt;
}

- (UIView *)verticalGrayLine {
    if (_verticalGrayLine == nil) {
        _verticalGrayLine = [[UIView alloc] init];
        _verticalGrayLine.backgroundColor = HexColor(@"979797");
        [self.contentView addSubview:_verticalGrayLine];
        _verticalGrayLine.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).widthIs(1);
    }
    return _verticalGrayLine;
}

@end
