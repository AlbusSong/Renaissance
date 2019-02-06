//
//  ASViewController.h
//  Renaissance
//
//  Created by Albus on 2019/2/6.
//  Copyright © 2019 Albus. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASViewController : UIViewController

- (void)back;
- (void)backAnimated:(BOOL)animated;

- (void)loadData;
- (void)pushVC:(UIViewController *)nextVC animated:(BOOL)animated;
- (void)pushVC:(UIViewController *)nextVC;

@end

NS_ASSUME_NONNULL_END
