import 'package:flutter/material.dart';
import 'package:flutter_state_sample/view/search_bar.dart';
import 'package:flutter_state_sample/view/trend_list_view.dart';

class GithubTrendPage extends StatefulWidget {
  GithubTrendPage({Key key}) : super(key: key);

  @override
  _GithubTrendPageState createState() => _GithubTrendPageState();
}

class _GithubTrendPageState extends State<GithubTrendPage> {
  String searchTerm;

  void setSearchTerm(String term) {
    setState(() {
      this.searchTerm = term;
    });
  }

  String getSearchTerm() {
    return this.searchTerm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Trend Sample'),
      ),
      body: Column(
        children: <Widget>[
          SearchBar(setSearchTerm),
          Expanded(child: TrendListView(getSearchTerm))
        ],
      )
    );
  }
}
