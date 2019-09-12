import 'dart:ui';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final Map viewModel;
  final bool isFavorite;
  VoidCallback onStar;
  VoidCallback onTap;

  ContactCard(
      {Key key,
      this.viewModel,
      this.isFavorite = false,
      this.onStar = null,
      this.onTap = null})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final greenColor = Theme.of(context).primaryColorLight;
    final blueColor = Theme.of(context).primaryColorDark;
    final size = MediaQuery.of(context).size;

    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0.0, 10.0),
                  blurRadius: 10.0)
            ],
            border: Border.all(color: greenColor.withOpacity(0.3), width: 2.0)),
        child: Container(
          padding: EdgeInsets.all(5),
          height: 80,
          child: Stack(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      this.onTap();
                    },
                    child: Container(
                        // color: Colors.grey,
                        child: new ClipRRect(
                      borderRadius: new BorderRadius.all(Radius.circular(60.0)),
                      child: Container(
                        height: 70,
                        width: 70,
                        color: Colors.grey[200],
                        child: Image.asset(
                          'assets/images/avatar.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    )),
                  ),
                  GestureDetector(
                    onTap: () {
                      this.onTap();
                    },
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            viewModel['first_name'] ?? '',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: blueColor,
                                fontSize: 15.0),
                          ),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  viewModel['last_name'] ?? '',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 13.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        this.onStar();
                      },
                      icon: Icon(isFavorite ? Icons.star : Icons.star_border),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
