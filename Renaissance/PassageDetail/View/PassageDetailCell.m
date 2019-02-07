//
//  PassageDetailCell.m
//  Renaissance
//
//  Created by Albus on 2019/2/7.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageDetailCell.h"

@implementation PassageDetailCell {
    UILabel *txt;
}

- (void)resetSubviewsWithAttributeString:(NSAttributedString *)attributeString {
    if (txt == nil) {
        txt = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:16] textColor:HexColor(@"202020") parentView:self.contentView];
        txt.sd_resetLayout.leftSpaceToView(self.contentView, 10).topSpaceToView(self.contentView, 0).bottomSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 10);
    }
    txt.attributedText = attributeString;
}

- (void)resetInsets:(UIEdgeInsets)insets {
    txt.sd_resetLayout.leftSpaceToView(self.contentView, insets.left).topSpaceToView(self.contentView, insets.top).bottomSpaceToView(self.contentView, insets.bottom).rightSpaceToView(self.contentView, insets.right);
}

@end
