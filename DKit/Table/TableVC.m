//
//  TableVC.m
//  DKit
//
//  Created by Sundear on 2017/7/19.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "TableVC.h"

@interface TableVC (){
    NSMutableArray *List;
}
@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    List = [NSMutableArray new];


    NSArray *Desc = @[@"白渡桥至金陵东路的一段黄浦滩，因位于上海县城厢之外的浦滩，被习被习cupidatat称为“外滩”。它是上海都市的最初轮廓线，曾被称作黄浦路、扬子路、黄浦滩路，1945年改名为中山东一路。",
                      @"这里原是一片荒芜的浅滩，沿滩有一条狭窄的泥路，供船夫拉纤时行走。滩的西边为农田，阡陌沟渠之间散布着星星点点的茅舍。",
                      @"外滩历来是上海的旅游热点，除能观赏中外罕见的“万国建筑博览”外，还可领略外白渡桥与吴淞路闸桥的丰姿，黄浦公园的俊巧，防洪墙的设计匠心，以及大楼与江水交相辉映的胜景。浦江夜游更有一番情趣。加之这里交通发达，购物方便，历史掌故丰富，旅游设施完备，使人留连忘返。"];
    NSArray *ImageUrls = @[@"http://www.51yala.com/UPLOAD/NewsIMG/20061031942592.jpg",
                           @"http://www.51yala.com/UPLOAD/NewsIMG/20061031942591.jpg",
                           @"http://www.51yala.com/UPLOAD/NewsIMG/20061031942593.jpg"];

    NSArray *olthers = @[@747, @"fasj", @"浦江"];


    for (int k=0; k<10; k++) {

        SimpleModel *model = [SimpleModel new];
        model.Title = olthers[k%3];
        model.Address = olthers[k%3];
        model.SubTitle = olthers[k%3];
        model.Describe = Desc[k%3];
        model.ImageUrl = ImageUrls[k%3];

        [List addObject:model];
    }
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return List.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demo1" forIndexPath:indexPath];

    SimpleModel *model = List[indexPath.row];
    [cell MatchToModel:model];

    return cell;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

}



@end
