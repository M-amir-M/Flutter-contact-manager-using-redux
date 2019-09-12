import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onChanged;

  SearchInput({this.onChanged});

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  final TextEditingController locationSearchTextController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final darkColor = Theme.of(context).primaryColorDark;
    final lightColor = Theme.of(context).primaryColorLight;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: darkColor,
      ),
      child: TextField(
        onChanged: (search) {
          widget.onChanged(search);
        },
        controller: locationSearchTextController,
        cursorColor: lightColor,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 2),
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          hintText: 'Search...',
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }
}
