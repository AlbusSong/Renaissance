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
    self.imgvOfLogo.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    self.imgvOfLogo.clipsToBounds = YES;
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

@end

@implementation PassageListVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"The American Conservative";
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addChannel)];
        
        PassageListTitleView *titleView = [[PassageListTitleView alloc] init];
        titleView.frame = CGRectMake(0, 0, ScreenW - 80, 45);
        [titleView setTitle:@"The American Conservative"];
        [titleView setImageWithURL:@"https://www.theamericanconservative.com/wp-content/themes/Starkers/images/touch-icon-192.png"];
        self.navigationItem.titleView = titleView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tableView registerClass:[PassageListCell class] forCellReuseIdentifier:@"PassageListCellIdentifier"];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PassageListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PassageListCellIdentifier" forIndexPath:indexPath];
    [cell resetSubviews];
    [cell showGrayLine:(indexPath.row != 9)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PassageDetailVC *vcOfPassageDetail = [[PassageDetailVC alloc] init];
    [self pushVC:vcOfPassageDetail];
}

@end
