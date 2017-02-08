//
//  VScrollMenuController.h
//  VariousMenu
//
//  Created by Vols on 2017/2/8.
//  Copyright © 2017年 vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VScrollMenuController : UIViewController

@property (nonatomic, strong) NSArray *titles;              /** 导航标题 */
@property (nonatomic, strong) NSArray *viewControllers;     /** 控制器 */

@end
