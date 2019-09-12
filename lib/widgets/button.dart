import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double width;
  final icon;
  final bool isIconShow;
  final bool isCircle;
  final VoidCallback onPressed;

  CustomButton(
      {this.title,
      this.width = double.infinity ,
      this.onPressed = null,
      this.icon,
      this.isCircle = false,
      this.isIconShow = false});

  @override
  Widget build(BuildContext context) {
    final greenColor = Theme.of(context).primaryColorLight;
    final blueColor = Theme.of(context).primaryColorDark;
    final iconSize = 30.0;

    return Container(
      width: isCircle ? 55.0 : this.width,
      height: 55.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [greenColor, blueColor]),
        borderRadius: BorderRadius.circular(50.0),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 5.0),
          BoxShadow(
              color: blueColor.withOpacity(0.3),
              offset: Offset(0.0, 21.0),
              blurRadius: 7.0,
              spreadRadius: -10.0),
          BoxShadow(
              color: greenColor.withOpacity(0.3),
              offset: Offset(0.0, 21.0),
              blurRadius: 7.0,
              spreadRadius: -10.0)
        ],
      ),
      child: new FlatButton(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Container(),
            isCircle
                ? new Icon(
                    icon,
                    size: 23.0,
                    color: Colors.white,
                  )
                : new Text(
                    title,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w100,
                        color: Colors.white),
                  ),
            isIconShow
                ? new Icon(
                    icon,
                    size: 23.0,
                    color: Colors.white.withOpacity(0.5),
                  )
                : Container()
          ],
        ),
        onPressed: this.onPressed != null
            ? () {
                this.onPressed();
              }
            : null,
      ),
    );
  }
}
