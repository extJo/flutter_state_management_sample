import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/language.dart';
import 'package:flutter_state_sample/view/lang_dropdown.dart';
import 'package:flutter_state_sample/view/trend_list_view.dart';

class InheritedGithubTrendPage extends InheritedWidget {
  final _GithubTrendPageState trendPageState;

  InheritedGithubTrendPage({
    Key key,
    @required this.trendPageState,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedGithubTrendPage oldWidget) => true;
}

class GithubTrendPage extends StatefulWidget {
  final Widget child;

  GithubTrendPage({Key key, this.child}) : super(key: key);

  @override
  _GithubTrendPageState createState() => _GithubTrendPageState();

  static _GithubTrendPageState of(BuildContext context) {
    final InheritedGithubTrendPage page =
        context.dependOnInheritedWidgetOfExactType<InheritedGithubTrendPage>();
    return page.trendPageState;
  }
}

class _GithubTrendPageState extends State<GithubTrendPage> {
  Language language;

  @override
  void initState() {
    super.initState();
  }

  void update(Language newLanguage) {
    setState(() {
      language = newLanguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedGithubTrendPage(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Github Trend Sample'),
          ),
          body: Column(
            children: <Widget>[
              LanguageDropDown(),
              Expanded(child: TrendListView())
            ],
          )),
      trendPageState: this,
    );
  }
}
