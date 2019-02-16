//
//  ASTableViewVC.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASTableViewVC : ASViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ASTableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrOfData;
@property (nonatomic) NSUInteger currentPage;

@end

NS_ASSUME_NONNULL_END
