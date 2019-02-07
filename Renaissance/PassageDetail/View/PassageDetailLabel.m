//
//  PassageDetailLabel.m
//  Renaissance
//
//  Created by Albus on 2019/2/7.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageDetailLabel.h"
#import "PassageDetailTextStorage.h"

@interface PassageDetailLabel ()

@property (nonatomic, strong) NSTextStorage *storage;
@property (nonatomic, strong) NSLayoutManager *layoutMgr;
@property (nonatomic, strong) ChannelItem *data;

@end

@implementation PassageDetailLabel

//- (instancetype)initWithChannelItemData:(ChannelItem *)data

- (instancetype)initWithFrame:(CGRect)frame channelItemData:(ChannelItem *)data {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
        self.data = data;
//        [self initContents];
    }
    return self;
}

- (void)initContents {
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:self.bounds.size];
    
    NSLayoutManager *layoutMgr = [[NSLayoutManager alloc] init];
    [layoutMgr addTextContainer:container];
    self.layoutMgr = layoutMgr;
    
    NSString *theContent = @"Few other foreign policy decisions of this administration have sparked more criticism than Donald Trump’s announcement that he will remove U.S. troops from Syria.";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:theContent];
    NSTextStorage *storage = [[NSTextStorage alloc] initWithAttributedString:attri];
    [storage addLayoutManager:layoutMgr];
    [storage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, 10)];
    self.storage = storage;
    
}

- (void)drawTextInRect:(CGRect)rect {
//    [self.layoutMgr drawGlyphsForGlyphRange:NSMakeRange(0, self.storage.length - 10) atPoint:CGPointMake(0, 0)];
//    [self.layoutMgr drawBackgroundForGlyphRange:NSMakeRange(0, 7) atPoint:CGPointMake(0, 0)];
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(ScreenW - 20, 0)];
    
    NSLayoutManager *layoutMgrOfTitle = [[NSLayoutManager alloc] init];
    [layoutMgrOfTitle addTextContainer:container];
    NSMutableParagraphStyle *paragraphOfTitle = [[NSMutableParagraphStyle alloc] init];
    [paragraphOfTitle setLineSpacing:10];
    NSTextStorage *storageOfTitle = [[NSTextStorage alloc] initWithString:self.data.title attributes:@{NSParagraphStyleAttributeName:paragraphOfTitle, NSForegroundColorAttributeName:HexColor(@"202020"), NSFontAttributeName:[UIFont systemFontOfSize:24]}];
    [storageOfTitle addLayoutManager:layoutMgrOfTitle];
    [layoutMgrOfTitle drawGlyphsForGlyphRange:NSMakeRange(0, storageOfTitle.length) atPoint:CGPointMake(0, 0)];
    NSLog(@"the title: %@", self.data.title);
    NSLog(@"Hhahaha: %@", NSStringFromCGSize(container.size));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
