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
@property (nonatomic, strong) YYLabel *txtOfContent;
@property (nonatomic, strong) UIView *verticalGrayLine;
@property (nonatomic, strong) UIImageView *imgv;

@end

@implementation PassageDetailCell {
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)resetSubviewsWithImageUrl:(NSString *)imageUrl {
    self.txt.hidden = YES;
    self.verticalGrayLine.hidden = YES;
    
    self.txtOfContent.hidden = YES;
    
    self.imgv.hidden = NO;
    [self.imgv sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)resetSubviewsWithAttributeString:(NSAttributedString *)attributeString {
    self.txt.hidden = NO;
    self.txt.attributedText = attributeString;
    self.txt.hidden = YES;
    
    self.txtOfContent.hidden = NO;
    NSMutableAttributedString *mAttributeString = [[NSMutableAttributedString alloc] initWithAttributedString:attributeString];
//    mAttributeString.yy_color = HexColor(@"2a2a2a");
    self.txtOfContent.attributedText = (NSAttributedString *)mAttributeString;
    
    self.verticalGrayLine.hidden = YES;
    self.imgv.hidden = YES;
}

- (void)resetTextInsets:(UIEdgeInsets)insets {
    self.txtOfContent.sd_resetNewLayout.leftSpaceToView(self.contentView, insets.left).topSpaceToView(self.contentView, insets.top).bottomSpaceToView(self.contentView, insets.bottom).rightSpaceToView(self.contentView, insets.right);
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

- (UIImageView *)imgv {
    if (_imgv == nil) {
        _imgv = [[UIImageView alloc] init];
        _imgv.backgroundColor = HexColor(@"f3f3f3");
        _imgv.clipsToBounds = YES;
        _imgv.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imgv];
        _imgv.sd_layout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 10);
    }
    return _imgv;
}

#pragma mark getter

-(YYLabel*)txtOfContent
{
    if (_txtOfContent == nil) {
        _txtOfContent = [[YYLabel alloc] initWithFrame:CGRectZero];
        _txtOfContent.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _txtOfContent.displaysAsynchronously = YES;
        _txtOfContent.fadeOnAsynchronouslyDisplay = NO;
        _txtOfContent.fadeOnHighlight = NO;
        _txtOfContent.numberOfLines = 0;
//        _txtOfContent.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_txtOfContent];
        _txtOfContent.sd_resetLayout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 10);
    }
    return _txtOfContent;
}

@end
