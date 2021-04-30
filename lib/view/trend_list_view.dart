import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/github_trend_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/language.dart';
import 'github_trend.dart';

class TrendListView extends StatefulWidget {
  TrendListView({Key key}) : super(key: key);

  _TrendListViewState createState() => _TrendListViewState();
}

class _TrendListViewState extends State<TrendListView> {
  Widget _trendListViewItem(GithubTrendItem itemData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Container(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  width: 70.0,
                  height: 70.0,
                  decoration: itemData.avatars.isNotEmpty
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(itemData.avatars[0])))
                      : BoxDecoration())),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${itemData.repo}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text('Stars : ${itemData.stars}')
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTrendList(GithubTrendPage.of(context).language),
        builder: (BuildContext context,
            AsyncSnapshot<List<GithubTrendItem>> snapshot) {
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
                    itemBuilder: (BuildContext context, int index) =>
                        _trendListViewItem(snapshot.data[index]));
              } else if (snapshot.data.isEmpty) {
                return Center(child: Text('No Results'));
              } else {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
          }
          return Text("error");
        });
  }

  Future<List<GithubTrendItem>> getTrendList(Language language) async {
    if (language != null) {
      final endPoint =
          'https://trendings.herokuapp.com/repo?lang=${language.id}&since=weekly';
      final response = await http.get(Uri.parse(endPoint));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> body = json.decode(response.body);
        Iterable items = body["items"];
        return items.map((value) => GithubTrendItem.fromJson(value)).toList();
      } else {
        throw Exception('Failed to load github trend');
      }
    } else {
      return [];
    }
  }
}
