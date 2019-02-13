//
//  PassageDetailCell.h
//  Renaissance
//
//  Created by Albus on 2019/2/7.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "ASTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PassageDetailCellDelegate <NSObject>

- (void)clickedLink:(NSString *)linkUrl;

@end

@interface PassageDetailCell : ASTableViewCell

@property (nonatomic, weak) id <PassageDetailCellDelegate> delegate;

- (void)resetSubviewsWithAttributeString:(NSAttributedString *)attributeString withLinkDataArr:(nullable NSArray *)linkDataArr;

- (void)resetSubviewsWithAttributeString:(NSAttributedString *)attributeString;

- (void)resetSubviewsWithImageUrl:(NSString *)imageUrl;

- (void)resetTextInsets:(UIEdgeInsets)insets;

- (void)showVerticalGrayLine;

@end

NS_ASSUME_NONNULL_END
