//
//  PassageListCell.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PassageListCell : ASTableViewCell

- (void)resetSubviews;
- (void)showGrayLine:(BOOL)shouldShow;

@end

NS_ASSUME_NONNULL_END
