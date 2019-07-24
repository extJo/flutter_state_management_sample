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
              List<Language> languages = parseJosn(snapshot.data.toString());

              return DropdownButton(
                // hint: Text(languages[0].name),
                value: GithubTrendPage.of(context).language,
                onChanged: (Language language) {
                  GithubTrendPage.of(context).update(language);
                },
                items: languages
                    .map((Language language) => DropdownMenuItem<Language>(
                          child: Text('${language.name}'),
                          value: language,
                        ))
                    .toList(),
              );
            }));
  }

  List<Language> parseJosn(String response) {
    if (response == null) {
      return [];
    }
    final parsed = json.decode(response.toString());
    return parsed.map<Language>((json) => Language.fromJson(json)).toList();
  }
}
