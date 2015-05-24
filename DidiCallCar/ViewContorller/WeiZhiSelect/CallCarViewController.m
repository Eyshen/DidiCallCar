//
//  CallCarViewController.m
//  Didiyueche
//
//  Created by qianfeng on 15/5/21.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CallCarViewController.h"

@interface CallCarViewController ()<AMapSearchDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AMapSearchAPI *_search;
    NSMutableArray *_resultArr;
    AMapPlaceSearchRequest *_poiRequest;

}
@property(nonatomic,strong)UITableView *searchResultTableView;

@end

@implementation CallCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _resultArr=[[NSMutableArray alloc]init];
    
    
//    UIButton *returnbtn=[UIButton buttonWithType:UIButtonTypeSystem];
//    returnbtn.frame=CGRectMake(0, 0, 39, 39);
//    [returnbtn addTarget:self action:@selector(returnbar) forControlEvents:UIControlEventTouchUpInside];
//    
//    [returnbtn setImage:[UIImage imageNamed:@"list_fanhui"] forState:UIControlStateNormal];
//    UIBarButtonItem *returnBar=[[UIBarButtonItem alloc]initWithCustomView:returnbtn];
//    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
//    self.navigationItem.leftBarButtonItem=returnBar;
    
    
    
    self.searchbar.delegate=self;
    
    self.searchResultTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, _view_width , _view_height-110)];
    self.searchResultTableView.delegate=self;
    self.searchResultTableView.dataSource=self;
    [self.view addSubview:self.searchResultTableView];
    self.searchResultTableView.hidden=YES;
    
    
    if (self.searchname) {
        self.searchbar.text=self.searchname;
        
    }
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] initWithSearchKey:mapkey Delegate:self];
    
    //构造AMapPlaceSearchRequest对象，配置关键字搜索参数
    _poiRequest = [[AMapPlaceSearchRequest alloc] init];
    _poiRequest.searchType = AMapSearchType_PlaceKeyword;
 
    _poiRequest.city = @[@"Dalian"];
    _poiRequest.requireExtension = YES;
       _poiRequest.keywords = self.searchbar.text;
    
    //发起POI搜索
    [_search AMapPlaceSearch: _poiRequest];
    
    [self setLeftItemsWithImageName:@"list_fanhui" andTarget:nil andSelector:@selector(backBtnClick)];
    self.navigationController.navigationBar.hidden=NO;
}
-(void)backBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    if ([searchText isEqualToString:@""]) {
//         NSLog(@"hahah===%ld",searchText.length);
//        return;
//    }
//    NSLog(@"searchBar textDidChange===%ld",searchText.length);
    [self showSearchResultTableView:searchText];
    

}
-(void)viewDidAppear:(BOOL)animated
{
    if (![_searchbar.text isEqualToString:@""]) {
        NSLog(@"c存在 搜索==%@",_searchbar.text);
        [_searchbar becomeFirstResponder];
        [self showSearchResultTableView:_searchbar.text];
    }

}
-(void)showSearchResultTableView:(NSString *)searchString
{
   [_resultArr removeAllObjects];
    if (self.searchResultTableView.hidden==YES) {
        self.searchResultTableView.hidden=NO;
    }
    
//    if (![searchString isEqualToString:@""]) {
        _poiRequest.keywords = searchString;

        //发起POI搜索
        [_search AMapPlaceSearch: _poiRequest];
//    }


}

//实现POI搜索对应的回调函数
- (void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    if(response.pois.count == 0)
    {
        [self.searchResultTableView reloadData];
        return;
    }
    
    //通过AMapPlaceSearchResponse对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %d",response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
    NSString *strPoi = @"";
    if (response.pois.count>0) {
        for (AMapPOI *p in response.pois) {
            //        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
            
            [_resultArr addObject:p];
        }
    }

    
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    [self.searchResultTableView reloadData];
//    NSLog(@"Place: %@", result);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_resultArr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"searchcellID"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchcellID"];
        
    }
    if (_resultArr.count) {
        AMapPOI *p=[_resultArr objectAtIndex:indexPath.row];
     
        cell.textLabel.text=p.name;
    }


    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    AMapPOI *p=[_resultArr objectAtIndex:indexPath.row];
    
//    NSLog(@"选中的名字%@",p.name);


    if (self.fromOrTo==1) {
        [self.delegate exchangeFromLocation:[_resultArr objectAtIndex:indexPath.row]];
        
    }

    else if(self.fromOrTo==0)
    {
        [self.delegate exchangeToLocation:[_resultArr objectAtIndex:indexPath.row]];
        
    
    }
    else if(self.fromOrTo==2)
    {
    
        [self.delegate exchangeNowMapLocation:[_resultArr objectAtIndex:indexPath.row]];
    
    }
    [self.navigationController popViewControllerAnimated:YES];
    

}
-(void)returnbar
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden=NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
