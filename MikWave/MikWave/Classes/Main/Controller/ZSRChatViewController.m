//
//  ZSRChatViewController.m
//  
//
//  Created by hp on 16/1/2.
//
//

#import "ZSRChatViewController.h"
#import "ZSRInputView.h"

@interface ZSRChatViewController ()<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate, UITextViewDelegate>{
    
    NSFetchedResultsController *_resultsContr;
    
}
@property (nonatomic, strong) NSLayoutConstraint *inputViewConstraint;//inputView底部约束
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ZSRChatViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self setupView];
    
    // 键盘监听
    // 监听键盘
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // 加载数据
    [self loadMsgs];
    [self scrollToTableBottom];
    
}

-(void)keyboardWillShow:(NSNotification *)noti{
    NSLog(@"%@",noti);
    // 获取键盘的高度
    CGRect kbEndFrm = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat kbHeight =  kbEndFrm.size.height;
    
    //竖屏{{0, 0}, {768, 264}
    //横屏{{0, 0}, {352, 1024}}
    // 如果是ios7以下的，当屏幕是横屏，键盘的高底是size.with
    if([[UIDevice currentDevice].systemVersion doubleValue] < 8.0
       && UIInterfaceOrientationIsLandscape(self.interfaceOrientation)){
        kbHeight = kbEndFrm.size.width;
    }
    
    self.inputViewConstraint.constant = kbHeight;
    //表格滚动到底部
    [self scrollToTableBottom];
    
    
}

-(void)keyboardWillHide:(NSNotification *)noti{
    // 隐藏键盘的进修 距离底部的约束永远为0
    self.inputViewConstraint.constant = 0;
}

//-(void)kbFrmWillChange:(NSNotification *)noti{
//    NSLog(@"%@",noti.userInfo);
//    
//    // 获取窗口的高度
//    
//    CGFloat windowH = [UIScreen mainScreen].bounds.size.height;
//    
//    
//    
//    // 键盘结束的Frm
//    CGRect kbEndFrm = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    // 获取键盘结束的y值
//    CGFloat kbEndY = kbEndFrm.origin.y;
//    
//    self.inputViewConstraint.constant = windowH - kbEndY;
//}


-(void)setupView{
    // 代码方式实现自动布局 VFL
    // 创建一个Tableview;
    UITableView *tableView = [[UITableView alloc] init];
//    tableView.backgroundColor = [UIColor redColor];
    tableView.delegate = self;
    tableView.dataSource = self;
#warning 代码实现自动布局，要设置下面的属性为NO
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:tableView];
    
    // 创建输入框View
    ZSRInputView *inputView = [ZSRInputView inputView];
    inputView.translatesAutoresizingMaskIntoConstraints = NO;
    // 设置TextView代理
    inputView.textView.delegate = self;
    [self.view addSubview:inputView];
    
    // 自动布局
    
    // 水平方向的约束
    NSDictionary *views = @{@"tableview":tableView,
                            @"inputView":inputView};
    
    // 1.tabview水平方向的约束
    NSArray *tabviewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableview]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:tabviewHConstraints];
    
    // 2.inputView水平方向的约束
    NSArray *inputViewHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[inputView]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:inputViewHConstraints];
    
    
    // 垂直方向的约束
    NSArray *vContraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[tableview]-0-[inputView(50)]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:vContraints];
    self.inputViewConstraint = [vContraints lastObject];
//    NSLog(@"%@",vContraints);
}

#pragma mark 加载XMPPMessageArchiving数据库的数据显示在表格
-(void)loadMsgs{
    
    // 上下文
    NSManagedObjectContext *context = [ZSRXMPPTool sharedZSRXMPPTool].msgStorage.mainThreadManagedObjectContext;
    // 请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    
    
    // 过滤、排序
    // 1.当前登录用户的JID的消息
    // 2.好友的Jid的消息
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",[ZSRUserInfo sharedZSRUserInfo].jid,self.friendJid.bare];
    NSLog(@"%@",pre);
    request.predicate = pre;
    
    // 时间升序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.sortDescriptors = @[timeSort];
    
    // 查询
    _resultsContr = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    NSError *err = nil;

    
    // 代理
    _resultsContr.delegate = self;
    [_resultsContr performFetch:&err];
    
    NSLog(@"%@",_resultsContr.fetchedObjects);
    if (err) {
        NSLog(@"%@",err);
    }
}

#pragma mark -表格的数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultsContr.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ChatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 获取聊天消息对象
    XMPPMessageArchiving_Message_CoreDataObject *msg =  _resultsContr.fetchedObjects[indexPath.row];
    
    //显示消息
    if ([msg.outgoing boolValue]) {//自己发
        cell.textLabel.text = [NSString stringWithFormat:@"Me: %@",msg.body];
    }else{//别人发的
        cell.textLabel.text = [NSString stringWithFormat:@"Other: %@",msg.body];
    }
    return cell;
}


#pragma mark ResultController的代理
-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    // 刷新数据
    [self.tableView reloadData];
    [self scrollToTableBottom];
}

#pragma mark TextView的代理
-(void)textViewDidChange:(UITextView *)textView{
    NSString *text = textView.text;
    // 换行就等于点击了的send
    if ([text rangeOfString:@"\n"].length != 0) {
        NSLog(@"发送数据 %@",text);
        [self sendMsgWithText:text];
        //清空数据
        textView.text = nil;
        
    }else{
        NSLog(@"%@",textView.text);
        
    }
}


#pragma mark 发送聊天消息
-(void)sendMsgWithText:(NSString *)text{
    
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:self.friendJid];
    
    
    // 设置内容
    [msg addBody:text];
    NSLog(@"%@",msg);
    [[ZSRXMPPTool sharedZSRXMPPTool].xmppStream sendElement:msg];
}

#pragma mark 滚动到底部
-(void)scrollToTableBottom{
    NSInteger lastRow = _resultsContr.fetchedObjects.count - 1;
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

@end

