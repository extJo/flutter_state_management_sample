import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/github_trend.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TrendListView extends StatefulWidget {
  final Function getSearchTerm;
  TrendListView(this.getSearchTerm, {Key key}) : super(key: key);

  _TrendListViewState createState() => _TrendListViewState();
}

class _TrendListViewState extends State<TrendListView> {
  Future<List<GithubTrendItem>> githubTrend;

  @override
  void initState() {
    super.initState();
    githubTrend = getTrendList();
  }

  Widget _trendListViewItem(GithubTrendItem itemData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(itemData.avatar)
              )
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('${itemData.name}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.left, overflow: TextOverflow.ellipsis,),
              SizedBox(height: 5),
              Text('Built By : ${itemData.author}', textAlign: TextAlign.left),
              Text('Stars : ${itemData.stars}')
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTrendList(),
      builder: (BuildContext context, AsyncSnapshot<List<GithubTrendItem>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) => _trendListViewItem(snapshot.data[index])
                
              );
            } else {
              return Text('Error: ${snapshot.error}');
            }
          }
          return null;
      }
    );
  }

  Future<List<GithubTrendItem>> getTrendList() async {
    if (this.widget.getSearchTerm != null) {
      final endPoint = 'https://github-trending-api.now.sh/repositories?language=${this.widget.getSearchTerm()}&since=daily';
      final response = await http.get(endPoint);

      if (response.statusCode == 200) {
        Iterable body = json.decode(response.body);
        List<GithubTrendItem> items = body.map((value) => GithubTrendItem.fromJson(value)).toList();
        return items;
      } else {
        throw Exception('Failed to load github trend');
      }
    } else {
      return [];
    }
  }
}
