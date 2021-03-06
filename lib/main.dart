// 导入相关控件
import 'package:flutter/material.dart';
import './movie/list.dart';

// 入口函数
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 每个项目外层必须有MaterialApp
    return MaterialApp(
      title: 'app名称',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      // 通过home指定首页
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 每个控件都是一个类
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('电影列表'),
            centerTitle: true,
            // 右侧行为按钮
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {})
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                    accountEmail: Text('majun20@xdf.cn'),
                    accountName: Text('majun'),
                    currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://images.gitee.com/uploads/91/465191_vsdeveloper.png?1530762316')),
                    // 美化当前控件
                    decoration: BoxDecoration(
                      // 背景图片
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'http://www.liulongbin.top:3005/images/bg1.jpg')),
                    )),
                ListTile(
                  title: Text('用户反馈'),
                  trailing: Icon(Icons.feedback),
                ),
                ListTile(
                  title: Text('系统设置'),
                  trailing: Icon(Icons.settings),
                ),
                ListTile(
                  title: Text('我要发布'),
                  trailing: Icon(Icons.send),
                ),
                Divider(),
                ListTile(
                  title: Text('注销'),
                  trailing: Icon(Icons.exit_to_app),
                ),
              ],
            ),
          ),
          // 底部的tabbar
          bottomNavigationBar: Container(
              // 美化当前的container盒子
              decoration: BoxDecoration(color: Colors.black),
              // 一般高度都是50
              height: 50,
              child: TabBar(
                labelStyle: TextStyle(height: 0, fontSize: 10),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.movie_filter),
                    text: '正在热映',
                  ),
                  Tab(
                    icon: Icon(Icons.movie_creation),
                    text: '即将上映',
                  ),
                  Tab(
                    icon: Icon(Icons.local_movies),
                    text: 'Top250',
                  ),
                ],
              )),
          body: TabBarView(
            children: <Widget>[
              MovieList(mt: 'in_theaters'),
              MovieList(mt: 'coming_soon'),
              MovieList(mt: 'top250'),
            ],
          ),
        ));
  }
}
