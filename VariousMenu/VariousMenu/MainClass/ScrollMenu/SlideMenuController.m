//
//  SlideMenuVController.m
//  ProjectControls
//
//  Created by Vols on 2016/11/16.
//  Copyright © 2016年 vols. All rights reserved.
//

#import "SlideMenuController.h"

#import "SlideMenuExample1Controller.h"
#import "SlideMenuExample2Controller.h"
#import "SlideMenuShow1Controller.h"
#import "ReuseScrollViewController.h"

@interface SlideMenuController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView   * tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *>  * dataSource;

@end

@implementation SlideMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addShowMenuButton];
    
}

- (void)initData{

}


- (void)configureViews {
    self.titleLabel.text = @"滑动菜单";
    self.view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:self.tableView];
    
    _dataSource = [@[@[@"ToolBar"], @[@"Style 1：排满", @"Style 2：等宽"], @[@"复用scrollView"]] mutableCopy];
}


- (UITableView *)tableView{
    
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_identifier"];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * identifier = @"cell_identifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.textColor = [UIColor colorWithWhite:0.293 alpha:1.000];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *noteLabel = [[UILabel alloc] init];
    noteLabel.textAlignment = NSTextAlignmentLeft;
    noteLabel.font = [UIFont systemFontOfSize:14.0];
    noteLabel.textColor = [UIColor grayColor];
    
    if (section == 1) {
        noteLabel.text = @"  ScrollPage";
    }
    return noteLabel;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[[SlideMenuShow1Controller alloc] init] animated:YES];
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[SlideMenuExample1Controller alloc] init] animated:YES];
        }
        else if (indexPath.row == 1) {
            [self.navigationController pushViewController:[[SlideMenuExample2Controller alloc] init] animated:YES];
        }
    }
    else if (indexPath.section == 2) {
        [self.navigationController pushViewController:[[ReuseScrollViewController alloc] init] animated:YES];
    }

    [self performSelector:@selector(deselect:) withObject:tableView afterDelay:0.2f];
}

- (void)deselect:(UITableView *)tableView {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
