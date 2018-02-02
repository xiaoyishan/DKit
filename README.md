##  Match Class 

* 统一model中常用的数据类型, 以model定义为准 同时过滤nil null（Kill nil/null on common data type,  Makesure this class at build and run as a same class except basic class）

* 提供一个置空model的方法 但不指向nil 比较适合处理单例


##  Match View to Model（自动把model中的值给view）

* 完全匹配 和 模糊匹配
```objective-c
/* 
*  自动匹配model和view中属性名字 并给相同的元素直接赋值 赋值时使用的Dtext过滤异常数据
*  仅支持Label，button，textfield，textview ,imageview
*/
-(void)MatchToModel:(id)model;

/*  模糊匹配 */
-(void)MatchToModel:(id)model Level:(MatchLevel)level;
```

* 代码示例
```objective-c
    UserModel *model = [[UserModel alloc]init];
    model.Name = @"MR.xie";
    model.Age = 25;
    model.Phone = 15355555555;
    model.Home = @"WdEa74KDd92kdoriG82kkkH..ds copy";

    CustomView = [[UserView alloc]initWithFrame:CGRectMake(0, 120, 320, 160)];
    [self.view addSubview:CustomView];

    //[CustomView MatchToModel:model];//完全匹配


    [CustomView MatchToModel:model Level:0];//不区分大小写
    //[CustomView MatchToModel:model Level:MatchCapNoPrefixAndSuffix];//区分大小写 不区分前后缀

```

```objective-c
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demo1" forIndexPath:indexPath];

    SimpleModel *model = List[indexPath.row];
    [cell MatchToModel:model];

    return cell;
}
```

* 模糊匹配选项
```objective-c
//模糊匹配等级 前后缀list由本class提供自定义数据 可自行增删
typedef NS_ENUM(NSUInteger, MatchLevel) {
    MatchDefault = 0,      //不区分大小写
    MatchNoPrefix,         //不区分大小写及前缀
    MatchNoSuffix,         //不区分大小写及后缀
    MatchNoPrefixAndSuffix,//不区分大小写及前后缀

    MatchCapNoPrefix = 11,      //区分大小写 不区分前缀
    MatchCapNoSuffix,           //区分大小写 不区分后缀
    MatchCapNoPrefixAndSuffix,  //区分大小写 不区分前后缀
};
```




* 自定义前缀 
```objective-c
//自定义前缀 各种形容词千奇百怪 如果你的参数名比较复杂奇葩建议用yymodel映射你的model
-(NSArray*)PrefixArr{
    return @[@"Pre",@"Prepare",@"Plan",@"Fitst",@"Second",@"End",@"Latest",@"Old",@"New"];
}
```


* 自定义后缀 根据自身习惯增删 建议只保留4个统一的
```objective-c
//自定义后缀
-(NSArray*)SuffixArr{
    return @[@"L",@"Label",@"label",
             @"B",@"Btn",@"Button",@"btn",@"button",
             @"F",@"Field",@"field",@"TextField",@"textfield",@"textField",@"Textfield",@"TF",
             @"T",@"Text",@"TextView",@"Textview",@"textview",@"TV",
             @"IMG",@"Image",@"image",@"I",@"IV",@"Img",@"ImageView",@"Imageview",@"imageview",@"imageView"];
}
```




