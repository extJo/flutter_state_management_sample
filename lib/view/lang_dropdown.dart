import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/language.dart';
import 'dart:convert';

class LanguageDropDown extends StatefulWidget {
  final Function setLanguage;

  LanguageDropDown(this.setLanguage, {Key key}) : super(key: key);

  LanguageDropDownState createState() => LanguageDropDownState();
}

class LanguageDropDownState extends State<LanguageDropDown> {
  Language selectedLanguage;

  @override
  void initState() {
    super.initState();
  }

  void _dropDownSelect(Language language) {
    setState(() {
      selectedLanguage = language;
    });
    widget.setLanguage(language);
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
                      parseJosn(snapshot.data.toString());

                  return DropdownButton(
                    hint: Text(languages[0].name),
                    value: selectedLanguage,
                    onChanged: _dropDownSelect,
                    items: languages
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
