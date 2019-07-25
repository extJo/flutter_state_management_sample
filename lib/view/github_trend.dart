import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/github_trend.dart';
import 'package:flutter_state_sample/view/lang_dropdown.dart';
import 'package:flutter_state_sample/view/trend_list_view.dart';
import 'package:provider/provider.dart';

class GithubTrendPage extends StatefulWidget {
  final Widget child;

  GithubTrendPage({Key key, this.child}) : super(key: key);

  @override
  _GithubTrendPageState createState() => _GithubTrendPageState();
}

class _GithubTrendPageState extends State<GithubTrendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Trend Sample'),
      ),
      body: ChangeNotifierProvider(
          builder: (context) => GitHubTrendModel(),
          child: Column(
            children: <Widget>[
              LanguageDropDown(),
              Expanded(child: TrendListView())
            ],
          )),
    );
  }
}
