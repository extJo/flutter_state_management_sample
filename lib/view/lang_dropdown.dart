import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/language.dart';
import 'dart:convert';

class LanguageDropDown extends StatefulWidget {
  final Function setLanguage;

  LanguageDropDown(this.setLanguage, {Key key}) : super(key: key);

  LanguageDropDownState createState() => LanguageDropDownState();
}

class LanguageDropDownState extends State<LanguageDropDown> {
  String selectedLanguage;

  @override
  void initState() {
    super.initState();
  }

  void _dropDownSelect(String languageId) {
    setState(() {
      selectedLanguage = languageId;
    });
    widget.setLanguage(selectedLanguage);
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
                hint: Text(languages[0].name),
                value: selectedLanguage,
                onChanged: _dropDownSelect,
                items: languages
                    .map((Language language) => DropdownMenuItem<String>(
                          child: Text('${language.name}'),
                          value: language.id,
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
