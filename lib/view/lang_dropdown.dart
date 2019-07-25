import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/github_trend.dart';
import 'package:flutter_state_sample/model/language.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

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
                  return DropdownButton(
                    hint: Text("Choose Language"),
                    value: Provider.of<GitHubTrendModel>(context).language,
                    onChanged: (Language language) {
                      Provider.of<GitHubTrendModel>(context)
                          .changeLanguage(language);
                    },
                    items: parseJosn(snapshot.data.toString())
                        .map((Language language) => DropdownMenuItem<Language>(
                              child: Text('${language.name}'),
                              value: language,
                            ))
                        .toList(),
                  );
              }
              return Text("error");
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
