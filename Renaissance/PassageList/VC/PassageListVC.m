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

@interface PassageListVC ()

@property (nonatomic, strong) Channel *data;

@end

@implementation PassageListVC

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
    
    self.dataArr = [[DBTool sharedInstance] getChannelItemsUnderFeedUrl:self.data.url.absoluteString];
    
    [self.tableView registerClass:[PassageListCell class] forCellReuseIdentifier:@"PassageListCellIdentifier"];
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView.refreshControl addTarget:self action:@selector(refreshControlChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView.refreshControl endRefreshing];
}

#pragma mark action

- (void)refreshControlChanged:(UIRefreshControl *)sender {
    NSLog(@"sender: %@\n%li", sender, sender.isRefreshing);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [sender endRefreshing];
    });
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PassageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassageListCellIdentifier" forIndexPath:indexPath];
    [cell resetSubviewsWithData:[self.dataArr objectAtIndex:indexPath.row]];
    [cell showGrayLine:(indexPath.row != (self.dataArr.count - 1))];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PassageDetailVC *vcOfPassageDetail = [[PassageDetailVC alloc] initWithChannelItemData:[self.dataArr objectAtIndex:indexPath.row]];
    [self pushVC:vcOfPassageDetail];
}

@end
