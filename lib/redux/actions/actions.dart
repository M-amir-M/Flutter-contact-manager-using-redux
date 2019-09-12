import 'package:contact/redux/models/model.dart';

class LoadingAction {
  final bool loading;
  LoadingAction(this.loading);
}

class GetEditContactAction {
  final int editContactId;
  GetEditContactAction(this.editContactId);
}

class DeleteContactAction {
  final Map contact;
  DeleteContactAction(this.contact);
}

class GetContactsAction {}

class LoadedContactsAction {
  final Map contacts;

  LoadedContactsAction(this.contacts);
}

class LoadedFilteredAction {
  final Map filtered;

  LoadedFilteredAction(this.filtered);
}

class LoadedFavoritesContactsAction {
  final List favorites;

  LoadedFavoritesContactsAction(this.favorites);
}

class SaveContact {
  final bool isUpdate;
  final Map<String, dynamic> contact;

  SaveContact(this.contact,this.isUpdate);
}
