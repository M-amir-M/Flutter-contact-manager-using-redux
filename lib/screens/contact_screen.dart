import 'dart:io';

import 'package:contact/redux/actions/actions.dart';
import 'package:contact/widgets/button.dart';
import 'package:contact/widgets/input.dart';
import 'package:uuid/uuid.dart';
import 'package:contact/redux/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class ContactScreen extends StatefulWidget {
  final Map contact;

  ContactScreen({this.contact});
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    final greenColor = Theme.of(context).primaryColorLight;
    final blueColor = Theme.of(context).primaryColorDark;
    final iconSize = 30.0;

    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        onInit: (Store<AppState> store) {},
        builder: (BuildContext context, _ViewModel vm) {
          var profile = Image.asset(
            'assets/images/avatar.png',
            fit: BoxFit.fill,
          );

          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                        '/add_edit_contact',
                        arguments: widget.contact);
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                        color: Color(0xffdddddd),
                                        borderRadius:
                                            BorderRadius.circular(100.0)),
                                    child: profile),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            color: Color(0xffdddddd),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 1,
                                                  offset: Offset(0, 0),
                                                  color: Colors.black54,
                                                  spreadRadius: 1)
                                            ]),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                          size: 15,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                          '${widget.contact["first_name"]} ${widget.contact["last_name"]}'),
                      SizedBox(
                        height: 40,
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Text('Mobile'),
                          Spacer(),
                          Text(widget.contact['phone_no'])
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                        
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.phone),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.message,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}

class _ViewModel {
  final Function(dynamic) onSaveContact;
  final contacts;
  _ViewModel({this.onSaveContact, this.contacts});

  factory _ViewModel.create(Store<AppState> store) {
    _onSaveContact(var form) {
      var uuid = new Uuid();
      var newForm;
      bool isUpdate = false;
      if (form['id'].isEmpty) {
        newForm = {
          "id": uuid.v4(),
          "first_name": form['first_name'],
          "last_name": form['first_name'],
          "phone_no": form['phone_no'],
          "gender": 'Male',
          "email": 'mem.amir.m@gmail.com',
          "date_of_birth": form['date_of_birth'],
        };
      } else {
        isUpdate = true;
        newForm = {
          "id": form['id'],
          "first_name": form['first_name'],
          "last_name": form['last_name'],
          "phone_no": form['phone_no'],
          "gender": form['gender'],
          "email": form['email'],
          "date_of_birth": form['date_of_birth'],
        };
      }

      store.dispatch(SaveContact(newForm, isUpdate));
    }

    return new _ViewModel(
        onSaveContact: _onSaveContact, contacts: store.state.contacts);
  }
}
