//
//  PassageListVC.m
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import "PassageListVC.h"
#import "PassageDetailVC.h"
#import "PassageListCell.h"
#import "LoadMoreFooterView.h"

@interface PassageListTitleView : UIView

@property (nonatomic, strong) UIImageView *imgvOfLogo;
@property (nonatomic, strong) UILabel *txtOfTitle;

- (void)setTitle:(NSString *)title;
- (void)setImageWithURL:(NSString *)imageURL;

@end

@implementation PassageListTitleView

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    self.imgvOfLogo = [[UIImageView alloc] init];
    self.imgvOfLogo.contentMode = UIViewContentModeScaleAspectFill;
    self.imgvOfLogo.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    self.imgvOfLogo.clipsToBounds = YES;
    self.imgvOfLogo.layer.cornerRadius = 3;
    [self addSubview:self.imgvOfLogo];
    self.imgvOfLogo.sd_layout.topEqualToView(self).centerXEqualToView(self).widthIs(20).heightEqualToWidth();
    
    self.txtOfTitle = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:10] textColor:HexColor(@"000000") parentView:self];
    self.txtOfTitle.textAlignment = NSTextAlignmentCenter;
    self.txtOfTitle.sd_layout.bottomEqualToView(self).leftSpaceToView(self, 0).rightEqualToView(self).heightIs(20);
}

- (void)setTitle:(NSString *)title {
    self.txtOfTitle.text = title;
}

- (void)setImageWithURL:(NSString *)imageURL {
    [self.imgvOfLogo sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

@end

@interface PassageListVC () <ChannelServiceDelegate, LoadMoreFooterViewDelegate>

@property (nonatomic, strong) Channel *data;

@end

@implementation PassageListVC {
    LoadMoreFooterView *viewToLoadMore;
}

- (instancetype)initWithChannelData:(Channel *)data {
    self = [super init];
    if (self) {
        self.title = nil;
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addChannel)];
        
        self.data = data;
        
        PassageListTitleView *titleView = [[PassageListTitleView alloc] init];
        titleView.frame = CGRectMake(0, 0, ScreenW - 80, 45);
        [titleView setTitle:self.data.title];
        [titleView setImageWithURL:self.data.favoiconUrl];
        self.navigationItem.titleView = titleView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self refreshData];
    
    [self.tableView registerClass:[PassageListCell class] forCellReuseIdentifier:@"PassageListCellIdentifier"];
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView.refreshControl addTarget:self action:@selector(refreshControlChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView.refreshControl endRefreshing];
}

- (void)refreshData {
    NSMutableArray *arr = [[DBTool sharedInstance] getChannelItemsUnderFeedUrl:self.data.url.absoluteString page:self.currentPage];
    [self.arrOfData removeAllObjects];
    [self.arrOfData addObjectsFromArray:arr];
}

#pragma mark ChannelServiceDelegate

- (void)parsingChannelWithState:(ChannelParsingState)state {
    if (state == ChannelParsingStatePartialSuccess || state == ChannelParsingStateFailed) {
        [self.tableView.refreshControl endRefreshing];
        
        if (state == ChannelParsingStatePartialSuccess) {
            [self refreshData];
            [self.tableView reloadData];
        }
    }
}

#pragma mark action

- (void)refreshControlChanged:(UIRefreshControl *)sender {
    ChannelService *svc = [ChannelService sharedInstance];
    svc.delegate = self;
    [svc startToParseRSSChannel:self.data.url.absoluteString];
}

#pragma mark LoadMoreFooterViewDelegate

- (void)tryToLoadMore {
    self.currentPage++;
    NSMutableArray *arr = [[DBTool sharedInstance] getChannelItemsUnderFeedUrl:self.data.url.absoluteString page:self.currentPage];
    NSMutableArray *arrToAppend = [[NSMutableArray alloc] init];
    for (ChannelItem *item in arr) {
        if (![self checkIfContainItem:item forChannelItemArray:self.arrOfData]) {
            [arrToAppend addObject:item];
        }
    }
    [self.arrOfData addObjectsFromArray:arrToAppend];
    [self.tableView reloadData];
    if (arr.count > 0) {
        [viewToLoadMore setNeedToLoadMore];
    } else {
        [viewToLoadMore setNoMore];
    }
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrOfData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChannelItem *data = [self.arrOfData objectAtIndex:indexPath.row];
    if (!data.isCoverUrlValid) {
        return 127;
    } else {
        return 160;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (viewToLoadMore == nil) {
        viewToLoadMore = [[LoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
        viewToLoadMore.delegate = self;
        [viewToLoadMore setNeedToLoadMore];
    }
    
    return viewToLoadMore;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PassageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassageListCellIdentifier" forIndexPath:indexPath];
    [cell resetSubviewsWithData:[self.arrOfData objectAtIndex:indexPath.row]];
    [cell showGrayLine:(indexPath.row != (self.arrOfData.count - 1))];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PassageDetailVC *vcOfPassageDetail = [[PassageDetailVC alloc] initWithChannelItemData:[self.arrOfData objectAtIndex:indexPath.row]];
    WS(weakSelf)
    vcOfPassageDetail.setReadHandler = ^(NSString * _Nonnull identifierMd5Value) {
        ChannelItem *theItem;
        for (ChannelItem *item in weakSelf.arrOfData) {
            if ([item.identifierMd5Value isEqualToString:identifierMd5Value]) {
                theItem = item;
                break;
            }
        }
        
        if (theItem) {
            theItem.isRead = YES;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[weakSelf.arrOfData indexOfObject:theItem] inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            
            if (weakSelf.setReadHandler) {
                weakSelf.setReadHandler(theItem.urlMd5Value);
            }
        }
    };
    [self pushVC:vcOfPassageDetail];
}

#pragma mark small func

- (BOOL)checkIfContainItem:(ChannelItem *)item forChannelItemArray:(NSArray <ChannelItem *> *)array {
    BOOL result = NO;
    
    for (ChannelItem *channelItem in array) {
        if ([channelItem.identifierMd5Value isEqualToString:item.identifierMd5Value]) {
            result = YES;
            break;
        }
    }
    
    return result;
}

@end
