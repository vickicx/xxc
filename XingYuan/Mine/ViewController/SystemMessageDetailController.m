//
//  SystemMessageDetailController.m
//  XingYuan
//
//  Created by YunKuai on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SystemMessageDetailController.h"
#import "SystemMessageModel.h"

@interface SystemMessageDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *msgTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) SystemMessageModel *systemMessageModel;
@end

@implementation SystemMessageDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知详情";
    
    self.msgTitleLabel.font = FONT_WITH_S(17)
    self.textView.font = FONT_WITH_S(14);
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestData{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[NSNumber numberWithInteger:self.msgid] forKey:@"msgid"];
    
    [VVNetWorkTool postWithUrl:Url(ReadInformation) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *baseModel = [BaseModel new];
        [baseModel setValuesForKeysWithDictionary:result];
        
        SystemMessageModel *systemMessageModel = [SystemMessageModel new];
        NSDictionary *dic = [result valueForKey:@"data"];
        [systemMessageModel setValuesForKeysWithDictionary:dic];
        self.systemMessageModel = systemMessageModel;
        
        [self refreshUIWith:systemMessageModel];
        [JGProgressHUD showErrorWithModel:baseModel In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)refreshUIWith:(SystemMessageModel *)model{
    self.msgTitleLabel.text = model.title;
    self.textView.text = model.content;
}
@end
