import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import './detail.dart';

Dio dio = new Dio();

class MovieList extends StatefulWidget {
  // 固定写法
  // MovieList({Key key}) : super(key: key);
  MovieList({Key key, @required this.mt}) : super(key: key);

  // 电影类型
  final String mt;

  @override
  _MovieListState createState() {
    return _MovieListState();
  }
}

// 有状态控件，必须结合一个状态管理类，来进行实现
class _MovieListState extends State<MovieList> with AutomaticKeepAliveClientMixin {
  // 默认显示第一页数据
  int page = 1;
  // 每页显示的数据条数
  int pagesize = 10;
  // 总数据条数，实现分页效果
  var total = 0;
  // 电影列表数据
  var mlist = [];

  @override
  bool get wantKeepAlive => true;

  // 控件被创建的时候，会执行initState
  @override
  void initState() {
    super.initState();
    getMovieList();
  }

  // 渲染当前这个MovieList控件的UI结构
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mlist.length,
      itemBuilder: (BuildContext ctx, int i) {
        // 每次循环，都拿到当前的电影item项
        var mitem = mlist[i];
        return GestureDetector(
            onTap: () {
              // 跳转到详情
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext ctx) {
                return MovieDetail(id: mitem['id'], title: mitem['title']);
              }));
            },
            child: Container(
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.black12))),
                child: Row(
                  children: <Widget>[
                    Image.network(mitem['images']['small'],
                        width: 130, height: 180, fit: BoxFit.cover),
                    Container(
                      height: 200,
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text('电影名称：${mitem['title']}'),
                          Text('上映年份：${mitem['year']}'),
                          Text('电影类型：${mitem['genres'].join('，')}'),
                          Text('豆瓣评分：${mitem['rating']['average']}'),
                          Text('主要演员：${mitem['title']}'),
                        ],
                      ),
                    )
                  ],
                )));
      },
    );
  }

  // 获取电影列表数据
  getMovieList() async {
    // 偏移量的计算公式 (page-1)*pagesize
    int offser = (page - 1) * pagesize;
    var res = await dio.get(
        'http://www.liulongbin.top:3005/api/v2/movie/${widget.mt}?start=$offser&count=$pagesize');

    var data = res.data;
    print(data);

    // 今后只要为私有数据赋值，都需要把赋值的操作，放在setState函数中，否则，页面不会更新
    setState(() {
      // 通过dio返回的数据，必须使用[]来访问
      mlist = data['subjects'];
      total = data['total'];
    });
  }
}
