import 'package:contact/redux/actions/actions.dart';
import 'package:contact/redux/models/model.dart';
import 'package:contact/widgets/card.dart';
import 'package:contact/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    final darkColor = Theme.of(context).primaryColorDark;
    final lightColor = Theme.of(context).primaryColorLight;

    return StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel vm) {
          List<Widget> contacts = [];
          List<Widget> favorites = [];

          if (vm.filtered != null) {
            for (var i = 0; i < vm.filtered['data'].length; i++) {
              var contact = vm.filtered['data'][i];
              int index = vm.favorites.indexOf(contact);
              contacts.add(Slidable(
                key: Key(contact['id']),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: new ContactCard(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/contact', arguments: contact);
                    },
                    viewModel: contact,
                    isFavorite: index != -1,
                    onStar: () {
                      List favorites = vm.favorites;
                      favorites..add(contact);
                      vm.onReorderdFavorites(favorites);
                    },
                  ),
                ),
                secondaryActions: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: IconButton(
                        onPressed: () {
                          vm.onDelete(contact);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/add_edit_contact',
                              arguments: contact);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ));
            }
          }
          if (vm.favorites != null) {
            for (var i = 0; i < vm.favorites.length; i++) {
              var contact = vm.favorites[i];
              int index = vm.favorites.indexOf(contact);
              favorites.add(Slidable(
                key: Key(contact['id']),
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: new ContactCard(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/contact', arguments: contact);
                    },
                    viewModel: contact,
                    isFavorite: true,
                    onStar: () {
                      List favorites = vm.favorites;
                      favorites..removeAt(index);
                      vm.onReorderdFavorites(favorites);
                    },
                  ),
                ),
                secondaryActions: <Widget>[
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: IconButton(
                        onPressed: () {
                          vm.onDelete(contact);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/add_edit_contact',
                              arguments: contact);
                        },
                        icon: Icon(Icons.edit),
                      ),
                    ),
                  ),
                ],
              ));
            }
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: SearchInput(
                onChanged: (search) {
                  vm.onFiltered(search, vm.contacts);
                },
              ),
              automaticallyImplyLeading: false,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/add_edit_contact');
              },
              child: Icon(Icons.add),
            ),
            bottomNavigationBar: TabBar(
              labelPadding: EdgeInsets.all(0),
              indicatorWeight: 0.01,
              labelColor: Colors.white,
              indicatorColor: darkColor,
              unselectedLabelColor: darkColor,
              onTap: (val) {
                print(_tabController);
                setState(() {
                  _tabController.index = val;
                });
              },
              controller: _tabController,
              tabs: [
                // Tab(
                //   text: 'All',
                // ),
                // Tab(
                //   text: 'Favorite',
                // ),
                SizedBox(
                  height: 50,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: _tabController.index == 0
                            ? darkColor
                            : Colors.white,
                        border: Border.all(color: darkColor, width: 2)),
                    child: Center(
                      child: Text('All'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: _tabController.index == 1
                            ? darkColor
                            : Colors.white,
                        border: Border.all(color: darkColor, width: 2)),
                    child: Center(
                      child: Text('Favorites'),
                    ),
                  ),
                ),
              ],
            ),
            body: vm.isLoading
                ? Center(
                    child: Image.asset(
                      'assets/images/loader.gif',
                      width: 60,
                      height: 60,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(15),
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        ReorderableListView(
                          onReorder: (oldIndex, newIndex) {
                            List prevList = vm.contacts['data'];
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final item = prevList.removeAt(oldIndex);
                            prevList.insert(newIndex, item);
                            vm.onReorderdContacts(prevList);
                          },
                          children: contacts,
                        ),
                        ReorderableListView(
                          onReorder: (oldIndex, newIndex) {
                            List prevList = vm.favorites;
                            if (newIndex > oldIndex) {
                              newIndex -= 1;
                            }
                            final item = prevList.removeAt(oldIndex);
                            prevList.insert(newIndex, item);
                            vm.onReorderdFavorites(prevList);
                          },
                          children: favorites,
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}

class _ViewModel {
  final isLoading;
  final contacts;
  final favorites;
  final filtered;
  final Function(String, Map) onFiltered;
  final Function(List) onReorderdContacts;
  final Function(List) onReorderdFavorites;
  final Function(Map) onDelete;

  _ViewModel(
      {this.contacts,
      this.onReorderdContacts,
      this.onFiltered,
      this.isLoading,
      this.onDelete,
      this.favorites,
      this.filtered,
      this.onReorderdFavorites});

  factory _ViewModel.create(Store<AppState> store) {
    onReorderdContacts(List data) {
      Map state = store.state.contacts;
      state['data'] = data;
      store.dispatch(LoadedContactsAction(state));
    }

    onDelete(Map data) {
      store.dispatch(DeleteContactAction(data));
    }

    onReorderdFavorites(List data) {
      store.dispatch(LoadedFavoritesContactsAction(data));
    }

    onFiltered(String search, contacts) {
      Map newFiltered = store.state.filtered;
      List data = [];
      for (Map item in contacts['data']) {
        bool sts = '${item['first_name']} ${item['last_name']}'
            .toLowerCase()
            .contains(search.toLowerCase());
        if (sts) {
          data.add(item);
        }
      }
      newFiltered['data'] = data;
      store.dispatch(LoadedFilteredAction(newFiltered));
    }

    return new _ViewModel(
        contacts: store.state.contacts,
        filtered: store.state.filtered,
        favorites: store.state.favorites,
        onReorderdContacts: onReorderdContacts,
        onFiltered: onFiltered,
        isLoading: store.state.isLoading,
        onDelete: onDelete,
        onReorderdFavorites: onReorderdFavorites);
  }
}
