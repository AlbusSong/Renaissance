//
//  PassageDetailCell.h
//  Renaissance
//
//  Created by Albus on 2019/2/7.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PassageDetailCell : ASTableViewCell

- (void)resetSubviewsWithAttributeString:(NSAttributedString *)attributeString;

- (void)resetInsets:(UIEdgeInsets)insets;

@end

NS_ASSUME_NONNULL_END
