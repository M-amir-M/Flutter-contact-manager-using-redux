import 'package:contact/redux/actions/actions.dart';
import 'package:contact/redux/middleware/middlware.dart';
import 'package:contact/redux/models/model.dart';
import 'package:redux/redux.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    contacts: contactsReducer(state.contacts, action),
    filtered: filteredReducer(state.filtered, action),
    favorites: favoritesReducer(state.favorites, action),
  );
}

///////////////
Reducer<bool> loadingReducer = combineReducers<bool>(
    [TypedReducer<bool, LoadingAction>(loadingChangeReducer)]);

bool loadingChangeReducer(bool state, action) {
  return action.loading;
}

///////////////
Reducer<Map> contactsReducer = combineReducers<Map>(
    [TypedReducer<Map, LoadedContactsAction>(loadContactsReducer)]);

Map loadContactsReducer(Map state, action) {
  state['data'] = action.contacts['data'];
  setData('contacts', state);
  return state; 
}

///////////////
Reducer<Map> filteredReducer = combineReducers<Map>(
    [TypedReducer<Map, LoadedFilteredAction>(loadFilteredReducer)]);

Map loadFilteredReducer(Map state, action) {
  return action.filtered;
}

///////////////
Reducer<List> favoritesReducer = combineReducers<List>(
    [TypedReducer<List, LoadedFavoritesContactsAction>(loadFavoritesContactsReducer)]);

List loadFavoritesContactsReducer(List state, action) {
  state = action.favorites;
  setData('favorites', state);
  return state; 
}
