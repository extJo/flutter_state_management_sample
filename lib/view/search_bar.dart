import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function setSearchTerm;

  SearchBar(this.setSearchTerm, {Key key}) : super(key: key);

  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final textFieldController = TextEditingController();

  @override
  void initState() { 
    super.initState();
    
    textFieldController.addListener(_changeText);
  }

  _changeText() {
    widget.setSearchTerm(textFieldController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
        controller: this.textFieldController
      ),
    );
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }
}
