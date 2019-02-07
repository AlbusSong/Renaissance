//
//  PassageDetailView.m
//  Renaissance
//
//  Created by Albus on 2019/2/7.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageDetailView.h"

@interface PassageDetailView ()

@property (nonatomic, strong) ChannelItem *data;

@end

@implementation PassageDetailView {
    UILabel *txtForSizeFitting;
}

- (instancetype)initWithChannelItemData:(ChannelItem *)data {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.data = data;
        txtForSizeFitting = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:20] textColor:HexColor(@"ffffff") parentView:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.data == nil) {
        return;
    }
    
    NSMutableParagraphStyle *paragraphOfTitle = [[NSMutableParagraphStyle alloc] init];
    [paragraphOfTitle setLineSpacing:14];
    NSDictionary *attributesOfTitle = @{NSParagraphStyleAttributeName:paragraphOfTitle, NSForegroundColorAttributeName:HexColor(@"202020"), NSFontAttributeName:[UIFont systemFontOfSize:24]};
    txtForSizeFitting.text = self.data.title;
    txtForSizeFitting.font = [UIFont systemFontOfSize:24];
    CGFloat heightOfTitle = ceilf([txtForSizeFitting sizeThatFits:CGSizeMake(ScreenW - 20, MAXFLOAT)].height);
    [self.data.title drawInRect:CGRectMake(10, 10, ScreenW - 20, heightOfTitle) withAttributes:attributesOfTitle];
    NSLog(@"the title: %@", self.data.title);
}

@end
