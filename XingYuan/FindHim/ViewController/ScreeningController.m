//
//  ScreeningController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ScreeningController.h"

@interface ScreeningController ()
@property (nonatomic,assign) ScreeningControllerType controllerType;
@property (nonatomic,copy) NSString *basicInfoCellPreTitle;
@end

@implementation ScreeningController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //默认设置为保存到服务器类型
        self.controllerType = ScreeningControllerTypeUpdateToServer;
    }
    return self;
}

- (instancetype)initWithType:(ScreeningControllerType)type basicInfoCellPreTitle:(NSString *)cellTitle{
    if([self init]){
        self.controllerType = type==nil ? ScreeningControllerTypeUpdateToServer:type;
        self.basicInfoCellPreTitle = cellTitle;
    }
    return self;
}

- (void)setCellTitles:(NSArray *)cellTitles{
    _cellTitles = cellTitles;
    NSMutableArray *cells = [NSMutableArray new];
    for(int i=0;i<self.cellTitles.count;i++){
        FillUserInfoCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FillUserInfoCell" owner:nil options:nil] lastObject];
        cell.leftLabel.text = self.cellTitles[i];
        [cells addObject:cell];
    }
    self.cells = cells;
    
    BasiceInfoCell *basicInfoCell = [[[NSBundle mainBundle] loadNibNamed:@"BasiceInfoCell" owner:nil options:nil] lastObject];
    self.basiceInfoCell = basicInfoCell;
    
    [self refreshBasicInfoCell];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64*FitHeight);
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn = finishBtn;
    [finishBtn setTitleColor:RGBColor(246, 80, 116, 1) forState:UIControlStateNormal];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn sizeToFit];
    [finishBtn addTarget:self action:@selector(dealTapFinished) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:finishBtn]];
    
    extern NSString *FillUserInfoCellRightInfoValueChangedNotice;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBasicInfoCell) name:FillUserInfoCellRightInfoValueChangedNotice object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark --misc

/**
 更新信息到服务器
 
 @param isToNext 是否跳到下一级筛选
 */
- (void)dealUploadInfo:(BOOL)isToNext{
    if(![self isParameterIntegrity]){return;}
    //子类中在此实现网络请求，并根据isToNext来判断是否跳转到下一页
}

//点击完成按钮
- (void)dealTapFinished{
    [self dealUploadInfo:false];
}


- (BOOL)isParameterIntegrity{
    NSString *message = @"信息不完整，请继续完善信息";
    for(int i=0;i<self.cells.count;i++){
        FillUserInfoCell *cell = self.cells[i];
        if(cell.infoValue == nil){
            [Helper showAlertControllerWithMessage:message completion:nil];
            return false;
        }
    }
    return true;
}

//刷新基础信息Cell上的已完成数目
- (void)refreshBasicInfoCell{
    int haveInputCount = 0;
    for(int i=0;i<self.cells.count;i++){
        FillUserInfoCell *cell = self.cells[i];
        if(cell.infoValue != nil){
            haveInputCount += 1;
        }
        UIFont *font = FONT_WITH_S(14);
        NSDictionary *attributs = @{NSForegroundColorAttributeName:RGBColor(122, 128, 131, 1),
                                    NSFontAttributeName:font};
        NSString *basicInfoCellPreTitle = @"";
        if(self.basicInfoCellPreTitle != nil){
            basicInfoCellPreTitle = self.basicInfoCellPreTitle;
        }else if(self.title != nil){
            basicInfoCellPreTitle = self.title;
        }else{
            basicInfoCellPreTitle = @"基本信息";
        }
        NSMutableAttributedString *frontAttrString = [[NSMutableAttributedString alloc] initWithString:basicInfoCellPreTitle attributes:nil];
        NSString *numStr = [NSString stringWithFormat:@"（%d/%lu）",haveInputCount,self.cells.count];
        NSMutableAttributedString *behindAttrString = [[NSMutableAttributedString alloc] initWithString:numStr attributes:attributs];
        [frontAttrString appendAttributedString:behindAttrString];
        self.basiceInfoCell.title = frontAttrString;
    }
}

#pragma mark --UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //子类中只需要实现所有代理方法中的此方法
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cells.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 47;
    }
    return 45*FitHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40*FitHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(self.controllerType == ScreeningControllerTypeUpdateToServer){
        return 120*FitHeight;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FillUserInfoNoticeHeaderView *headerView = [[FillUserInfoNoticeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40*FitHeight)];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(self.controllerType == ScreeningControllerTypeUpdateToServer){
        FillUserInfoNextFooterView *footerView = [[FillUserInfoNextFooterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100*FitHeight)];
        footerView.tapNextBlock = ^(){
            [self dealUploadInfo:true];
        };
        return footerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return self.basiceInfoCell;
    }
    return self.cells[indexPath.row-1];
}


@end
