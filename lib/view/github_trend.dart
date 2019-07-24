import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/language.dart';
import 'package:flutter_state_sample/view/lang_dropdown.dart';
import 'package:flutter_state_sample/view/trend_list_view.dart';

class GithubTrendPage extends StatefulWidget {
  GithubTrendPage({Key key}) : super(key: key);

  @override
  _GithubTrendPageState createState() => _GithubTrendPageState();
}

class _GithubTrendPageState extends State<GithubTrendPage> {
  Language language;

  void setLanguage(Language language) {
    setState(() {
      this.language = language;
    });
  }

  Language getLanguage() {
    return this.language;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Trend Sample'),
      ),
      body: Column(
        children: <Widget>[
          LanguageDropDown(setLanguage),
          Expanded(child: TrendListView(getLanguage))
        ],
      )
    );
  }
}
