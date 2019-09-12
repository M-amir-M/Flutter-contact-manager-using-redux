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

class ContactProfileScreen extends StatefulWidget {
  final Map contact;

  ContactProfileScreen({this.contact = null});
  @override
  _ContactProfileScreenState createState() => _ContactProfileScreenState();
}

class _ContactProfileScreenState extends State<ContactProfileScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthController = TextEditingController();
  final _mobileController = TextEditingController();

  Map<String, dynamic> _form = {
    'id': '',
    'first_name': '',
    'last_name': '',
    'date_of_birth': '',
    'email': '',
    'gender': '',
    'phone_no': '',
  };

  @override
  void initState() {
    _nameController.addListener(() {
      _form['first_name'] = _nameController.text;
    });
    _birthController.addListener(() {
      _form['date_of_birth'] = _birthController.text;
    });
    _mobileController.addListener(() {
      _form['phone_no'] = _mobileController.text;
    });

    if (widget.contact != null) {
      _form = widget.contact;
      _nameController.text = _form['first_name'];
      _mobileController.text = _form['phone_no'];
      _birthController.text = _form['date_of_birth'];
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _birthController.dispose();
    super.dispose();
  }

  _showSnackbar(String text) => _scaffoldKey.currentState?.showSnackBar(
        new SnackBar(
          content: new Text(
            text,
            style: TextStyle(fontFamily: 'is'),
          ),
        ),
      );

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
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text(
                  widget.contact == null ? 'Add Contact' : 'Edit Contact',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color.lerp(greenColor, blueColor, 1.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                automaticallyImplyLeading: false,
                centerTitle: true,
              ),
              floatingActionButton: Container(
                padding: EdgeInsets.all(15),
                child: CustomButton(
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                      vm.onSaveContact(_form);
                    }
                  },
                  title: 'Save Contact',
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              body:  vm.isLoading ?
            Center(
              child: Image.asset('assets/images/loader.gif' ,width: 60,height: 60,),
            )
             :SingleChildScrollView(
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
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              RectInput(
                                controller: _nameController,
                                textColor: blueColor,
                                labelColor: greenColor,
                                placeholder: 'Name',
                                validator: () {
                                  if (_nameController.text.isEmpty) {
                                    return 'Name is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              RectInput(
                                controller: _mobileController,
                                textColor: blueColor,
                                labelColor: greenColor,
                                placeholder: 'Mobile',
                                validator: () {
                                  if (_nameController.text.isEmpty) {
                                    return 'Mobile is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              RectInput(
                                controller: _birthController,
                                textColor: blueColor,
                                labelColor: greenColor,
                                placeholder: 'Birth Of Date',
                                validator: () {
                                  if (_nameController.text.isEmpty) {
                                    return 'Birth Of Date is required';
                                  }
                                },
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ));
        });
  }
}

class _ViewModel {
  final Function(dynamic) onSaveContact;
  final isLoading;
  final contacts;
  _ViewModel({this.onSaveContact, this.contacts,this.isLoading});

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
        onSaveContact: _onSaveContact, contacts: store.state.contacts,isLoading: store.state.isLoading);
  }
}
