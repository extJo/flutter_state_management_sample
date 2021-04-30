import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/language.dart';
import 'dart:convert';

import 'package:flutter_state_sample/view/github_trend.dart';

class LanguageDropDown extends StatefulWidget {
  LanguageDropDown({Key key}) : super(key: key);

  LanguageDropDownState createState() => LanguageDropDownState();
}

class LanguageDropDownState extends State<LanguageDropDown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/language.json'),
            builder: (BuildContext context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Text('Loading.....');
                case ConnectionState.active:
                case ConnectionState.done:
                  List<Language> languages =
                      parseJson(snapshot.data.toString());

                  return DropdownButton(
                    hint: Text("Choose Language"),
                    value: GithubTrendPage.of(context).language,
                    onChanged: (Language language) {
                      GithubTrendPage.of(context).update(language);
                    },
                    items: languages
                        .map((Language language) => DropdownMenuItem<Language>(
                              child: Text('${language.id}'),
                              value: language,
                            ))
                        .toList(),
                  );
              }
              return Text("error");
            }));
  }

  List<Language> parseJson(String input) {
    if (input == null) {
      return [];
    }
    return json
        .decode(input.toString())
        .map<Language>((item) => Language.fromJson(item))
        .toList();
  }
}
