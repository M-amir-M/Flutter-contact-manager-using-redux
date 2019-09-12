import 'dart:convert';
import 'dart:async';
import 'package:contact/consts.dart';
import 'package:contact/utils/request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:contact/redux/actions/actions.dart';
import 'package:contact/redux/models/model.dart';
import 'package:redux/redux.dart';
import 'package:dio/dio.dart';

setData(key, value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, jsonEncode(value));
}

getData(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String data = prefs.getString(key);
  return jsonDecode(data);
}

Future<Map> loadFromPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var string = preferences.getString('auth');
  if (string != null) {
    Map map = json.decode(string);
    return map;
  }
  return {
    "name": '',
    "api_token": '',
    "mobile": '',
  };
}

Future getContacts() async {
  try {
    final response = await request('/user',
        options: new Options(method: 'GET'),
        queryParameters: {'page': 1, "row": 50});

    return response.data;
  } on DioError catch (e) {
    print(e);
  }
}

Future saveContact(contact, isUpdate) async {
  try {
    if (isUpdate) {
      final response =
          await request('/user', options: new Options(method: 'POST'));
    } else {
      final response = await request('/user/${contact["id"]}',
          options: new Options(method: 'PUT'));
    }
  } on DioError catch (e) {
    print(e.response.data);
  }
}

Future deleteContact(contact) async {
  try {
    final response = await request('/user/${contact["id"]}',
        options: new Options(method: 'DELETE'));
  } on DioError catch (e) {
    print(e.response.data);
  }
}

void appStateMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  next(action);

  if (action is DeleteContactAction) {
    store.dispatch(LoadingAction(true));
    await deleteContact(action.contact).then((state) {
      Map contacts = store.state.contacts;

      int index = contacts['data'].indexOf(action.contact);
      contacts['data'].removeAt(index);
      store.dispatch(LoadedContactsAction(contacts));
      store.dispatch(LoadedFilteredAction(contacts));
      store.dispatch(LoadingAction(false));
    });
  }

  if (action is GetContactsAction) {
    store.dispatch(LoadingAction(true));
    await getContacts().then((state) {
      store.dispatch(LoadedContactsAction(state));
      store.dispatch(LoadedFilteredAction(state));
      GlobalKeys.navigatorKey.currentState.pushReplacementNamed('/home');
      store.dispatch(LoadingAction(false));
    });
  }

  if (action is SaveContact) {
    store.dispatch(LoadingAction(true));
    await saveContact(action.contact, action.isUpdate).then((state) {
      Map contacts = store.state.contacts;
      if (action.isUpdate) {
        int index = -1;
        var find = contacts['data']
            .where((i) => i['id'] == action.contact['id'])
            .toList();
        if (find.length > 0) {
          index = contacts['data'].indexOf(find[0]);
          contacts['data'][index] = action.contact;
        }
      } else {
        contacts['data']..add(action.contact);
      }
      print('======================');
      print(contacts['data'].length);
      store.dispatch(LoadedContactsAction(contacts));
      store.dispatch(LoadedFilteredAction(contacts));
      store.dispatch(LoadingAction(false));
      GlobalKeys.navigatorKey.currentState.pushReplacementNamed('/home');
    });
  }
}
